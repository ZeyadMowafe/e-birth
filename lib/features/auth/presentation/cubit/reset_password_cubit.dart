import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebirth/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:ebirth/features/auth/presentation/cubit/reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordUseCase resetPasswordUseCase;

  ResetPasswordCubit({required this.resetPasswordUseCase})
    : super(const ResetPasswordInitial());

  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    emit(const ResetPasswordLoading());

    final result = await resetPasswordUseCase(
      ResetPasswordParams(email: email, otp: otp, newPassword: newPassword),
    );

    result.fold(
      (failure) => emit(ResetPasswordFailure(message: failure.message)),
      (_) => emit(const ResetPasswordSuccess()),
    );
  }
}

