import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/doctor_dashboard_data.dart';
import '../repositories/doctor_repository.dart';

class GetDoctorDashboardDataUseCase extends UseCase<DoctorDashboardData, String> {
  final DoctorRepository repository;

  GetDoctorDashboardDataUseCase({required this.repository});

  @override
  Future<Either<Failure, DoctorDashboardData>> call(String params) {
    return repository.getDoctorDashboardData(params);
  }
}
