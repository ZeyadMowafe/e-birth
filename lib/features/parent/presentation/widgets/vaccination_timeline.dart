import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/vaccination_entity.dart';

class VaccinationTimeline extends StatelessWidget {
  final List<VaccinationEntity> vaccinations;

  const VaccinationTimeline({super.key, required this.vaccinations});

  @override
  Widget build(BuildContext context) {
    if (vaccinations.isEmpty) {
      return Center(
        child: Text(
          'لا توجد سجلات تطعيم.',
          style: GoogleFonts.readexPro(color: AppColors.textSecondary),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      itemCount: vaccinations.length,
      itemBuilder: (context, index) {
        final vaccine = vaccinations[index];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline Line & Dot
            Column(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: vaccine.isCompleted ? AppColors.success : Colors.grey.shade400,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: vaccine.isCompleted ? AppColors.success.withOpacity(0.3) : Colors.transparent,
                      width: 4,
                    ),
                  ),
                ),
                if (index != vaccinations.length - 1)
                  Container(
                    width: 2,
                    height: 80,
                    color: vaccine.isCompleted ? AppColors.success : Colors.grey.shade300,
                  ),
              ],
            ),
            const SizedBox(width: 16),
            // Content Card
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 24),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0A000000),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vaccine.name,
                      style: GoogleFonts.readexPro(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 14, color: AppColors.textSecondary),
                        const SizedBox(width: 4),
                        Text(
                          vaccine.date,
                          style: GoogleFonts.readexPro(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    if (vaccine.notes.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        vaccine.notes,
                        style: GoogleFonts.readexPro(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
