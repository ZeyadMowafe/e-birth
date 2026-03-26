import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_parent_with_children.dart';
import 'parent_state.dart';

class ParentCubit extends Cubit<ParentState> {
  final GetParentWithChildrenUseCase getParentWithChildrenUseCase;

  ParentCubit({required this.getParentWithChildrenUseCase}) : super(ParentInitial());

  Future<void> getParentData(String parentId) async {
    emit(ParentLoading());
    final result = await getParentWithChildrenUseCase(parentId);
    result.fold(
      (failure) => emit(ParentError(message: failure.message)),
      (parent) => emit(ParentLoaded(parent: parent)),
    );
  }
}
