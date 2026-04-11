import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/medical_history_entity.dart';
import '../repositories/parent_repository.dart';

class GetParentMedicalHistoryUseCase implements UseCase<List<MedicalHistoryEntity>, String> {
  final ParentRepository repository;

  GetParentMedicalHistoryUseCase(this.repository);

  @override
  Future<Either<Failure, List<MedicalHistoryEntity>>> call(String parentId) async {
    return await repository.getParentMedicalHistory(parentId);
  }
}
