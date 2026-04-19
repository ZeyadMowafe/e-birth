import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_doctor_profile_usecase.dart';
import '../../domain/usecases/get_doctor_dashboard_data_usecase.dart';
import 'doctor_profile_state.dart';

class DoctorProfileCubit extends Cubit<DoctorProfileState> {
  final GetDoctorProfileUseCase getDoctorProfileUseCase;
  final GetDoctorDashboardDataUseCase getDoctorDashboardDataUseCase;

  DoctorProfileCubit({
    required this.getDoctorProfileUseCase,
    required this.getDoctorDashboardDataUseCase,
  }) : super(DoctorProfileInitial());

  Future<void> fetchDoctorProfile(String userIdAuth) async {
    emit(DoctorProfileLoading());

    // 1. Fetch summary to get the integer ID
    final summaryResult = await getDoctorDashboardDataUseCase(userIdAuth);

    summaryResult.fold(
      (failure) => emit(DoctorProfileError(message: failure.message)),
      (summaryData) async {
        final doctorIntegerId = summaryData.id.toString();

        // 2. Fetch full details using the integer ID
        final detailResult = await getDoctorProfileUseCase(doctorIntegerId);

        detailResult.fold(
          (failure) => emit(DoctorProfileError(message: failure.message)),
          (profile) => emit(DoctorProfileLoaded(profile: profile)),
        );
      },
    );
  }
}
