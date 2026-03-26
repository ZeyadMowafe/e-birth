import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ebirth/core/constants/app_colors.dart';
import 'package:ebirth/core/widgets/auth_layout.dart';
import 'package:ebirth/features/auth/domain/entities/user_entity.dart';

class LoginRoleChoicePage extends StatelessWidget {
  final UserEntity user;

  const LoginRoleChoicePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      showLogo: false,
      showBackButton: true,
      headerCrossAxisAlignment: CrossAxisAlignment.start,
      bottomSheetHeight: MediaQuery.of(context).size.height * 0.72,
      headerTopPadding: 90.0,
      bottomSheetPadding: const EdgeInsets.only(top: 32, left: 24, right: 24),
      title: 'تسجيل الدخول',
      titleStyle: const TextStyle(
        fontFamily: 'Arial',
        fontWeight: FontWeight.w700,
        fontSize: 40,
        height: 1.0,
        color: Colors.white,
      ),
      subtitle: 'اختر وضع الدخول المناسب لك',
      subtitleStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        height: 1.5,
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),

          // ── Parent Mode Card ─────────────────────────────────────
          _ChoiceCard(
            icon: Icons.person_outline,
            title: 'دخول كـ ولي أمر',
            subtitle: 'استخدام التطبيق لمتابعة أطفالك',
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFB8ECC8), Color(0xFF9DD9B4)],
            ),
            iconColor: const Color(0xFF1DA8C4),
            onTap: () =>
                context.goNamed('home', extra: user.copyWith(role: 'Parent')),
          ),
          const SizedBox(height: 16),

          // ── Doctor Mode Card ─────────────────────────────────────
          _ChoiceCard(
            icon: Icons.monitor_heart_outlined,
            title: 'دخول كـ طبيب',
            subtitle: 'استخدام التطبيق لإدارة السجلات الطبية',
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF1DA8C4), Color(0xFF16899F)],
            ),
            textColor: Colors.white,
            iconColor: const Color(0xFF1DA8C4),
            onTap: () => context.goNamed('home', extra: user),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _ChoiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Gradient gradient;
  final VoidCallback onTap;
  final Color? textColor;
  final Color? iconColor;

  const _ChoiceCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.gradient,
    required this.onTap,
    this.textColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveTextColor = textColor ?? AppColors.textPrimary;
    final effectiveSubtitleColor =
        textColor?.withOpacity(0.8) ?? AppColors.textSecondary;
    final effectiveIconColor = iconColor ?? AppColors.primary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 124,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 6,
              offset: Offset(0, 4),
              spreadRadius: -4,
            ),
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 15,
              offset: Offset(0, 10),
              spreadRadius: -3,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: effectiveTextColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: effectiveSubtitleColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: effectiveIconColor, size: 28),
            ),
          ],
        ),
      ),
    );
  }
}
