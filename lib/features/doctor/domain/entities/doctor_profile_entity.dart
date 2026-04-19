import 'package:equatable/equatable.dart';

class DoctorProfileEntity extends Equatable {
  final int id;
  final String fullName;
  final String nationalId;
  final String birthDate;
  final String village;
  final String city;
  final String gender;
  final String governorate;
  final String bloodType;
  final String phoneNumber;
  final String email;
  final String role;

  const DoctorProfileEntity({
    required this.id,
    required this.fullName,
    required this.nationalId,
    required this.birthDate,
    required this.village,
    required this.city,
    required this.gender,
    required this.governorate,
    required this.bloodType,
    required this.phoneNumber,
    required this.email,
    required this.role,
  });

  @override
  List<Object?> get props => [
        id,
        fullName,
        nationalId,
        birthDate,
        village,
        city,
        gender,
        governorate,
        bloodType,
        phoneNumber,
        email,
        role,
      ];
}
