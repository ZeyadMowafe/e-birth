import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ebirth/l10n/app_localizations.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/child_entity.dart';

class ChildBasicInfoTab extends StatelessWidget {
  final ChildEntity child;

  const ChildBasicInfoTab({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSectionCard(
            title: l10n.childDetailsBasicInfo,
            icon: Icons.child_care,
            color: const Color(0xFF4EBCBA),
            children: [
              _buildInfoRow(l10n.fullName, child.fullName),
              _buildInfoRow(l10n.nationalId, child.childNationalId ?? l10n.notAvailable),
              _buildInfoRow(l10n.birthDate, child.birthDate),
              _buildInfoRow(l10n.age, l10n.ageYearsMonths(child.ageWithYears, child.ageWithMonths)),
              _buildInfoRow(l10n.gender, child.gender == 'Male' ? l10n.male : (child.gender == 'Female' ? l10n.female : child.gender)),
              _buildInfoRow(l10n.bloodType, child.bloodType?.replaceAll('_Positive', '+').replaceAll('_Negative', '-') ?? l10n.notAvailable),
            ],
          ),
          const SizedBox(height: 16),
          _buildSectionCard(
            title: l10n.parentInfo,
            icon: Icons.family_restroom,
            color: const Color(0xFF3A8F8E),
            children: [
              _buildInfoRow(l10n.parentName, child.parentFullName ?? l10n.notAvailable),
              _buildInfoRow(l10n.nationalId, child.parentNationalId ?? l10n.notAvailable),
              _buildInfoRow(l10n.phoneNumber, child.parentPhoneNumber ?? l10n.notAvailable),
              _buildInfoRow(l10n.email, child.parentEmail ?? l10n.notAvailable, isLast: true),
            ],
          ),
          const SizedBox(height: 16),
          _buildSectionCard(
            title: l10n.address,
            icon: Icons.location_on_outlined,
            color: const Color(0xFF1DA8C4),
            children: [
              _buildInfoRow(l10n.governorate, child.governorate ?? l10n.notAvailable),
              _buildInfoRow(l10n.city, child.city ?? l10n.notAvailable),
              _buildInfoRow(l10n.village, child.village ?? l10n.notAvailable, isLast: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Color color,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              border: Border(
                bottom: BorderSide(color: color.withOpacity(0.2)),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: GoogleFonts.readexPro(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isLast = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: isLast
          ? null
          : BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.background.withOpacity(0.5),
                ),
              ),
            ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: GoogleFonts.readexPro(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: GoogleFonts.readexPro(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
