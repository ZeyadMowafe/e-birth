import 'package:flutter/material.dart';
import 'package:ebirth/core/constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingSlide extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final double borderRadius;
  final BoxFit fit;

  const OnboardingSlide({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    this.borderRadius = 24,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ), // Reduced space from top to move image up
            // ── Image ─────────────────────────────
            LayoutBuilder(
              builder: (context, constraints) {
                final size = constraints
                    .maxWidth; // Use available width to stay square and responsive
                return Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Opacity(
                    opacity: 1.0,
                    child: Image.asset(
                      imageUrl,
                      fit: fit,
                      errorBuilder: (context, error, stackTrace) {
                        return const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.image_not_supported_rounded,
                              size: 100,
                              color: AppColors.onboardingTitle,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Asset Error',
                              style: TextStyle(color: AppColors.error),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 40),

            // ── Title ─────────────────────────────
            Text(
              title,
              style: GoogleFonts.readexPro(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: AppColors.onboardingTitle,
                height: 1.25, // line-height 40 / font-size 32
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            // ── Description ───────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                description,
                style: GoogleFonts.readexPro(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.onboardingDesc,
                  height: 2.1, // line-height 24 / font-size 16
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
