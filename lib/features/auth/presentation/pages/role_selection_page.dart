import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ebirth/core/constants/app_colors.dart';
import 'package:ebirth/core/widgets/auth_layout.dart';
import 'package:animate_do/animate_do.dart';
import 'package:ebirth/l10n/app_localizations.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AuthLayout(
      showLogo: false,
      showBackButton: true,
      headerCrossAxisAlignment: CrossAxisAlignment.start,
      headerTopPadding: 90.0,
      bottomSheetHeight: 644,
      bottomSheetPadding: const EdgeInsets.only(top: 32, left: 24, right: 24),
      title: l10n.roleSelectionTitle,
      titleStyle: const TextStyle(
        fontFamily: 'Arial',
        fontWeight: FontWeight.w700, // Bold
        fontSize: 40,
        height: 40 / 40,
        color: Colors.white,
      ),
      subtitle: l10n.roleSelectionSubtitle,
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
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 100),
              child: _RoleCard(
                icon: Icons.person_outline,
                title: l10n.roleParent,
                subtitle: l10n.roleParentDesc,
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFB8ECC8), Color(0xFF9DD9B4)],
                ),
                iconColor: const Color(
                  0xFF1DA8C4,
                ), // Keeping it matching the theme, or user can specify later
                onTap: () => context.pushNamed('register', extra: 'Parent'),
              ),
            ),
            const SizedBox(height: 16),

            // ── Doctor Card ────────────────────────────────────────
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 300),
              child: _RoleCard(
                icon: Icons.monitor_heart_outlined,
                title: l10n.roleDoctor,
                subtitle: l10n.roleDoctorDesc,
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF1DA8C4), Color(0xFF16899F)],
                ),
                textColor: Colors.white,
                iconColor: const Color(0xFF1DA8C4),
                onTap: () => context.pushNamed('register', extra: 'Doctor'),
              ),
            ),
            const SizedBox(height: 48),

            // ── Footer Login Link ──────────────────────────
            FadeIn(
              duration: const Duration(milliseconds: 800),
              delay: const Duration(milliseconds: 500),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l10n.roleAlreadyHaveAccount,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.pop(),
                    child: Text(
                      l10n.roleSignIn,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
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
  final Gradient gradient;
  final VoidCallback onTap;
  final Color? textColor;
  final Color? iconColor;

  const _RoleCard({
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
        textColor?.withAlpha(200) ?? AppColors.textSecondary;
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
              color: Color(0x1A000000), // #0000001A
              blurRadius: 6,
              offset: Offset(0, 4),
              spreadRadius: -4,
            ),
            BoxShadow(
              color: Color(0x1A000000), // #0000001A
              blurRadius: 15,
              offset: Offset(0, 10),
              spreadRadius: -3,
            ),
          ],
        ),
        child: Row(
          children: [
            // Title and Subtitle (Right side in RTL)
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
            // Icon (Left side in RTL because it is placed second in the Row)
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
