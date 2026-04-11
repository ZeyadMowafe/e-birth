import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_parent_medical_history.dart';
import '../../domain/usecases/get_parent_with_children.dart';
import 'parent_medical_history_state.dart';

class ParentMedicalHistoryCubit extends Cubit<ParentMedicalHistoryState> {
  final GetParentMedicalHistoryUseCase getParentMedicalHistoryUseCase;
  final GetParentWithChildrenUseCase getParentWithChildrenUseCase;

  ParentMedicalHistoryCubit({
    required this.getParentMedicalHistoryUseCase,
    required this.getParentWithChildrenUseCase,
  }) : super(ParentMedicalHistoryInitial());

  Future<void> fetchParentMedicalHistory(String userIdAuth) async {
    emit(ParentMedicalHistoryLoading());

    // 1. Get integer ParentID using Auth GUID
    final parentResult = await getParentWithChildrenUseCase(userIdAuth);
    
    await parentResult.fold(
      (failure) async => emit(ParentMedicalHistoryError(failure.message)),
      (parentEntity) async {
        final parentIntegerId = parentEntity.id.toString();

        // 2. Fetch the actual medical records
        final historyResult = await getParentMedicalHistoryUseCase(parentIntegerId);
        historyResult.fold(
          (failure) => emit(ParentMedicalHistoryError(failure.message)),
          (histories) => emit(ParentMedicalHistoryLoaded(histories)),
        );
      },
    );
  }
}
