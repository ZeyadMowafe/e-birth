import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ebirth/core/constants/app_colors.dart';
import 'package:ebirth/core/widgets/auth_layout.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      showLogo: false,
      headerCrossAxisAlignment: CrossAxisAlignment.start,
      bottomSheetHeight: 644,
      bottomSheetPadding: const EdgeInsets.only(top: 32, left: 24, right: 24),
      title: 'إنشاء حساب جديد',
      titleStyle: const TextStyle(
        fontFamily: 'Arial',
        fontWeight: FontWeight.w700, // Bold
        fontSize: 40,
        height: 40 / 40,
        color: Colors.white,
      ),
      subtitle: 'حدد نوع الحساب الذي تريد إنشاءه',
      subtitleStyle: const TextStyle(
        fontWeight: FontWeight.w600, // SemiBold
        fontSize: 16,
        height: 24 / 16,
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),

            // ── Parent Card ────────────────────────────────────────
            _RoleCard(
              icon: Icons.family_restroom_rounded,
              title: 'ولي أمر',
              subtitle: 'سجّل لتتمكن من متابعة شهادات ميلاد أطفالك',
              color: AppColors.primary,
              onTap: () => context.pushNamed('register', extra: 'Parent'),
            ),
            const SizedBox(height: 16),

            // ── Doctor Card ────────────────────────────────────────
            _RoleCard(
              icon: Icons.medical_services_outlined,
              title: 'طبيب',
              subtitle:
                  'سجّل كطبيب مع رفع مستندات التحقق — سيتم المراجعة خلال 72 ساعة',
              color: const Color(0xFF00897B),
              onTap: () => context.pushNamed('register', extra: 'Doctor'),
            ),
            const SizedBox(height: 48),

            // ── Footer Login Link ──────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'لديك حساب بالفعل؟',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
                TextButton(
                  onPressed: () => context.pop(),
                  child: const Text(
                    'تسجيل الدخول',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _RoleCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(15),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
          border: Border.all(color: color.withAlpha(40), width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: color.withAlpha(25),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.arrow_forward_ios_rounded, color: color, size: 18),
          ],
        ),
      ),
    );
  }
}
