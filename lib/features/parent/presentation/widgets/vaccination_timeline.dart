import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ebirth/l10n/app_localizations.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/vaccination_entity.dart';

enum VaccinationStatus { completed, delayed, upcoming }

class VaccinationTimeline extends StatelessWidget {
  final List<VaccinationEntity> vaccinations;

  const VaccinationTimeline({super.key, required this.vaccinations});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (vaccinations.isEmpty) {
      return Center(
        child: Text(
          l10n.vaccinationNoRecords,
          style: GoogleFonts.readexPro(color: AppColors.textSecondary),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      itemCount: vaccinations.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return Center(
          child: _VaccinationCard(vaccine: vaccinations[index]),
        );
      },
    );
  }
}

class _VaccinationCard extends StatelessWidget {
  final VaccinationEntity vaccine;

  const _VaccinationCard({required this.vaccine});

  VaccinationStatus get _status {
    if (vaccine.isCompleted) return VaccinationStatus.completed;
    try {
      final vDate = DateTime.parse(vaccine.date);
      // Remove time information from both dates for fair comparison
      final today = DateTime.now();
      final todayDate = DateTime(today.year, today.month, today.day);
      final vaccineDate = DateTime(vDate.year, vDate.month, vDate.day);
      
      if (vaccineDate.isBefore(todayDate)) {
        return VaccinationStatus.delayed;
      }
    } catch (_) {}
    return VaccinationStatus.upcoming;
  }

  String _formatDate(String raw) {
    try {
      final dt = DateTime.parse(raw);
      return '${dt.year}/${dt.month.toString().padLeft(2, '0')}/${dt.day.toString().padLeft(2, '0')}';
    } catch (_) {
      return raw;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final status = _status;
    Color statusColor;
    String statusText;
    IconData statusIcon;

    switch (status) {
      case VaccinationStatus.completed:
        statusColor = const Color(0xFF10B981); // Emerald 500
        statusText = l10n.complete;
        statusIcon = Icons.check_circle_outline;
        break;
      case VaccinationStatus.delayed:
        statusColor = const Color(0xFFEF4444); // Red 500
        statusText = l10n.late;
        statusIcon = Icons.warning_amber_rounded;
        break;
      case VaccinationStatus.upcoming:
        statusColor = const Color(0xFF3B82F6); // Blue 500
        statusText = l10n.upcoming;
        statusIcon = Icons.schedule;
        break;
    }

    return Container(
      width: 341,
      height: 124,
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, 1),
            blurRadius: 2,
            spreadRadius: -1,
          ),
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, 1),
            blurRadius: 3,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              SizedBox(
                width: 197,
                child: Text(
                  vaccine.name,
                  style: GoogleFonts.readexPro(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF111827),
                    height: 1.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 8),

              // Date
              Row(
                children: [
                  Icon(Icons.calendar_today_outlined, size: 14, color: const Color(0xFF6B7280)),
                  const SizedBox(width: 4),
                  Text(
                    _formatDate(vaccine.date),
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF6B7280),
                      fontFamily: 'Arial',
                    ),
                  ),
                ],
              ),
              const Spacer(),

              // Bottom section (icon + Status indication)
              Row(
                children: [
                  Icon(
                    statusIcon,
                    size: 20,
                    color: statusColor,
                  ),
                  const SizedBox(width: 8),
                  if (status == VaccinationStatus.completed)
                    Text(
                      l10n.vaccinationDateLabel(_formatDate(vaccine.date)),
                      style: GoogleFonts.readexPro(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: statusColor,
                      ),
                    )
                  else if (status == VaccinationStatus.delayed)
                    Text(
                      l10n.vaccinationGoNow,
                      style: GoogleFonts.readexPro(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: statusColor,
                      ),
                    )
                  else if (status == VaccinationStatus.upcoming)
                    Text(
                      l10n.vaccinationPending,
                      style: GoogleFonts.readexPro(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: statusColor,
                      ),
                    ),
                ],
              ),
            ],
          ),

          // Status Badge at top-left (RTL means it's usually on the left)
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              height: 24,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: statusColor,
                  width: 1.6,
                ),
                color: statusColor.withOpacity(0.05),
              ),
              alignment: Alignment.center,
              child: Text(
                statusText,
                style: GoogleFonts.readexPro(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: statusColor,
                  height: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
