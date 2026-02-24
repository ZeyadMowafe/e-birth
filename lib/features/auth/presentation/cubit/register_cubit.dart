import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebirth/features/auth/domain/usecases/register_usecase.dart';
import 'package:ebirth/features/auth/presentation/cubit/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterCubit({required this.registerUseCase})
    : super(const RegisterInitial());

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String nationalId,
    required String phoneNumber,
  }) async {
    emit(const RegisterLoading());

    final result = await registerUseCase(
      RegisterParams(
        name: name,
        email: email,
        password: password,
        nationalId: nationalId,
        phoneNumber: phoneNumber,
      ),
    );

    result.fold(
      (failure) => emit(RegisterFailure(message: failure.message)),
      (user) => emit(RegisterSuccess(user: user)),
    );
  }
}

