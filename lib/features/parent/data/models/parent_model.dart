import '../../domain/entities/parent_entity.dart';
import 'child_model.dart';

class ParentModel extends ParentEntity {
  const ParentModel({
    required super.id,
    required super.fullName,
    required super.email,
    required super.phoneNumber,
    required super.children,
  });

  factory ParentModel.fromJson(Map<String, dynamic> json) {
    return ParentModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
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
      'email': email,
      'phoneNumber': phoneNumber,
      'children': (children as List<ChildModel>).map((x) => x.toJson()).toList(),
    };
  }
}
