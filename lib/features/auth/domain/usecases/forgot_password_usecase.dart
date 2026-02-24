import 'package:dartz/dartz.dart';
import 'package:ebirth/core/error/failures.dart';
import 'package:ebirth/core/usecases/usecase.dart';
import 'package:ebirth/features/auth/domain/repositories/auth_repository.dart';

class ForgotPasswordUseCase extends UseCase<Unit, String> {
  final AuthRepository repository;

  ForgotPasswordUseCase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(String email) {
    return repository.forgotPassword(email: email);
  }
}

