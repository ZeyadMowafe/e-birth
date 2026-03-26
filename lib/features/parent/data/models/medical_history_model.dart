import '../../domain/entities/medical_history_entity.dart';

class MedicalHistoryModel extends MedicalHistoryEntity {
  const MedicalHistoryModel({
    required super.id,
    required super.title,
    required super.description,
    required super.date,
    required super.doctorName,
    super.hospitalName,
    super.medicine,
  });

  factory MedicalHistoryModel.fromJson(Map<String, dynamic> json) {
    String dateStr = json['givenAt']?.toString() ?? json['date']?.toString() ?? '';
    if (dateStr.contains('T')) {
      dateStr = dateStr.split('T')[0];
    }
    
    return MedicalHistoryModel(
      id: json['medicalRecordId']?.toString() ?? json['id']?.toString() ?? '',
      title: json['medicine']?.toString() ?? json['title'] ?? 'سجل طبي',
      description: json['description'] ?? '',
      date: dateStr,
      doctorName: json['doctorName'] ?? 'غير متوفر',
      hospitalName: json['hospitalName']?.toString(),
      medicine: json['medicine']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'doctorName': doctorName,
      if (hospitalName != null) 'hospitalName': hospitalName,
      if (medicine != null) 'medicine': medicine,
    };
  }
}
