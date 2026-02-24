import 'package:dartz/dartz.dart';
import 'package:ebirth/core/error/failures.dart';
import 'package:ebirth/features/auth/domain/repositories/auth_repository.dart';

class ResetPasswordParams {
  final String email;
  final String otp;
  final String newPassword;

  const ResetPasswordParams({
    required this.email,
    required this.otp,
    required this.newPassword,
  });
}

class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(ResetPasswordParams params) {
    return repository.resetPassword(
      email: params.email,
      otp: params.otp,
      newPassword: params.newPassword,
    );
  }
}

