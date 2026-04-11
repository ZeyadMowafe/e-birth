import 'package:equatable/equatable.dart';
import '../../domain/entities/parent_details_entity.dart';

abstract class ParentProfileState extends Equatable {
  const ParentProfileState();

  @override
  List<Object?> get props => [];
}

class ParentProfileInitial extends ParentProfileState {}

class ParentProfileLoading extends ParentProfileState {}

class ParentProfileLoaded extends ParentProfileState {
  final ParentDetailsEntity parentDetails;

  const ParentProfileLoaded(this.parentDetails);

  @override
  List<Object?> get props => [parentDetails];
}

class ParentProfileError extends ParentProfileState {
  final String message;

  const ParentProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
