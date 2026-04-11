import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_parent_details_usecase.dart';
import '../../domain/usecases/get_parent_with_children.dart';
import 'parent_profile_state.dart';

class ParentProfileCubit extends Cubit<ParentProfileState> {
  final GetParentDetailsUseCase getParentDetailsUseCase;
  final GetParentWithChildrenUseCase getParentWithChildrenUseCase;

  ParentProfileCubit({
    required this.getParentDetailsUseCase,
    required this.getParentWithChildrenUseCase,
  }) : super(ParentProfileInitial());

  Future<void> fetchParentProfile(String userIdAuth) async {
    emit(ParentProfileLoading());

    // 1. We must fetch the Parent Model first to get the integer ParentID,
    //    because the API expects the integer ID, not the raw Auth Identity GUID.
    final parentResult = await getParentWithChildrenUseCase(userIdAuth);
    
    parentResult.fold(
      (failure) => emit(ParentProfileError(failure.message)),
      (parentEntity) async {
        final parentIntegerId = parentEntity.id.toString();

        // 2. Fetch the detailed parent profile using the derived integer ID.
        final detailResult = await getParentDetailsUseCase(parentIntegerId);
        detailResult.fold(
          (failure) => emit(ParentProfileError(failure.message)),
          (parentDetails) => emit(ParentProfileLoaded(parentDetails)),
        );
      },
    );
  }
}
