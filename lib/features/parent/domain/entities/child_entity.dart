import 'package:equatable/equatable.dart';

class ChildEntity extends Equatable {
  final int id;
  final String fullName;
  final int ageWithYears;
  final int ageWithMonths;
  final String gender;
  final String birthDate;
  
  // Extended details
  final String? childNationalId;
  final String? village;
  final String? city;
  final String? governorate;
  final String? bloodType;
  final String? parentFullName;
  final String? parentPhoneNumber;
  final String? parentNationalId;
  final String? parentEmail;
  final String userType; // 'Child' or 'Parent'

  const ChildEntity({
    required this.id,
    required this.fullName,
    required this.ageWithYears,
    required this.ageWithMonths,
    required this.gender,
    required this.birthDate,
    this.childNationalId,
    this.village,
    this.city,
    this.governorate,
    this.bloodType,
    this.parentFullName,
    this.parentPhoneNumber,
    this.parentNationalId,
    this.parentEmail,
    this.userType = 'Child',
  });

  @override
  List<Object?> get props => [
        id,
        fullName,
        ageWithYears,
        ageWithMonths,
        gender,
        birthDate,
        childNationalId,
        village,
        city,
        governorate,
        bloodType,
        parentFullName,
        parentPhoneNumber,
        parentNationalId,
        parentEmail,
        userType,
      ];
}
