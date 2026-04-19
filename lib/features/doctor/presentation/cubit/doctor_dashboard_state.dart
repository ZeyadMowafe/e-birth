import 'package:ebirth/features/doctor/domain/entities/doctor_dashboard_data.dart';
import 'package:equatable/equatable.dart';

abstract class DoctorDashboardState extends Equatable {
  const DoctorDashboardState();

  @override
  List<Object?> get props => [];
}

class DoctorDashboardInitial extends DoctorDashboardState {}

class DoctorDashboardLoading extends DoctorDashboardState {}

class DoctorDashboardLoaded extends DoctorDashboardState {
  final DoctorDashboardData data;
  const DoctorDashboardLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}

class DoctorDashboardError extends DoctorDashboardState {
  final String message;
  const DoctorDashboardError({required this.message});

  @override
  List<Object?> get props => [message];
}
