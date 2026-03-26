import 'package:equatable/equatable.dart';

class VaccinationEntity extends Equatable {
  final String id;
  final String name;
  final String date;
  final bool isCompleted;
  final String notes;

  const VaccinationEntity({
    required this.id,
    required this.name,
    required this.date,
    required this.isCompleted,
    required this.notes,
  });

  @override
  List<Object?> get props => [id, name, date, isCompleted, notes];
}
