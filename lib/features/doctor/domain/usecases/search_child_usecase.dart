import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../features/parent/domain/entities/child_entity.dart';
import '../repositories/doctor_repository.dart';

class SearchChildUseCase extends UseCase<ChildEntity, String> {
  final DoctorRepository repository;

  SearchChildUseCase({required this.repository});

  @override
  Future<Either<Failure, ChildEntity>> call(String params) {
    return repository.searchChild(params);
  }
}
