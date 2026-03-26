import '../../domain/entities/vaccination_entity.dart';

class VaccinationModel extends VaccinationEntity {
  const VaccinationModel({
    required super.id,
    required super.name,
    required super.date,
    required super.isCompleted,
    required super.notes,
  });

  factory VaccinationModel.fromJson(Map<String, dynamic> json) {
    return VaccinationModel(
      id: json['id']?.toString() ?? '',
      name: json['childVaccinationsName'] ?? json['name'] ?? '',
      date: json['takenDate']?.toString() ?? json['officialDate']?.toString() ?? json['date'] ?? '',
      isCompleted: json['status'] == 'Completed' || (json['isCompleted'] == true),
      notes: json['status']?.toString() ?? json['notes'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'date': date,
      'isCompleted': isCompleted,
      'notes': notes,
    };
  }
}
