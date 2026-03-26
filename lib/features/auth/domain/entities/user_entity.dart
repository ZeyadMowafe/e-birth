import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String token;
  final String role; // 'Parent', 'Doctor', 'Admin'

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
    required this.role,
  });

  UserEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? token,
    String? role,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      token: token ?? this.token,
      role: role ?? this.role,
    );
  }

  /// Returns the display name based on role
  String get displayName {
    if (role.toLowerCase() == 'doctor') return 'د. $name';
    return name;
  }

  @override
  List<Object?> get props => [id, name, email, token, role];
}
