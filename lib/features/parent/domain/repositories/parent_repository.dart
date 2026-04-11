import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/parent_entity.dart';
import '../entities/child_entity.dart';
import '../entities/vaccination_entity.dart';
import '../entities/medical_history_entity.dart';
import '../entities/parent_details_entity.dart';

abstract class ParentRepository {
  Future<Either<Failure, ParentEntity>> getParentWithChildren(String parentId);
  Future<Either<Failure, ParentDetailsEntity>> getParentDetails(String parentId);
  Future<Either<Failure, ChildEntity>> getChildDetails(String childId);
  Future<Either<Failure, List<VaccinationEntity>>> getChildVaccinations(String childId);
  Future<Either<Failure, List<MedicalHistoryEntity>>> getChildMedicalHistory(String childId);
  Future<Either<Failure, List<MedicalHistoryEntity>>> getParentMedicalHistory(String parentId);
  Future<Either<Failure, MedicalHistoryEntity>> getSpecificChildMedicalHistory(String medicalRecordId);
  Future<Either<Failure, MedicalHistoryEntity>> getSpecificParentMedicalHistory(String medicalRecordId);
}
