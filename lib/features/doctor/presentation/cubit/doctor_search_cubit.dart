import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/search_child_usecase.dart';
import 'doctor_search_state.dart';

class DoctorSearchCubit extends Cubit<DoctorSearchState> {
  final SearchChildUseCase searchChildUseCase;

  DoctorSearchCubit({required this.searchChildUseCase})
      : super(DoctorSearchInitial());

  Future<void> searchForChild(String nationalId) async {
    if (nationalId.isEmpty) return;
    
    emit(DoctorSearchLoading());
    final result = await searchChildUseCase(nationalId);
    result.fold(
      (failure) => emit(DoctorSearchError(message: failure.message)),
      (child) => emit(DoctorSearchSuccess(child: child)),
    );
  }

  void clearSearch() {
    emit(DoctorSearchInitial());
  }
}
