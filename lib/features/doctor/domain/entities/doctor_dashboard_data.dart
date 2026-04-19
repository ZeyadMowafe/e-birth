import 'package:equatable/equatable.dart';
import '../../../../features/parent/domain/entities/child_entity.dart';

class DoctorDashboardData extends Equatable {
  final int id;
  final String fullName;
  final String role;
  final List<ChildEntity> children;

  const DoctorDashboardData({
    required this.id,
    required this.fullName,
    required this.role,
    required this.children,
  });

  @override
  List<Object?> get props => [id, fullName, role, children];
}
