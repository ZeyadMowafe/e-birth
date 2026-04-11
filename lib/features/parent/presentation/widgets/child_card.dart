import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/child_entity.dart';

class ChildCard extends StatelessWidget {
  final ChildEntity child;
  final VoidCallback onTap;

  const ChildCard({
    super.key,
    required this.child,
    required this.onTap,
  });

  String _formatAge() {
    if (child.ageWithYears > 0) {
      return '${child.ageWithYears} سنة';
    } else if (child.ageWithMonths > 0) {
      return '${child.ageWithMonths} شهر';
    }
    return 'حديث الولادة';
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
    final isFemal = child.gender.toLowerCase().contains('female') ||
        child.gender == 'أنثى' ||
        child.gender == 'f' ||
        child.gender == 'F';

    return Container(
      width: 345,
      margin: const EdgeInsets.only(bottom: 16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Top Row: Avatar + Info ──────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar box 64×64
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFDBEAFE), Color(0xFFBEDBFF)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    child.fullName.isNotEmpty
                        ? child.fullName[0].toUpperCase()
                        : '؟',
                    style: GoogleFonts.readexPro(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1D4ED8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Info column 225×72
              SizedBox(
                height: 72,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Name
                    Text(
                      child.fullName,
                      style: GoogleFonts.readexPro(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF111827),
                        height: 1.3,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // Age
                    _InfoRow(
                      icon: Icons.cake_outlined,
                      label: 'العمر: ${_formatAge()}',
                    ),
                    const SizedBox(height: 2),
                    // Birth date + gender
                    _InfoRow(
                      icon: Icons.calendar_today_outlined,
                      label: _formatDate(child.birthDate),
                    ),
                    const SizedBox(height: 2),
                    _InfoRow(
                      icon: isFemal
                          ? Icons.female_outlined
                          : Icons.male_outlined,
                      label: isFemal ? 'أنثى' : 'ذكر',
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // ── Bottom Button ───────────────────────────────────────
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 305,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF3A8F8E),
                borderRadius: BorderRadius.circular(14),
              ),
              alignment: Alignment.center,
              child: Text(
                'عرض الملف الكامل',
                style: GoogleFonts.readexPro(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Helper widget ────────────────────────────────────────────────
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 12, color: const Color(0xFF6B7280)),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF6B7280),
            height: 1.2,
          ),
        ),
      ],
    );
  }
}
