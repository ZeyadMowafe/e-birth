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
      birthDate: params.birthDate,
      village: params.village,
      city: params.city,
      gender: params.gender,
      governorate: params.governorate,
      bloodType: params.bloodType,
    );
  }
}

class RegisterParams extends Equatable {
  final String name;
  final String email;
  final String password;
  final String nationalId;
  final String phoneNumber;
  final String birthDate;
  final String village;
  final String city;
  final int gender;
  final int governorate;
  final int bloodType;

  const RegisterParams({
    required this.name,
    required this.email,
    required this.password,
    required this.nationalId,
    required this.phoneNumber,
    required this.birthDate,
    required this.village,
    required this.city,
    required this.gender,
    required this.governorate,
    required this.bloodType,
  });

  @override
  List<Object?> get props => [
    name,
    email,
    password,
    nationalId,
    phoneNumber,
    birthDate,
    village,
    city,
    gender,
    governorate,
    bloodType,
  ];
}
