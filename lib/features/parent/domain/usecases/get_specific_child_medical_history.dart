import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/medical_history_entity.dart';
import '../repositories/parent_repository.dart';

class GetSpecificChildMedicalHistoryUseCase implements UseCase<MedicalHistoryEntity, String> {
  final ParentRepository repository;

  GetSpecificChildMedicalHistoryUseCase(this.repository);

  @override
  Future<Either<Failure, MedicalHistoryEntity>> call(String medicalRecordId) async {
    return await repository.getSpecificChildMedicalHistory(medicalRecordId);
  }
}
