import 'package:dartz/dartz.dart';
import 'package:ebirth/core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../repositories/doctor_repository.dart';

class AddChildMedicalRecordUseCase extends UseCase<void, AddMedicalRecordParams> {
  final DoctorRepository repository;

  AddChildMedicalRecordUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(AddMedicalRecordParams params) async {
    return await repository.addChildMedicalRecord(
      childId: params.childId,
      medicine: params.medicine,
      description: params.description,
      imagePaths: params.imagePaths,
    );
  }
}

class AddMedicalRecordParams extends Equatable {
  final int childId;
  final String medicine;
  final String description;
  final List<String> imagePaths;

  const AddMedicalRecordParams({
    required this.childId,
    required this.medicine,
    required this.description,
    required this.imagePaths,
  });

  @override
  List<Object?> get props => [childId, medicine, description, imagePaths];
}
