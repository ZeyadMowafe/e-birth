import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/parent_entity.dart';
import '../repositories/parent_repository.dart';

class GetParentWithChildrenUseCase {
  final ParentRepository repository;

  GetParentWithChildrenUseCase(this.repository);

  Future<Either<Failure, ParentEntity>> call(String parentId) async {
    return await repository.getParentWithChildren(parentId);
  }
}
