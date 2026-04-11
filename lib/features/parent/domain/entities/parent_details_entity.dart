import 'package:equatable/equatable.dart';

class ParentDetailsEntity extends Equatable {
  final int parentId;
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

  const ParentDetailsEntity({
    required this.parentId,
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
  });

  @override
  List<Object?> get props => [
        parentId,
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
      ];
}
