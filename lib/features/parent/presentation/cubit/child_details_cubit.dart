import 'package:ebirth/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failures.dart';
import '../../domain/usecases/get_child_details.dart';
import '../../domain/usecases/get_child_vaccinations.dart';
import '../../domain/usecases/get_child_medical_history.dart';
import '../../domain/usecases/get_parent_medical_history.dart';
import '../../domain/usecases/get_parent_details_usecase.dart';
import '../../data/models/child_model.dart';
import 'child_details_state.dart';

class ChildDetailsCubit extends Cubit<ChildDetailsState> {
  final GetChildDetailsUseCase getChildDetailsUseCase;
  final GetChildVaccinationsUseCase getChildVaccinationsUseCase;
  final GetChildMedicalHistoryUseCase getChildMedicalHistoryUseCase;
  final GetParentMedicalHistoryUseCase getParentMedicalHistoryUseCase;
  final GetParentDetailsUseCase getParentDetailsUseCase;

  ChildDetailsCubit({
    required this.getChildDetailsUseCase,
    required this.getChildVaccinationsUseCase,
    required this.getChildMedicalHistoryUseCase,
    required this.getParentMedicalHistoryUseCase,
    required this.getParentDetailsUseCase,
  }) : super(ChildDetailsInitial());

  Future<void> fetchChildDetails(String childId, {String userType = 'Child'}) async {
    emit(ChildDetailsLoading());

    // Execute based on user type
    final detailsFuture = userType == 'Child'
        ? getChildDetailsUseCase(childId)
        : getParentDetailsUseCase(childId).then((result) => result.fold(
              (l) => Left<Failure, dynamic>(l),
              (r) => Right<Failure, dynamic>(ChildModel(
                id: r.parentId,
                fullName: r.fullName,
                ageWithYears: 0, // Will be calculated in UI or constructor if birthDate provided
                ageWithMonths: 0,
                gender: r.gender,
                birthDate: r.birthDate,
                childNationalId: r.nationalId,
                village: r.village,
                city: r.city,
                governorate: r.governorate,
                bloodType: r.bloodType,
                parentPhoneNumber: r.phoneNumber,
                parentEmail: r.email,
                userType: 'Parent',
              )),
            ));
    
    // Vaccinations only for children
    final vaccinationsFuture = userType == 'Child' 
        ? getChildVaccinationsUseCase(childId) 
        : Future.value(const Right<Failure, List<dynamic>>([]));

    // History based on type
    final historyFuture = userType == 'Child'
        ? getChildMedicalHistoryUseCase(childId)
        : getParentMedicalHistoryUseCase(childId);

    final results = await Future.wait([detailsFuture, vaccinationsFuture, historyFuture]);

    final detailsResult = results[0] as dynamic; // Dart will infer 'Either...'
    final vaccinationsResult = results[1] as dynamic;
    final historyResult = results[2] as dynamic;

    // Extract data and handle errors
    String? errorMessage;
    dynamic details;
    dynamic vaccinations;
    dynamic medicalHistory;

    detailsResult.fold(
      (l) => errorMessage = l.message,
      (r) => details = r,
    );

    if (errorMessage == null) {
      vaccinationsResult.fold(
        (l) => errorMessage = l.message,
        (r) => vaccinations = r,
      );
    }

    if (errorMessage == null) {
      historyResult.fold(
        (l) => errorMessage = l.message,
        (r) => medicalHistory = r,
      );
    }

    if (errorMessage != null) {
      emit(ChildDetailsError(message: errorMessage!));
      return;
    }

    emit(ChildDetailsLoaded(
      childDetails: details,
      vaccinations: List.from(vaccinations),
      medicalHistories: List.from(medicalHistory),
    ));
  }
}
