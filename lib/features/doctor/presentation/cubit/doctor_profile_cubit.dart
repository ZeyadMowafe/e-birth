import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/doctor_profile_entity.dart';
import '../../domain/usecases/get_doctor_profile_usecase.dart';
import '../../domain/usecases/get_doctor_dashboard_data_usecase.dart';
import '../../../parent/domain/usecases/get_parent_with_children.dart';
import '../../../parent/domain/usecases/get_parent_details_usecase.dart';
import 'doctor_profile_state.dart';

class DoctorProfileCubit extends Cubit<DoctorProfileState> {
  final GetDoctorProfileUseCase getDoctorProfileUseCase;
  final GetDoctorDashboardDataUseCase getDoctorDashboardDataUseCase;
  final GetParentWithChildrenUseCase getParentWithChildrenUseCase;
  final GetParentDetailsUseCase getParentDetailsUseCase;

  DoctorProfileCubit({
    required this.getDoctorProfileUseCase,
    required this.getDoctorDashboardDataUseCase,
    required this.getParentWithChildrenUseCase,
    required this.getParentDetailsUseCase,
  }) : super(DoctorProfileInitial());

  Future<void> fetchDoctorProfile(String userIdAuth) async {
    emit(DoctorProfileLoading());

    // 1. Fetch summary to get the integer ID
    final summaryResult = await getDoctorDashboardDataUseCase(userIdAuth);

    summaryResult.fold(
      (failure) => emit(DoctorProfileError(message: failure.message)),
      (summaryData) async {
        // 2. Fetch full details using the Auth GUID
        final detailResult = await getDoctorProfileUseCase(userIdAuth);

        detailResult.fold(
          (failure) async {
            // SECOND FALLBACK: Try fetching Parent Details for the same user
            // This is useful if the user is both a Doctor and a Parent and their info is in the Parent table.
            final parentSummaryResult = await getParentWithChildrenUseCase(userIdAuth);
            
            await parentSummaryResult.fold(
              (pFailure) async {
                // LAST FALLBACK: Show only dashboard summary data
                emit(DoctorProfileLoaded(
                  profile: DoctorProfileEntity(
                    id: summaryData.id,
                    fullName: summaryData.fullName,
                    nationalId: 'غير متوفر',
                    birthDate: 'غير متوفر',
                    village: 'غير متوفر',
                    city: 'غير متوفر',
                    gender: 'غير متوفر',
                    governorate: 'غير متوفر',
                    bloodType: 'غير متوفر',
                    phoneNumber: 'غير متوفر',
                    email: 'غير متوفر',
                    role: summaryData.role,
                  ),
                ));
              },
              (parentEntity) async {
                final parentDetailResult = await getParentDetailsUseCase(parentEntity.id.toString());
                
                parentDetailResult.fold(
                  (pdFailure) {
                     // Still show dashboard data if Parent details also fail
                     emit(DoctorProfileLoaded(profile: DoctorProfileEntity(
                        id: summaryData.id,
                        fullName: summaryData.fullName,
                        nationalId: 'غير متوفر',
                        birthDate: 'غير متوفر',
                        village: 'غير متوفر',
                        city: 'غير متوفر',
                        gender: 'غير متوفر',
                        governorate: 'غير متوفر',
                        bloodType: 'غير متوفر',
                        phoneNumber: 'غير متوفر',
                        email: 'غير متوفر',
                        role: summaryData.role,
                     )));
                  },
                  (parentDetails) {
                    // SUCCESS: Emit loaded state with data from Parent profile
                    emit(DoctorProfileLoaded(
                      profile: DoctorProfileEntity(
                        id: summaryData.id,
                        fullName: parentDetails.fullName,
                        nationalId: parentDetails.nationalId,
                        birthDate: parentDetails.birthDate,
                        village: parentDetails.village,
                        city: parentDetails.city,
                        gender: parentDetails.gender,
                        governorate: parentDetails.governorate,
                        bloodType: parentDetails.bloodType,
                        phoneNumber: parentDetails.phoneNumber,
                        email: parentDetails.email,
                        role: summaryData.role,
                      ),
                    ));
                  },
                );
              },
            );
          },
          (profile) => emit(DoctorProfileLoaded(profile: profile)),
        );
      },
    );
  }
}
