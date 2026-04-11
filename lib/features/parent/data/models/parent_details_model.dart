import '../../domain/entities/parent_details_entity.dart';

class ParentDetailsModel extends ParentDetailsEntity {
  const ParentDetailsModel({
    required super.parentId,
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
  });

  factory ParentDetailsModel.fromJson(Map<String, dynamic> json) {
    return ParentDetailsModel(
      parentId: json['parentId'] ?? 0,
      fullName: json['fullName']?.toString() ?? '',
      nationalId: json['nationalId']?.toString() ?? '',
      birthDate: json['birthDate']?.toString() ?? '',
      village: json['village']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      gender: json['gender']?.toString() ?? '',
      governorate: json['governorate']?.toString() ?? '',
      bloodType: json['bloodType']?.toString() ?? '',
      phoneNumber: json['phoneNumber']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'parentId': parentId,
      'fullName': fullName,
      'nationalId': nationalId,
      'birthDate': birthDate,
      'village': village,
      'city': city,
      'gender': gender,
      'governorate': governorate,
      'bloodType': bloodType,
      'phoneNumber': phoneNumber,
      'email': email,
    };
  }
}
