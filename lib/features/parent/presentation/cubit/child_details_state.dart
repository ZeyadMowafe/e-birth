import 'package:equatable/equatable.dart';
import '../../domain/entities/child_entity.dart';
import '../../domain/entities/vaccination_entity.dart';
import '../../domain/entities/medical_history_entity.dart';

abstract class ChildDetailsState extends Equatable {
  const ChildDetailsState();

  @override
  List<Object?> get props => [];
}

class ChildDetailsInitial extends ChildDetailsState {}

class ChildDetailsLoading extends ChildDetailsState {}

class ChildDetailsLoaded extends ChildDetailsState {
  final ChildEntity childDetails;
  final List<VaccinationEntity> vaccinations;
  final List<MedicalHistoryEntity> medicalHistories;

  const ChildDetailsLoaded({
    required this.childDetails,
    required this.vaccinations,
    required this.medicalHistories,
  });

  @override
  List<Object?> get props => [childDetails, vaccinations, medicalHistories];
}

class ChildDetailsError extends ChildDetailsState {
  final String message;

  const ChildDetailsError({required this.message});

  @override
  List<Object?> get props => [message];
}
