import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ebirth/core/constants/api_constants.dart';
import 'package:ebirth/core/error/exceptions.dart';
import 'package:ebirth/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String nationalId,
    required String phoneNumber,
    required String birthDate,
    required String village,
    required String city,
    required int gender,
    required int governorate,
    required int bloodType,
  });

  Future<UserModel> createDoctor({
    required String name,
    required String email,
    required String password,
    required String nationalId,
    required String phoneNumber,
    required String birthDate,
    required String village,
    required String city,
    required int gender,
    required int governorate,
    required int bloodType,
    required String attachmentPath,
  });

  Future<void> forgotPassword({required String emailOrNationalId});

  Future<void> verifyOtp({
    required String emailOrNationalId,
    required String otp,
  });

  Future<void> resetPassword({
    required String emailOrNationalId,
    required String otp,
    required String newPassword,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        ApiConstants.login,
        data: {'EmailOrNationalId': email, 'Password': password},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      dynamic data = response.data;
      if (data is String) data = jsonDecode(data);

      if (response.statusCode == 200) {
        if (data['isSuccess'] == true) {
          final token = data['data']['token'] as String;
          // Decode JWT to extract real name, ID, and role
          return UserModel.fromToken(token: token, email: email);
        } else {
          final errors = data['errors'];
          throw ServerException(
            message: errors is List
                ? errors.first.toString()
                : errors.toString(),
          );
        }
      } else {
        throw const ServerException(message: 'Invalid credentials');
      }
    } on DioException catch (e) {
      final data = e.response?.data;
      final message = (data is Map) ? data['message'] : 'Server error occurred';
      throw ServerException(message: message is List ? message.first : message);
    } catch (e) {
      throw const ServerException(message: 'Unexpected error occurred');
    }
  }

  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String nationalId,
    required String phoneNumber,
    required String birthDate,
    required String village,
    required String city,
    required int gender,
    required int governorate,
    required int bloodType,
  }) async {
    try {
      final response = await dio.post(
        ApiConstants.register,
        data: {
          "FullName": name,
          "Email": email,
          "Passworded": password,
          "ConfirmPassworded": password,
          "NationalId": nationalId,
          "PhoneNumber": phoneNumber,
          "BirthDate": birthDate,
          "Village": village,
          "City": city,
          "Gender": gender,
          "Governorate": governorate,
          "BloodType": bloodType,
        },
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      dynamic data = response.data;
      if (data is String) data = jsonDecode(data);

      if (response.statusCode == 201 || response.statusCode == 200) {
        if (data['isSuccess'] == true) {
          final userData = data['data'];
          return UserModel(
            id: userData?['id']?.toString() ?? 'id',
            name: userData?['name'] ?? name,
            email: userData?['email'] ?? email,
            token: userData?['token'] ?? 'registration_token',
            role: 'Parent', // New users are always Parents
          );
        } else {
          final errors = data['errors'];
          throw ServerException(
            message: errors is List
                ? errors.first.toString()
                : errors?.toString() ?? 'Registration failed',
          );
        }
      } else {
        throw const ServerException(message: 'Failed to create account');
      }
    } on DioException catch (e) {
      final data = e.response?.data;
      final message = (data is Map)
          ? data['errors'] ?? data['message']
          : 'Server error occurred';
      throw ServerException(message: message is List ? message.first : message);
    } catch (e) {
      if (e is ServerException) rethrow;
      throw const ServerException(message: 'Unexpected error occurred');
    }
  }

  @override
  Future<UserModel> createDoctor({
    required String name,
    required String email,
    required String password,
    required String nationalId,
    required String phoneNumber,
    required String birthDate,
    required String village,
    required String city,
    required int gender,
    required int governorate,
    required int bloodType,
    required String attachmentPath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'FullName': name,
        'Email': email,
        'Passworded': password,
        'ConfirmPassworded': password,
        'NationalId': nationalId,
        'PhoneNumber': phoneNumber,
        'BirthDate': birthDate,
        'Village': village,
        'City': city,
        'Gender': gender.toString(),
        'Governorate': governorate.toString(),
        'BloodType': bloodType.toString(),
        'DoctorAttachment': await MultipartFile.fromFile(
          attachmentPath,
          filename: attachmentPath.split('/').last,
        ),
      });

      final response = await dio.post(
        ApiConstants.createDoctor,
        data: formData,
      );

      dynamic data = response.data;
      if (data is String) data = jsonDecode(data);

      if (response.statusCode == 201 || response.statusCode == 200) {
        if (data['isSuccess'] == true) {
          return UserModel(
            id: '',
            name: name,
            email: email,
            token: '',
            role: 'Doctor',
          );
        } else {
          final errors = data['errors'];
          throw ServerException(
            message: errors is List
                ? errors.first.toString()
                : errors?.toString() ?? 'Registration failed',
          );
        }
      } else {
        throw const ServerException(message: 'Failed to register doctor');
      }
    } on DioException catch (e) {
      final data = e.response?.data;
      final message = (data is Map)
          ? data['errors'] ?? data['message']
          : 'Server error occurred';
      throw ServerException(message: message is List ? message.first : message);
    } catch (e) {
      if (e is ServerException) rethrow;
      throw const ServerException(message: 'Unexpected error occurred');
    }
  }

  @override
  Future<void> forgotPassword({required String emailOrNationalId}) async {
    try {
      await dio.post(
        ApiConstants.forgotPassword,
        data: '"$emailOrNationalId"', // API expects raw JSON string
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
    } on DioException catch (e) {
      final data = e.response?.data;
      dynamic message = (data is Map)
          ? data['message']
          : 'Failed to send reset email';
      throw ServerException(message: message is List ? message.first : message);
    } catch (e) {
      if (e is ServerException) rethrow;
      throw const ServerException(message: 'Failed to send reset email');
    }
  }

  @override
  Future<void> verifyOtp({
    required String emailOrNationalId,
    required String otp,
  }) async {
    try {
      final response = await dio.post(
        ApiConstants.verifyOtp,
        data: {'Email': emailOrNationalId, 'Otp': otp},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      dynamic data = response.data;
      if (data is String) data = jsonDecode(data);

      if (response.statusCode == 200 &&
          (data['isSuccess'] == true || data['isSucceeded'] == true)) {
        return;
      } else {
        final errors = data['errors'];
        String errorMessage = 'Invalid OTP code';
        if (errors is Map) {
          errorMessage = errors.values.first is List
              ? errors.values.first.first.toString()
              : errors.values.first.toString();
        } else if (errors is List) {
          errorMessage = errors.first.toString();
        } else if (data['message'] != null) {
          errorMessage = data['message'].toString();
        }
        throw ServerException(message: errorMessage);
      }
    } on DioException catch (e) {
      final data = e.response?.data;
      String message = 'OTP verification failed';
      if (data is Map) {
        if (data['errors'] != null && data['errors'] is Map) {
          final errors = data['errors'] as Map;
          message = errors.values.first is List
              ? errors.values.first.first.toString()
              : errors.values.first.toString();
        } else if (data['message'] != null) {
          message = data['message'].toString();
        } else if (data['title'] != null) {
          message = data['title'].toString();
        }
      }
      throw ServerException(message: message);
    } catch (e) {
      if (e is ServerException) rethrow;
      throw const ServerException(message: 'OTP verification failed');
    }
  }

  @override
  Future<void> resetPassword({
    required String emailOrNationalId,
    required String otp,
    required String newPassword,
  }) async {
    try {
      final response = await dio.post(
        ApiConstants.resetPassword,
        data: {
          'Email': emailOrNationalId,
          'Otp': otp,
          'Password': newPassword,
          'ConfirmPassword': newPassword,
        },
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      dynamic data = response.data;
      if (data is String) data = jsonDecode(data);

      if (response.statusCode == 200 &&
          (data['isSuccess'] == true || data['isSucceeded'] == true)) {
        return;
      } else {
        final errors = data['errors'];
        String errorMessage = 'Password reset failed';
        if (errors is Map) {
          errorMessage = errors.values.first is List
              ? errors.values.first.first.toString()
              : errors.values.first.toString();
        } else if (errors is List) {
          errorMessage = errors.first.toString();
        } else if (data['message'] != null) {
          errorMessage = data['message'].toString();
        }
        throw ServerException(message: errorMessage);
      }
    } on DioException catch (e) {
      final data = e.response?.data;
      String message = 'Password reset failed';
      if (data is Map) {
        if (data['errors'] != null && data['errors'] is Map) {
          final errors = data['errors'] as Map;
          message = errors.values.first is List
              ? errors.values.first.first.toString()
              : errors.values.first.toString();
        } else if (data['message'] != null) {
          message = data['message'].toString();
        } else if (data['title'] != null) {
          message = data['title'].toString();
        }
      }
      throw ServerException(message: message);
    } catch (e) {
      if (e is ServerException) rethrow;
      throw const ServerException(message: 'Password reset failed');
    }
  }
}
