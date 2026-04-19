import '../../domain/entities/doctor_dashboard_data.dart';
import '../../../../features/parent/data/models/child_model.dart';

class DoctorDashboardModel extends DoctorDashboardData {
  const DoctorDashboardModel({
    required super.id,
    required super.fullName,
    required super.role,
    required super.children,
  });

  factory DoctorDashboardModel.fromJson(Map<String, dynamic> json) {
    // The API might return a list in "data" or a single object. 
    // Usually, the isSuccess/data wrapper is handled at the DataSource level.
    return DoctorDashboardModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      fullName: json['fullName'] ?? '',
      role: json['role'] ?? '',
      children: json['children'] != null
          ? List<ChildModel>.from(
              (json['children'] as List).map((x) => ChildModel.fromJson(x)),
            )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'role': role,
      'children': (children as List<ChildModel>).map((x) => x.toJson()).toList(),
    };
  }
}
