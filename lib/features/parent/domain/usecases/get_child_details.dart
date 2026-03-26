import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/child_entity.dart';
import '../repositories/parent_repository.dart';

class GetChildDetailsUseCase {
  final ParentRepository repository;

  GetChildDetailsUseCase(this.repository);

  Future<Either<Failure, ChildEntity>> call(String childId) async {
    return await repository.getChildDetails(childId);
  }
}
