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

  /// Returns the display name based on role
  String get displayName {
    if (role.toLowerCase() == 'doctor') return 'د. $name';
    return name;
  }

  @override
  List<Object?> get props => [id, name, email, token, role];
}
