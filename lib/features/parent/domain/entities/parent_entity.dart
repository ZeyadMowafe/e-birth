import 'package:equatable/equatable.dart';
import 'child_entity.dart';

class ParentEntity extends Equatable {
  final int id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final List<ChildEntity> children;

  const ParentEntity({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.children,
  });

  @override
  List<Object?> get props => [id, fullName, email, phoneNumber, children];
}
