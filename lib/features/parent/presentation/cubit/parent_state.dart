import 'package:equatable/equatable.dart';
import '../../domain/entities/parent_entity.dart';

abstract class ParentState extends Equatable {
  const ParentState();

  @override
  List<Object?> get props => [];
}

class ParentInitial extends ParentState {}

class ParentLoading extends ParentState {}

class ParentLoaded extends ParentState {
  final ParentEntity parent;

  const ParentLoaded({required this.parent});

  @override
  List<Object?> get props => [parent];
}

class ParentError extends ParentState {
  final String message;

  const ParentError({required this.message});

  @override
  List<Object?> get props => [message];
}
