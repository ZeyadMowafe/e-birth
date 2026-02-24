import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebirth/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:ebirth/features/auth/presentation/cubit/verify_otp_state.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  final VerifyOtpUseCase verifyOtpUseCase;

  VerifyOtpCubit({required this.verifyOtpUseCase})
    : super(const VerifyOtpInitial());

  Future<void> verifyOtp({required String email, required String otp}) async {
    emit(const VerifyOtpLoading());

    final result = await verifyOtpUseCase(
      VerifyOtpParams(email: email, otp: otp),
    );

    result.fold(
      (failure) => emit(VerifyOtpFailure(message: failure.message)),
      (_) => emit(const VerifyOtpSuccess()),
    );
  }
}

