import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:ebirth/core/error/exceptions.dart';
import 'package:ebirth/core/error/failures.dart';
import 'package:ebirth/core/network/network_info.dart';
import 'package:ebirth/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:ebirth/features/auth/domain/entities/user_entity.dart';
import 'package:ebirth/features/auth/domain/repositories/auth_repository.dart';
import 'package:ebirth/core/helper/shared_prefs_helper.dart';
import 'package:ebirth/core/helper/auth_token_holder.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(message: 'No internet connection.'));
    }

    try {
      final user = await remoteDataSource.login(
        email: email,
        password: password,
      );
      if (user.token.isNotEmpty) {
        AuthTokenHolder.setToken(user.token); // In-memory (immediate)
        await SharedPrefsHelper.setToken(user.token); // Persisted (next restart)
      }
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (_) {
      return const Left(
        UnknownFailure(message: 'An unexpected error occurred.'),
      );
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register({
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
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(message: 'No internet connection.'));
    }

    try {
      final user = await remoteDataSource.register(
        name: name,
        email: email,
        password: password,
        nationalId: nationalId,
        phoneNumber: phoneNumber,
        birthDate: birthDate,
        village: village,
        city: city,
        gender: gender,
        governorate: governorate,
        bloodType: bloodType,
      );
      if (user.token.isNotEmpty) {
        AuthTokenHolder.setToken(user.token);
        await SharedPrefsHelper.setToken(user.token);
      }
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (_) {
      return const Left(
        UnknownFailure(message: 'An unexpected error occurred.'),
      );
    }
  }

  @override
  Future<Either<Failure, UserEntity>> registerDoctor({
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
    required File attachmentFile,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(message: 'No internet connection.'));
    }

    try {
      final user = await remoteDataSource.createDoctor(
        name: name,
        email: email,
        password: password,
        nationalId: nationalId,
        phoneNumber: phoneNumber,
        birthDate: birthDate,
        village: village,
        city: city,
        gender: gender,
        governorate: governorate,
        bloodType: bloodType,
        attachmentPath: attachmentFile.path,
      );
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (_) {
      return const Left(
        UnknownFailure(message: 'An unexpected error occurred.'),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> forgotPassword({
    required String emailOrNationalId,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(message: 'No internet connection.'));
    }

    try {
      await remoteDataSource.forgotPassword(
        emailOrNationalId: emailOrNationalId,
      );
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (_) {
      return const Left(
        UnknownFailure(message: 'An unexpected error occurred.'),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyOtp({
    required String emailOrNationalId,
    required String otp,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(message: 'No internet connection.'));
    }

    try {
      await remoteDataSource.verifyOtp(
        emailOrNationalId: emailOrNationalId,
        otp: otp,
      );
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (_) {
      return const Left(
        UnknownFailure(message: 'An unexpected error occurred.'),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> resetPassword({
    required String emailOrNationalId,
    required String otp,
    required String newPassword,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(message: 'No internet connection.'));
    }

    try {
      await remoteDataSource.resetPassword(
        emailOrNationalId: emailOrNationalId,
        otp: otp,
        newPassword: newPassword,
      );
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (_) {
      return const Left(
        UnknownFailure(message: 'An unexpected error occurred.'),
      );
    }
  }
}
