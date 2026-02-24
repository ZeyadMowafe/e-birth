import 'package:dartz/dartz.dart';
import 'package:ebirth/core/error/exceptions.dart';
import 'package:ebirth/core/error/failures.dart';
import 'package:ebirth/core/network/network_info.dart';
import 'package:ebirth/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:ebirth/features/auth/domain/entities/user_entity.dart';
import 'package:ebirth/features/auth/domain/repositories/auth_repository.dart';

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
  Future<Either<Failure, Unit>> forgotPassword({required String email}) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(message: 'No internet connection.'));
    }

    try {
      await remoteDataSource.forgotPassword(email: email);
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
    required String email,
    required String otp,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(message: 'No internet connection.'));
    }

    try {
      await remoteDataSource.verifyOtp(email: email, otp: otp);
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
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    try {
      await remoteDataSource.resetPassword(
        email: email,
        otp: otp,
        newPassword: newPassword,
      );
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}

