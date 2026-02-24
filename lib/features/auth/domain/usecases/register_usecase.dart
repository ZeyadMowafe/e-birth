import 'package:dartz/dartz.dart';
import 'package:ebirth/core/error/failures.dart';
import 'package:ebirth/core/usecases/usecase.dart';
import 'package:ebirth/features/auth/domain/entities/user_entity.dart';
import 'package:ebirth/features/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

class RegisterUseCase extends UseCase<UserEntity, RegisterParams> {
  final AuthRepository repository;

  RegisterUseCase({required this.repository});

  @override
  Future<Either<Failure, UserEntity>> call(RegisterParams params) {
    return repository.register(
      name: params.name,
      email: params.email,
      password: params.password,
      nationalId: params.nationalId,
      phoneNumber: params.phoneNumber,
    );
  }
}

class RegisterParams extends Equatable {
  final String name;
  final String email;
  final String password;
  final String nationalId;
  final String phoneNumber;

  const RegisterParams({
    required this.name,
    required this.email,
    required this.password,
    required this.nationalId,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [name, email, password, nationalId, phoneNumber];
}

