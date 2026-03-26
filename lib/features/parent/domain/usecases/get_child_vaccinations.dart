import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/vaccination_entity.dart';
import '../repositories/parent_repository.dart';

class GetChildVaccinationsUseCase {
  final ParentRepository repository;

  GetChildVaccinationsUseCase(this.repository);

  Future<Either<Failure, List<VaccinationEntity>>> call(String childId) async {
    return await repository.getChildVaccinations(childId);
  }
}
