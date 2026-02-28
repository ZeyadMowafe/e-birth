import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebirth/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:ebirth/features/auth/presentation/cubit/forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordUseCase forgotPasswordUseCase;

  ForgotPasswordCubit({required this.forgotPasswordUseCase})
    : super(const ForgotPasswordInitial());

  Future<void> forgotPassword({required String emailOrNationalId}) async {
    emit(const ForgotPasswordLoading());

    final result = await forgotPasswordUseCase(emailOrNationalId);

    result.fold(
      (failure) => emit(ForgotPasswordFailure(message: failure.message)),
      (_) => emit(const ForgotPasswordSuccess()),
    );
  }
}
