import 'package:dartz/dartz.dart';
import 'package:ebirth/features/doctor/domain/entities/doctor_dashboard_data.dart';
import 'package:ebirth/features/doctor/domain/entities/doctor_profile_entity.dart';
import 'package:ebirth/features/parent/domain/entities/child_entity.dart';
import '../../../../core/error/failures.dart';

abstract class DoctorRepository {
  Future<Either<Failure, DoctorDashboardData>> getDoctorDashboardData(String userId);
  Future<Either<Failure, ChildEntity>> searchChild(String nationalId);
  Future<Either<Failure, void>> addChildMedicalRecord({
    required int childId,
    required String medicine,
    required String description,
    required List<String> imagePaths,
  });
  Future<Either<Failure, DoctorProfileEntity>> getDoctorProfile(String userId);
}
