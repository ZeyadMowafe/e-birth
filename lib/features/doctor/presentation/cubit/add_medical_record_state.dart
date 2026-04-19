import 'package:equatable/equatable.dart';

abstract class AddMedicalRecordState extends Equatable {
  const AddMedicalRecordState();

  @override
  List<Object?> get props => [];
}

class AddMedicalRecordInitial extends AddMedicalRecordState {}

class AddMedicalRecordLoading extends AddMedicalRecordState {}

class AddMedicalRecordSuccess extends AddMedicalRecordState {}

class AddMedicalRecordError extends AddMedicalRecordState {
  final String message;
  const AddMedicalRecordError({required this.message});

  @override
  List<Object?> get props => [message];
}
