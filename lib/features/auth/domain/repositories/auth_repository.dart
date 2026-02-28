import 'dart:io';
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
    required String birthDate,
    required String village,
    required String city,
    required int gender,
    required int governorate,
    required int bloodType,
  });

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
  });

  Future<Either<Failure, Unit>> forgotPassword({
    required String emailOrNationalId,
  });

  Future<Either<Failure, Unit>> verifyOtp({
    required String emailOrNationalId,
    required String otp,
  });

  Future<Either<Failure, Unit>> resetPassword({
    required String emailOrNationalId,
    required String otp,
    required String newPassword,
  });
}
