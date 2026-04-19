import 'package:ebirth/features/doctor/domain/entities/doctor_profile_entity.dart';

class DoctorProfileModel extends DoctorProfileEntity {
  const DoctorProfileModel({
    required super.id,
    required super.fullName,
    required super.nationalId,
    required super.birthDate,
    required super.village,
    required super.city,
    required super.gender,
    required super.governorate,
    required super.bloodType,
    required super.phoneNumber,
    required super.email,
    required super.role,
  });

  factory DoctorProfileModel.fromJson(Map<String, dynamic> json) {
    return DoctorProfileModel(
      id: json['id'] ?? json['parentId'] ?? 0,
      fullName: json['fullName'] ?? json['name'] ?? '',
      nationalId: (json['nationalId'] ?? json['childNationalId'] ?? '').toString(),
      birthDate: json['birthDate'] ?? '',
      village: json['village'] ?? '',
      city: json['city'] ?? '',
      gender: json['gender'] ?? '',
      governorate: json['governorate'] ?? '',
      bloodType: json['bloodType'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? 'Doctor',
    );
  }
}
