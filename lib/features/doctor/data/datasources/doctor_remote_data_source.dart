import 'package:dio/dio.dart';
import 'package:ebirth/core/constants/api_constants.dart';
import 'package:ebirth/core/error/exceptions.dart';
import 'package:ebirth/features/doctor/data/models/doctor_dashboard_model.dart';
import 'package:ebirth/features/doctor/data/models/doctor_profile_model.dart';
import 'package:ebirth/features/parent/data/models/child_model.dart';

abstract class DoctorRemoteDataSource {
  Future<DoctorDashboardModel> getDoctorDashboardData(String userId);
  Future<ChildModel> searchChild(String nationalId);
  Future<void> addChildMedicalRecord({
    required int childId,
    required String medicine,
    required String description,
    required List<String> imagePaths,
  });
  Future<DoctorProfileModel> getDoctorProfile(String userId);
}

class DoctorRemoteDataSourceImpl implements DoctorRemoteDataSource {
  final Dio dio;

  DoctorRemoteDataSourceImpl({required this.dio});

  @override
  Future<DoctorDashboardModel> getDoctorDashboardData(String userId) async {
    try {
      print('[DoctorRemoteDataSource] Fetching data for userId: $userId');
      final response = await dio.post(
        ApiConstants.getDoctorForDashboard,
        data: '"$userId"',
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      print(
        '[DoctorRemoteDataSource] Response received: ${response.statusCode}',
      );
      print('[DoctorRemoteDataSource] Response Data: ${response.data}');

      if (response.data != null && response.data['isSuccess'] == true) {
        final dynamic rawData = response.data['data'];
        Map<String, dynamic>? doctorJson;
        List<dynamic> childrenJson = [];

        if (rawData is List) {
          doctorJson = rawData.firstWhere(
            (e) => e['role'] == 'Doctor' || e['role'] == 'Parent',
            orElse: () => rawData.isNotEmpty ? rawData.first : null,
          );
          childrenJson = rawData.where((e) => e['role'] == 'Child').toList();
        } else if (rawData is Map<String, dynamic>) {
          doctorJson = rawData;
        }

        if (doctorJson == null) {
          throw ServerException(message: 'بيانات الطبيب غير موجودة في الـ API');
        }

        print('========== RAW DOCTOR JSON FROM DASHBOARD ==========');
        print(doctorJson);
        print('====================================================');

        return DoctorDashboardModel(
          id: doctorJson['id'] ?? 0,
          fullName: doctorJson['fullName'] ?? doctorJson['name'] ?? '',
          role: doctorJson['role'] ?? 'Doctor',
          children: childrenJson.map((c) => ChildModel.fromJson(c)).toList(),
        );
      } else {
        final msg =
            response.data?['errors']?.toString() ??
            'فشل في جلب بيانات لوحة التحكم';
        throw ServerException(message: msg);
      }
    } on DioException catch (e) {
      print('[DoctorRemoteDataSource] DioError: ${e.message}');
      throw ServerException(
        message: e.message ?? 'حدث خطأ في الاتصال بالسيرفر',
      );
    } catch (e, stack) {
      print('[DoctorRemoteDataSource] Unexpected Error: $e');
      print('[DoctorRemoteDataSource] StackTrace: $stack');
      throw ServerException(message: 'حدث خطأ غير متوقع في معالجة البيانات');
    }
  }

  @override
  Future<ChildModel> searchChild(String nationalId) async {
    try {
      print(
        '[DoctorRemoteDataSource] Searching for child with National ID: $nationalId',
      );
      final response = await dio.post(
        ApiConstants.searchChild,
        data: '"$nationalId"',
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      print('[DoctorRemoteDataSource] Search Response: ${response.data}');

      if (response.data != null && response.data['isSuccess'] == true) {
        final dynamic rawData = response.data['data'];

        Map<String, dynamic>? childJson;

        if (rawData is Map<String, dynamic>) {
          final type = rawData['type'];
          if (type == 'Child' && rawData['childDetails'] != null) {
            childJson = Map<String, dynamic>.from(rawData['childDetails']);
            childJson['userType'] = 'Child';
          } else if (type == 'Parent' && rawData['parentDetails'] != null) {
            childJson = Map<String, dynamic>.from(rawData['parentDetails']);
            // Map parent-specific keys to be compatible with ChildModel
            childJson['id'] = childJson['parentId'] ?? 0;
            childJson['fullName'] = childJson['fullName'] ?? '';
            childJson['childNationalId'] =
                childJson['nationalId']; // Map nationalId to childNationalId
            childJson['userType'] = 'Parent';
          }
        } else if (rawData is List && rawData.isNotEmpty) {
          // Fallback for older list-style responses if they still exist
          childJson = rawData.first as Map<String, dynamic>;
        }

        if (childJson == null) {
          throw ServerException(
            message: 'لم يتم العثور على بيانات لهذا الرقم القومي',
          );
        }

        return ChildModel.fromJson(childJson);
      } else {
        throw ServerException(
          message: response.data?['errors']?.toString() ?? 'فشل البحث عن الطفل',
        );
      }
    } on DioException catch (e) {
      print('[DoctorRemoteDataSource] Search DioError: ${e.message}');
      
      // Handle 404 specifically as "Not Registered"
      if (e.response?.statusCode == 404) {
        throw const ServerException(message: 'هذا الرقم القومي غير مسجل بالنظام');
      }
      
      throw ServerException(message: e.message ?? 'خطأ في الاتصال بالسيرفر');
    } catch (e, stack) {
      print('====================================================');
      print('[DoctorRemoteDataSource] EXCEPTION CAUGHT!');
      print('[DoctorRemoteDataSource] Error: $e');
      print('[DoctorRemoteDataSource] StackTrace: $stack');
      print('====================================================');
      throw ServerException(message: 'حدث خطأ: ${e.toString()}');
    }
  }

  @override
  Future<void> addChildMedicalRecord({
    required int childId,
    required String medicine,
    required String description,
    required List<String> imagePaths,
  }) async {
    try {
      print('[DoctorRemoteDataSource] Adding medical record for child: $childId');
      
      final Map<String, dynamic> dataMap = {
        'childId': childId.toString(),
        'title': medicine,
        'medicine': medicine,
        'description': description,
        'date': DateTime.now().toIso8601String().split('T')[0],
      };

      // Add images
      if (imagePaths.isNotEmpty) {
        if (imagePaths.length == 1) {
          dataMap['userMedicalImages'] = await MultipartFile.fromFile(
            imagePaths[0],
            filename: imagePaths[0].split('/').last,
          );
        } else {
          final List<MultipartFile> files = [];
          for (final path in imagePaths) {
            files.add(await MultipartFile.fromFile(
              path,
              filename: path.split('/').last,
            ));
          }
          dataMap['userMedicalImages'] = files;
        }
      }

      final formData = FormData.fromMap(dataMap);

      final response = await dio.post(
        ApiConstants.addChildMedicalRecord,
        data: formData,
      );

      if (response.data == null || response.data['isSuccess'] != true) {
        throw ServerException(
          message: response.data?['errors']?.toString() ?? 'فشل إضافة السجل الطبي',
        );
      }
    } on DioException catch (e) {
      final errorData = e.response?.data;
      print('[DoctorRemoteDataSource] Add Record Error Response: $errorData');
      throw ServerException(
        message: errorData?['errors']?.toString() ?? e.message ?? 'خطأ في الاتصال بالسيرفر',
      );
    }
  }

  @override
  Future<DoctorProfileModel> getDoctorProfile(String userId) async {
    try {
      final response = await dio.post(
        ApiConstants.getDoctorDetails,
        data: '"$userId"',
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.data != null && response.data['isSuccess'] == true) {
        final dynamic data = response.data['data'];
        
        if (data == null) {
          throw ServerException(message: 'بيانات الطبيب غير موجودة');
        }

        return DoctorProfileModel.fromJson(data);
      } else {
        throw ServerException(
          message: response.data?['errors']?.toString() ?? 'فشل جلب ملف الطبيب التفصيلي',
        );
      }
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? 'خطأ في الاتصال');
    } catch (e) {
      throw ServerException(message: 'حدث خطأ غير متوقع أثناء جلب البيانات');
    }
  }
}
