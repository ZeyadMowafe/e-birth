import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF1A73E8);
  static const Color primaryDark = Color(0xFF0D47A1);
  static const Color primaryLight = Color(0xFF4A90D9);
  static const Color accent = Color(0xFF00BCD4);

  static const Color background = Color(0xFFF5F7FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color error = Color(0xFFE53935);
  static const Color success = Color(0xFF43A047);

  static const Color textPrimary = Color(0xFF1C1C1E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textHint = Color(0xFFADB5BD);

  static const Color border = Color(0xFFE0E0E0);
  static const Color inputFill = Color(0xFFF9FAFB);

  // Onboarding
  static const Color onboardingBackground = Color(0xFFF9FAFB);
  static const Color onboardingGradientStart = Color(0xFFD8E9FE);
  static const Color onboardingTitle = Color(0xFF111818);
  static const Color onboardingDesc = Color(0xFF4B5563);
  static const Color onboardingButtonStart = Color(0xFF4EBCBA);
  static const Color onboardingButtonEnd = Color(0xFF3A8F8E);
  static const Color onboardingButtonShadow = Color(
    0x334EBCCB,
  ); // 20% of 4EBCCB

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1A73E8), Color(0xFF0D47A1)],
  );

  static const LinearGradient onboardingGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFD8E9FE), Color(0xFFC6F6D5)],
  );
}
