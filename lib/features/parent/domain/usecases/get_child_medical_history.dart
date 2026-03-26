import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/medical_history_entity.dart';
import '../repositories/parent_repository.dart';

class GetChildMedicalHistoryUseCase {
  final ParentRepository repository;

  GetChildMedicalHistoryUseCase(this.repository);

  Future<Either<Failure, List<MedicalHistoryEntity>>> call(String childId) async {
    return await repository.getChildMedicalHistory(childId);
  }
}
