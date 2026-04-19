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
    super.userType = 'Child',
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

    // Calculate age if missing (common in Parent details response)
    int ageYears = json['ageWithYears'] ?? 0;
    if (ageYears == 0 && json['birthDate'] != null) {
      try {
        final birthDate = DateTime.parse(json['birthDate']);
        final now = DateTime.now();
        ageYears = now.year - birthDate.year;
        if (now.month < birthDate.month || (now.month == birthDate.month && now.day < birthDate.day)) {
          ageYears--;
        }
      } catch (_) {}
    }

    return ChildModel(
      id: parsedId,
      fullName: json['childFullName'] ?? json['fullName'] ?? '',
      ageWithYears: ageYears,
      ageWithMonths: json['ageWithMonths'] ?? 0,
      gender: json['gender'] ?? '',
      birthDate: json['birthDate'] ?? '',
      childNationalId: (json['childNationalId'] ?? json['nationalId'])?.toString(),
      village: json['village']?.toString(),
      city: json['city']?.toString(),
      governorate: json['governorate']?.toString(),
      bloodType: json['bloodType']?.toString(),
      parentFullName: json['parentFullName']?.toString(),
      parentPhoneNumber: json['parentPhoneNumber']?.toString(),
      parentNationalId: json['parentNationalId']?.toString(),
      parentEmail: json['parentEmail']?.toString(),
      userType: json['userType']?.toString() ?? 'Child',
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
