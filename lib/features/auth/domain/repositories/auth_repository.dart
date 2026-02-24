import 'package:dartz/dartz.dart';
import 'package:ebirth/core/error/failures.dart';
import 'package:ebirth/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> register({
    required String name,
    required String email,
    required String password,
    required String nationalId,
    required String phoneNumber,
  });

  Future<Either<Failure, Unit>> forgotPassword({required String email});

  Future<Either<Failure, Unit>> verifyOtp({
    required String email,
    required String otp,
  });

  Future<Either<Failure, Unit>> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  });
}

