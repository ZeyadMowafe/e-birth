import 'dart:convert';
import 'package:ebirth/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.token,
    required super.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    String parseRole(dynamic roleData) {
      if (roleData == null) return 'Parent';
      if (roleData is List) {
        return roleData.map((e) => e.toString()).join(',');
      }
      return roleData.toString();
    }

    return UserModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      token: json['token']?.toString() ?? '',
      role: parseRole(json['role']),
    );
  }

  /// Decode the JWT payload and create a UserModel from it.
  factory UserModel.fromToken({required String token, required String email}) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) throw const FormatException('Invalid JWT');

      // JWT payload is Base64Url encoded — pad it to a valid base64 string
      String payload = parts[1];
      payload = payload.replaceAll('-', '+').replaceAll('_', '/');
      while (payload.length % 4 != 0) {
        payload += '=';
      }

      final decoded = jsonDecode(utf8.decode(base64Decode(payload)));

      // Extract claims using Microsoft's full claim URIs
      const nameKey =
          'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name';
      const idKey =
          'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier';
      const roleKey =
          'http://schemas.microsoft.com/ws/2008/06/identity/claims/role';

      String parseRole(dynamic roleData) {
        if (roleData == null) return 'Parent';
        if (roleData is List) {
          return roleData.map((e) => e.toString()).join(',');
        }
        return roleData.toString();
      }

      return UserModel(
        id: decoded[idKey]?.toString() ?? '',
        name: decoded[nameKey]?.toString() ?? 'User',
        email: email,
        token: token,
        role: parseRole(decoded[roleKey]),
      );
    } catch (_) {
      // Fallback if JWT decoding fails
      return UserModel(
        id: '',
        name: 'User',
        email: email,
        token: token,
        role: 'Parent',
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'token': token,
      'role': role,
    };
  }
}
