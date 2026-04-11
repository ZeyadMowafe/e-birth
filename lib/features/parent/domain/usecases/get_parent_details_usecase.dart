import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/parent_details_entity.dart';
import '../repositories/parent_repository.dart';

class GetParentDetailsUseCase implements UseCase<ParentDetailsEntity, String> {
  final ParentRepository repository;

  GetParentDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, ParentDetailsEntity>> call(String parentId) async {
    return await repository.getParentDetails(parentId);
  }
}
