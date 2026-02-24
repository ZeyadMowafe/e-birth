import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebirth/features/auth/domain/usecases/login_usecase.dart';
import 'package:ebirth/features/auth/presentation/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit({required this.loginUseCase}) : super(const LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(const LoginLoading());

    final result = await loginUseCase(
      LoginParams(email: email, password: password),
    );

    result.fold(
      (failure) => emit(LoginFailure(message: failure.message)),
      (user) => emit(LoginSuccess(user: user)),
    );
  }
}

