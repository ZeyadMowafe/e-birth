import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_child_details.dart';
import '../../domain/usecases/get_child_vaccinations.dart';
import '../../domain/usecases/get_child_medical_history.dart';
import 'child_details_state.dart';

class ChildDetailsCubit extends Cubit<ChildDetailsState> {
  final GetChildDetailsUseCase getChildDetailsUseCase;
  final GetChildVaccinationsUseCase getChildVaccinationsUseCase;
  final GetChildMedicalHistoryUseCase getChildMedicalHistoryUseCase;

  ChildDetailsCubit({
    required this.getChildDetailsUseCase,
    required this.getChildVaccinationsUseCase,
    required this.getChildMedicalHistoryUseCase,
  }) : super(ChildDetailsInitial());

  Future<void> fetchChildDetails(String childId) async {
    emit(ChildDetailsLoading());

    // Execute concurrently if possible, or sequentially. 
    // Here we use futures and wait for all to complete.
    final detailsFuture = getChildDetailsUseCase(childId);
    final vaccinationsFuture = getChildVaccinationsUseCase(childId);
    final historyFuture = getChildMedicalHistoryUseCase(childId);

    final results = await Future.wait([detailsFuture, vaccinationsFuture, historyFuture]);

    final detailsResult = results[0] as dynamic; // Dart will infer 'Either...'
    final vaccinationsResult = results[1] as dynamic;
    final historyResult = results[2] as dynamic;

    // We can collect errors, but for simplicity, we throw the first error we encounter
    String? errorMessage;
    
    detailsResult.fold((l) => errorMessage = l.message, (r) => null);
    if (errorMessage != null) {
      emit(ChildDetailsError(message: errorMessage!));
      return;
    }

    vaccinationsResult.fold((l) => errorMessage = l.message, (r) => null);
    if (errorMessage != null) {
      emit(ChildDetailsError(message: errorMessage!));
      return;
    }

    historyResult.fold((l) => errorMessage = l.message, (r) => null);
    if (errorMessage != null) {
      emit(ChildDetailsError(message: errorMessage!));
      return;
    }

    emit(ChildDetailsLoaded(
      childDetails: detailsResult.fold((l) => throw Exception(), (r) => r),
      vaccinations: vaccinationsResult.fold((l) => throw Exception(), (r) => r),
      medicalHistories: historyResult.fold((l) => throw Exception(), (r) => r),
    ));
  }
}
