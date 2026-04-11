import 'package:equatable/equatable.dart';
import '../../domain/entities/medical_history_entity.dart';

abstract class MedicalRecordDetailState extends Equatable {
  const MedicalRecordDetailState();

  @override
  List<Object?> get props => [];
}

class MedicalRecordDetailInitial extends MedicalRecordDetailState {}

class MedicalRecordDetailLoading extends MedicalRecordDetailState {}

class MedicalRecordDetailLoaded extends MedicalRecordDetailState {
  final MedicalHistoryEntity record;

  const MedicalRecordDetailLoaded(this.record);

  @override
  List<Object?> get props => [record];
}

class MedicalRecordDetailError extends MedicalRecordDetailState {
  final String message;

  const MedicalRecordDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
