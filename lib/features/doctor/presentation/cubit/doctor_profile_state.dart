import 'package:equatable/equatable.dart';
import '../../domain/entities/doctor_profile_entity.dart';

abstract class DoctorProfileState extends Equatable {
  const DoctorProfileState();

  @override
  List<Object?> get props => [];
}

class DoctorProfileInitial extends DoctorProfileState {}

class DoctorProfileLoading extends DoctorProfileState {}

class DoctorProfileLoaded extends DoctorProfileState {
  final DoctorProfileEntity profile;

  const DoctorProfileLoaded({required this.profile});

  @override
  List<Object?> get props => [profile];
}

class DoctorProfileError extends DoctorProfileState {
  final String message;

  const DoctorProfileError({required this.message});

  @override
  List<Object?> get props => [message];
}
