import '../../domain/entities/child_entity.dart';

class ChildModel extends ChildEntity {
  const ChildModel({
    required super.id,
    required super.fullName,
    required super.ageWithYears,
    required super.ageWithMonths,
    required super.gender,
    required super.birthDate,
    super.childNationalId,
    super.village,
    super.city,
    super.governorate,
    super.bloodType,
    super.parentFullName,
    super.parentPhoneNumber,
    super.parentNationalId,
    super.parentEmail,
  });

  factory ChildModel.fromJson(Map<String, dynamic> json) {
    // Handle both GetParentWithChildren array items and GetChildDetails object
    final idVal = json['childId'] ?? json['id'];
    int parsedId = 0;
    if (idVal is int) {
      parsedId = idVal;
    } else {
      parsedId = int.tryParse(idVal?.toString() ?? '0') ?? 0;
    }

    return ChildModel(
      id: parsedId,
      fullName: json['childFullName'] ?? json['fullName'] ?? '',
      ageWithYears: json['ageWithYears'] ?? 0,
      ageWithMonths: json['ageWithMonths'] ?? 0,
      gender: json['gender'] ?? '',
      birthDate: json['birthDate'] ?? '',
      childNationalId: json['childNationalId']?.toString(),
      village: json['village']?.toString(),
      city: json['city']?.toString(),
      governorate: json['governorate']?.toString(),
      bloodType: json['bloodType']?.toString(),
      parentFullName: json['parentFullName']?.toString(),
      parentPhoneNumber: json['parentPhoneNumber']?.toString(),
      parentNationalId: json['parentNationalId']?.toString(),
      parentEmail: json['parentEmail']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'ageWithYears': ageWithYears,
      'ageWithMonths': ageWithMonths,
      'gender': gender,
      'birthDate': birthDate,
      if (childNationalId != null) 'childNationalId': childNationalId,
      if (village != null) 'village': village,
      if (city != null) 'city': city,
      if (governorate != null) 'governorate': governorate,
      if (bloodType != null) 'bloodType': bloodType,
      if (parentFullName != null) 'parentFullName': parentFullName,
      if (parentPhoneNumber != null) 'parentPhoneNumber': parentPhoneNumber,
      if (parentNationalId != null) 'parentNationalId': parentNationalId,
      if (parentEmail != null) 'parentEmail': parentEmail,
    };
  }
}
