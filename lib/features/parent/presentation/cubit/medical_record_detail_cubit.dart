import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_specific_child_medical_history.dart';
import '../../domain/usecases/get_specific_parent_medical_history.dart';
import 'medical_record_detail_state.dart';

class MedicalRecordDetailCubit extends Cubit<MedicalRecordDetailState> {
  final GetSpecificChildMedicalHistoryUseCase getSpecificChildMedicalHistoryUseCase;
  final GetSpecificParentMedicalHistoryUseCase getSpecificParentMedicalHistoryUseCase;

  MedicalRecordDetailCubit({
    required this.getSpecificChildMedicalHistoryUseCase,
    required this.getSpecificParentMedicalHistoryUseCase,
  }) : super(MedicalRecordDetailInitial());

  Future<void> fetchRecordDetails(String medicalRecordId, bool isChild) async {
    emit(MedicalRecordDetailLoading());

    final result = isChild
        ? await getSpecificChildMedicalHistoryUseCase(medicalRecordId)
        : await getSpecificParentMedicalHistoryUseCase(medicalRecordId);

    result.fold(
      (failure) => emit(MedicalRecordDetailError(failure.message)),
      (record) => emit(MedicalRecordDetailLoaded(record)),
    );
  }
}
