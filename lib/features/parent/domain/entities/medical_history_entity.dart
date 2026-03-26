import 'package:equatable/equatable.dart';

class MedicalHistoryEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String date;
  final String doctorName;
  final String? hospitalName;
  final String? medicine;

  const MedicalHistoryEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.doctorName,
    this.hospitalName,
    this.medicine,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        date,
        doctorName,
        hospitalName,
        medicine,
      ];
}
