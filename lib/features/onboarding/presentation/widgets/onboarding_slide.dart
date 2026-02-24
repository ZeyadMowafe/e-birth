import 'package:flutter/material.dart';
import 'package:ebirth/core/constants/app_colors.dart';

class OnboardingSlide extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  const OnboardingSlide({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ── Image ─────────────────────────────
            Container(
              width: size.width * 0.72,
              height: size.width * 0.72,
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(15),
                borderRadius: BorderRadius.circular(32),
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (_, child, progress) {
                  if (progress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                      strokeWidth: 2,
                    ),
                  );
                },
                errorBuilder: (_, __, ___) => Icon(
                  Icons.child_care_rounded,
                  size: size.width * 0.28,
                  color: AppColors.primary,
                ),
              ),
            ),

            const SizedBox(height: 48),

            // ── Title ─────────────────────────────
            Text(
              title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            // ── Description ───────────────────────
            Text(
              description,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.textSecondary,
                height: 1.8,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
