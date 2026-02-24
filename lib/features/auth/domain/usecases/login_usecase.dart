import 'package:dartz/dartz.dart';
import 'package:ebirth/core/error/failures.dart';
import 'package:ebirth/core/usecases/usecase.dart';
import 'package:ebirth/features/auth/domain/entities/user_entity.dart';
import 'package:ebirth/features/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

class LoginUseCase extends UseCase<UserEntity, LoginParams> {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  @override
  Future<Either<Failure, UserEntity>> call(LoginParams params) {
    return repository.login(email: params.email, password: params.password);
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

