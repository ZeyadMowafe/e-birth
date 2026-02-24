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
  });

  Future<void> forgotPassword({required String email});

  Future<void> verifyOtp({required String email, required String otp});

  Future<void> resetPassword({
    required String email,
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
        data: {'email': email, 'password': password},
      );

      dynamic data = response.data;
      if (data is String) data = jsonDecode(data);

      if (response.statusCode == 201 || response.statusCode == 200) {
        return UserModel(
          id: 'platzi-user',
          name: 'Platzi User',
          email: email,
          token: data['access_token'],
        );
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
  }) async {
    try {
      final response = await dio.post(
        ApiConstants.register,
        data: {
          "name": name,
          "email": email,
          "password": password,
          "avatar": "https://api.dicebear.com/7.x/avataaars/svg?seed=$name",
        },
      );

      dynamic data = response.data;
      if (data is String) data = jsonDecode(data);

      if (response.statusCode == 201 || response.statusCode == 200) {
        return UserModel(
          id: data['id'].toString(),
          name: data['name'],
          email: data['email'],
          token: 'registration_success_token',
        );
      } else {
        throw const ServerException(message: 'Failed to create account');
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
  Future<void> forgotPassword({required String email}) async {
    try {
      // Prepared for real backend:
      // await dio.post(ApiConstants.forgotPassword, data: {'email': email});

      await Future.delayed(const Duration(seconds: 1));
      return;
    } catch (e) {
      throw const ServerException(message: 'Failed to send reset email');
    }
  }

  @override
  Future<void> verifyOtp({required String email, required String otp}) async {
    try {
      // Prepared for real backend:
      // await dio.post(ApiConstants.verifyOtp, data: {'email': email, 'otp': otp});

      await Future.delayed(const Duration(seconds: 1));
      if (otp == '1234') {
        return;
      } else {
        throw const ServerException(message: 'Invalid OTP code');
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw const ServerException(message: 'OTP verification failed');
    }
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    try {
      // Example of using relative path with Get:
      final usersResponse = await dio.get(
        ApiConstants.register, // In Platzi, users endpoint is used for search
        queryParameters: {'email': email},
      );

      if (usersResponse.statusCode != 200) {
        throw const ServerException(message: 'Failed to reach server');
      }

      final users = usersResponse.data as List<dynamic>;

      if (users.isEmpty) {
        throw const ServerException(
          message: 'No account found with this email',
        );
      }

      await Future.delayed(const Duration(milliseconds: 500));
      return;
    } on DioException catch (e) {
      final data = e.response?.data;
      String message = 'Server error occurred';
      if (data is Map && data['message'] != null) {
        final msg = data['message'];
        message = msg is List ? msg.first.toString() : msg.toString();
      }
      throw ServerException(message: message);
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
