import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/add_child_medical_record_usecase.dart';
import 'add_medical_record_state.dart';

class AddMedicalRecordCubit extends Cubit<AddMedicalRecordState> {
  final AddChildMedicalRecordUseCase addRecordUseCase;

  AddMedicalRecordCubit({required this.addRecordUseCase})
      : super(AddMedicalRecordInitial());

  Future<void> addMedicalRecord({
    required int childId,
    required String medicine,
    required String description,
    required List<String> imagePaths,
  }) async {
    emit(AddMedicalRecordLoading());
    final result = await addRecordUseCase(AddMedicalRecordParams(
      childId: childId,
      medicine: medicine,
      description: description,
      imagePaths: imagePaths,
    ));
    result.fold(
      (failure) => emit(AddMedicalRecordError(message: failure.message)),
      (_) => emit(AddMedicalRecordSuccess()),
    );
  }
}
