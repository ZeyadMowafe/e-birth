import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/doctor_profile_entity.dart';
import '../repositories/doctor_repository.dart';

class GetDoctorProfileUseCase implements UseCase<DoctorProfileEntity, String> {
  final DoctorRepository repository;

  GetDoctorProfileUseCase(this.repository);

  @override
  Future<Either<Failure, DoctorProfileEntity>> call(String userId) async {
    return await repository.getDoctorProfile(userId);
  }
}
