import 'package:equatable/equatable.dart';
import '../../../../features/parent/domain/entities/child_entity.dart';

abstract class DoctorSearchState extends Equatable {
  const DoctorSearchState();

  @override
  List<Object?> get props => [];
}

class DoctorSearchInitial extends DoctorSearchState {}

class DoctorSearchLoading extends DoctorSearchState {}

class DoctorSearchSuccess extends DoctorSearchState {
  final ChildEntity child;
  const DoctorSearchSuccess({required this.child});

  @override
  List<Object?> get props => [child];
}

class DoctorSearchError extends DoctorSearchState {
  final String message;
  const DoctorSearchError({required this.message});

  @override
  List<Object?> get props => [message];
}
