import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebirth/features/auth/domain/usecases/register_usecase.dart';
import 'package:ebirth/features/auth/domain/usecases/register_doctor_usecase.dart';
import 'package:ebirth/features/auth/presentation/cubit/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;
  final RegisterDoctorUseCase registerDoctorUseCase;

  RegisterCubit({
    required this.registerUseCase,
    required this.registerDoctorUseCase,
  }) : super(const RegisterInitial());

  Future<void> register({
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
    emit(const RegisterLoading());

    final result = await registerUseCase(
      RegisterParams(
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
      ),
    );

    result.fold(
      (failure) => emit(RegisterFailure(message: failure.message)),
      (user) => emit(RegisterSuccess(user: user)),
    );
  }

  Future<void> registerDoctor({
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
    emit(const RegisterLoading());

    final result = await registerDoctorUseCase(
      RegisterDoctorParams(
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
        attachmentFile: attachmentFile,
      ),
    );

    result.fold(
      (failure) => emit(RegisterFailure(message: failure.message)),
      (user) => emit(RegisterSuccess(user: user)),
    );
  }
}
