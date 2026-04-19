import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_doctor_dashboard_data_usecase.dart';
import 'doctor_dashboard_state.dart';

class DoctorDashboardCubit extends Cubit<DoctorDashboardState> {
  final GetDoctorDashboardDataUseCase getDoctorDashboardData;

  DoctorDashboardCubit({required this.getDoctorDashboardData})
      : super(DoctorDashboardInitial());

  Future<void> fetchDoctorDashboardData(String userId) async {
    emit(DoctorDashboardLoading());
    final result = await getDoctorDashboardData(userId);
    result.fold(
      (failure) => emit(DoctorDashboardError(message: failure.message)),
      (data) => emit(DoctorDashboardLoaded(data: data)),
    );
  }
}
