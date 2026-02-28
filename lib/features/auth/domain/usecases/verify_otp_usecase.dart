import 'package:dartz/dartz.dart';
import 'package:ebirth/core/error/failures.dart';
import 'package:ebirth/core/usecases/usecase.dart';
import 'package:ebirth/features/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

class VerifyOtpUseCase extends UseCase<Unit, VerifyOtpParams> {
  final AuthRepository repository;

  VerifyOtpUseCase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(VerifyOtpParams params) {
    return repository.verifyOtp(
      emailOrNationalId: params.emailOrNationalId,
      otp: params.otp,
    );
  }
}

class VerifyOtpParams extends Equatable {
  final String emailOrNationalId;
  final String otp;

  const VerifyOtpParams({required this.emailOrNationalId, required this.otp});

  @override
  List<Object?> get props => [emailOrNationalId, otp];
}
