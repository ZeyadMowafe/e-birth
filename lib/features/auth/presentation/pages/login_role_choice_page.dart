import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:ebirth/core/constants/app_colors.dart';
import 'package:ebirth/core/widgets/auth_layout.dart';
import 'package:ebirth/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

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
      headerTopPadding: 60.0,
      bottomSheetPadding: const EdgeInsets.only(top: 32, left: 24, right: 24),
      title: 'تسجيل الدخول',
      titleStyle: const TextStyle(
        fontFamily: 'Arial',
        fontWeight: FontWeight.w700,
        fontSize: 32,
        height: 1.2,
        color: Colors.white,
      ),
      subtitle: 'اختر وضع الدخول المناسب لك للمتابعة',
      subtitleStyle: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        height: 1.5,
        color: Colors.white70,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),
          AnimationLimiter(
            child: Column(
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 600),
                childAnimationBuilder: (widget) => SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(child: widget),
                ),
                children: [
                  // ── Parent Mode Card ─────────────────────────────────────
                  _ChoiceCard(
                    icon: Icons.family_restroom_outlined,
                    title: 'دخول كـ ولي أمر',
                    subtitle: 'استخدام التطبيق لمتابعة أطفالك والتقارير الطبية',
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFB8ECC8), Color(0xFFE5F9E0)],
                    ),
                    iconColor: const Color(0xFF2E7D32),
                    onTap: () => context.goNamed('home',
                        extra: user.copyWith(role: 'Parent')),
                  ),
                  const SizedBox(height: 20),

                  // ── Doctor Mode Card ─────────────────────────────────────
                  _ChoiceCard(
                    icon: Icons.medical_services_outlined,
                    title: 'دخول كـ طبيب',
                    subtitle: 'استخدام التطبيق لإدارة السجلات الطبية للمرضى',
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF4E8B97), Color(0xFF67B2BE)],
                    ),
                    textColor: Colors.white,
                    iconColor: const Color(0xFF4E8B97),
                    onTap: () => context.goNamed('home', extra: user),
                  ),
                  const SizedBox(height: 32),
                  
                  FadeIn(
                    delay: const Duration(milliseconds: 800),
                    child: Center(
                      child: Text(
                        'يمكنك دائماً تغيير وضع الدخول من الإعدادات',
                        style: TextStyle(
                          color: AppColors.textSecondary.withOpacity(0.6),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
    final effectiveTextColor = textColor ?? const Color(0xFF1E2939);
    final effectiveSubtitleColor =
        textColor?.withOpacity(0.8) ?? const Color(0xFF4A5565);
    final effectiveIconColor = iconColor ?? AppColors.primary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 140,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: (iconColor ?? Colors.black).withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
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
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: effectiveTextColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: effectiveSubtitleColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(icon, color: effectiveIconColor, size: 32),
            ),
          ],
        ),
      ),
    );
  }
}
