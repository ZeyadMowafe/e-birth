import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../models/parent_model.dart';
import '../models/child_model.dart';
import '../models/vaccination_model.dart';
import '../models/vaccination_model.dart';
import '../models/medical_history_model.dart';
import '../models/parent_details_model.dart';
import 'parent_remote_data_source.dart';

class ParentRemoteDataSourceImpl implements ParentRemoteDataSource {
  final Dio dio;

  ParentRemoteDataSourceImpl({required this.dio});

  @override
  Future<ParentModel> getParentWithChildren(String parentId) async {
    try {
      final response = await dio.post(
        ApiConstants.getParentWithChildren,
        data:
            '"$parentId"', // As per Postman collection, ID is sent as a raw string
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.data != null && response.data['isSuccess'] == true) {
        final dataList = response.data['data'] as List;

        // Find parent object
        final parentJson = dataList.firstWhere(
          (e) => e['role'] == 'Parent',
          orElse: () => null,
        );

        if (parentJson == null) {
          throw ServerException(message: 'بيانات ولي الأمر غير موجودة');
        }

        // Print raw parent data to console so the user can see all available fields
        print('========== RAW PARENT JSON FROM API ==========');
        print(parentJson);
        print('==============================================');

        // Find child objects
        final childrenJson = dataList
            .where((e) => e['role'] == 'Child')
            .toList();

        return ParentModel(
          id: parentJson['id'] ?? 0,
          fullName: parentJson['fullName'] ?? '',
          email: '', // Not strictly needed based on API returned payload
          phoneNumber: '', // Not strictly needed
          children: childrenJson.map((c) => ChildModel.fromJson(c)).toList(),
        );
      } else {
        throw ServerException(message: 'فشل في جلب البيانات.');
      }
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? 'حدث خطأ في الاتصال بالخادم');
    }
  }

  @override
  Future<ParentDetailsModel> getParentDetails(String parentId) async {
    try {
      final response = await dio.post(
        ApiConstants.getParentDetails,
        data: '"$parentId"',
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.data != null && response.data['isSuccess'] == true) {
        final data = response.data['data'];
        if (data != null) {
          return ParentDetailsModel.fromJson(data);
        } else {
          throw ServerException(message: 'بيانات الحساب غير موجودة');
        }
      } else {
        throw ServerException(message: 'فشل في جلب البيانات.');
      }
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? 'Server error occurred');
    }
  }

  @override
  Future<ChildModel> getChildDetails(String childId) async {
    try {
      final response = await dio.post(
        ApiConstants.getChildDetails,
        data: '"$childId"',
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      if (response.data != null && response.data['isSuccess'] == true) {
        return ChildModel.fromJson(response.data['data']);
      } else {
        throw ServerException(message: 'Failed to load child details.');
      }
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? 'Server error occurred');
    }
  }

  @override
  Future<List<VaccinationModel>> getChildVaccinations(String childId) async {
    try {
      final response = await dio.post(
        ApiConstants.getChildVaccinations,
        data: '"$childId"',
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.data != null && response.data['isSuccess'] == true) {
        final data = response.data['data'];
        if (data != null && data['vaccinations'] != null) {
          final vaccinationsList = data['vaccinations'] as List;
          return vaccinationsList
              .map((item) => VaccinationModel.fromJson(item))
              .toList();
        }
        return [];
      } else {
        return []; // Or throw an exception
      }
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? 'Server error occurred');
    }
  }

  @override
  Future<List<MedicalHistoryModel>> getChildMedicalHistory(
    String childId,
  ) async {
    try {
      final response = await dio.post(
        ApiConstants.getChildMedicalHistory,
        data: '"$childId"',
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.data != null && response.data['isSuccess'] == true) {
        final data = response.data['data'];
        if (data != null && data['medicalHistory'] != null) {
          final historyList = data['medicalHistory'] as List;
          return historyList
              .map((item) => MedicalHistoryModel.fromJson(item))
              .toList();
        }
        return [];
      } else {
        return [];
      }
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? 'Server error occurred');
    }
  }

  @override
  Future<List<MedicalHistoryModel>> getParentMedicalHistory(
    String parentId,
  ) async {
    try {
      final response = await dio.post(
        ApiConstants.getParentMedicalHistory,
        data: '"$parentId"',
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.data != null && response.data['isSuccess'] == true) {
        final data = response.data['data'];
        if (data != null && data['medicalHistory'] != null) {
          final historyList = data['medicalHistory'] as List;
          return historyList
              .map((item) => MedicalHistoryModel.fromJson(item))
              .toList();
        }
        return [];
      } else {
        return [];
      }
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? 'Server error occurred');
    }
  }

  @override
  Future<MedicalHistoryModel> getSpecificChildMedicalHistory(
    String medicalRecordId,
  ) async {
    try {
      final response = await dio.post(
        ApiConstants.getSpecificChildMedicalHistory,
        data: '"$medicalRecordId"',
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.data != null && response.data['isSuccess'] == true) {
        return MedicalHistoryModel.fromJson(response.data['data']);
      } else {
        throw ServerException(message: 'فشل في جلب السجل الطبي المحدد.');
      }
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? 'Server error occurred');
    }
  }

  @override
  Future<MedicalHistoryModel> getSpecificParentMedicalHistory(
    String medicalRecordId,
  ) async {
    try {
      final response = await dio.post(
        ApiConstants.getSpecificParentMedicalHistory,
        data: '"$medicalRecordId"',
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.data != null && response.data['isSuccess'] == true) {
        return MedicalHistoryModel.fromJson(response.data['data']);
      } else {
        throw ServerException(message: 'فشل في جلب السجل الطبي المحدد.');
      }
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? 'Server error occurred');
    }
  }
}
