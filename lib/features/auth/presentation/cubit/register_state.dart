import 'package:equatable/equatable.dart';
import 'package:ebirth/features/auth/domain/entities/user_entity.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState {
  const RegisterInitial();
}

class RegisterLoading extends RegisterState {
  const RegisterLoading();
}

class RegisterSuccess extends RegisterState {
  final UserEntity user;

  const RegisterSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

class RegisterFailure extends RegisterState {
  final String message;

  const RegisterFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

