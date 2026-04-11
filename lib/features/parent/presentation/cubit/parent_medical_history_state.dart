import 'package:equatable/equatable.dart';
import '../../domain/entities/medical_history_entity.dart';

abstract class ParentMedicalHistoryState extends Equatable {
  const ParentMedicalHistoryState();

  @override
  List<Object?> get props => [];
}

class ParentMedicalHistoryInitial extends ParentMedicalHistoryState {}

class ParentMedicalHistoryLoading extends ParentMedicalHistoryState {}

class ParentMedicalHistoryLoaded extends ParentMedicalHistoryState {
  final List<MedicalHistoryEntity> histories;

  const ParentMedicalHistoryLoaded(this.histories);

  @override
  List<Object?> get props => [histories];
}

class ParentMedicalHistoryError extends ParentMedicalHistoryState {
  final String message;

  const ParentMedicalHistoryError(this.message);

  @override
  List<Object?> get props => [message];
}
