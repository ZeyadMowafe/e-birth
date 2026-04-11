import '../models/parent_model.dart';
import '../models/child_model.dart';
import '../models/vaccination_model.dart';
import '../models/medical_history_model.dart';

import '../models/parent_details_model.dart';

abstract class ParentRemoteDataSource {
  Future<ParentModel> getParentWithChildren(String parentId);
  Future<ParentDetailsModel> getParentDetails(String parentId);
  Future<ChildModel> getChildDetails(String childId);
  Future<List<VaccinationModel>> getChildVaccinations(String childId);
  Future<List<MedicalHistoryModel>> getChildMedicalHistory(String childId);
  Future<List<MedicalHistoryModel>> getParentMedicalHistory(String parentId);
  Future<MedicalHistoryModel> getSpecificChildMedicalHistory(String medicalRecordId);
  Future<MedicalHistoryModel> getSpecificParentMedicalHistory(String medicalRecordId);
}
