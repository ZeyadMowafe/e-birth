import 'package:equatable/equatable.dart';

abstract class VerifyOtpState extends Equatable {
  const VerifyOtpState();

  @override
  List<Object?> get props => [];
}

class VerifyOtpInitial extends VerifyOtpState {
  const VerifyOtpInitial();
}

class VerifyOtpLoading extends VerifyOtpState {
  const VerifyOtpLoading();
}

class VerifyOtpSuccess extends VerifyOtpState {
  const VerifyOtpSuccess();
}

class VerifyOtpFailure extends VerifyOtpState {
  final String message;

  const VerifyOtpFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

