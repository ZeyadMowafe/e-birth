import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:ebirth/core/constants/app_colors.dart';
import 'package:ebirth/core/widgets/tap_unfocus.dart';
import 'package:ebirth/features/auth/domain/entities/user_entity.dart';
import '../../../../features/parent/presentation/pages/parent_dashboard_view.dart';

class HomePage extends StatelessWidget {
  final UserEntity? user;
  const HomePage({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    final displayName = user?.displayName ?? '';
    final screenWidth = MediaQuery.of(context).size.width;

    return TapUnfocus(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            // ── Custom Header ─────────────────────────────────────
            Container(
              width: screenWidth,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0D000000),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left: Brand & User Info
                      Row(
                        children: [
                          // Logo Box
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xFFF9FAFB),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                'assets/images/splash_logo.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'E-Birth',
                                style: GoogleFonts.manuale(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18,
                                  height: 1.2,
                                  letterSpacing: -0.45,
                                  color: const Color(0xFF111818),
                                ),
                              ),
                              if (displayName.isNotEmpty)
                                Text(
                                  displayName,
                                  style: const TextStyle(
                                    fontFamily: 'Arial',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11,
                                    height: 1.2,
                                    color: Color(0xFF3A8F8E),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),

                      // Right: Logout Button
                      GestureDetector(
                        onTap: () => context.goNamed('login'),
                        child: Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFE5E5),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Center(
                            child: Transform.rotate(
                              angle: math.pi,
                              child: const Icon(
                                Icons.logout,
                                color: Color(0xFFE7000B),
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ── Body Content ──────────────────────────────────────
            Expanded(
              child: Container(
                width: screenWidth,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFD8E9FE), Color(0xFFC6F6D5)],
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Welcome Banner ───────────────────────────────────
                      Center(
                        child: Container(
                          width: 345,
                          height: 62,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 23,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Color(0xFF4EBCBA), Color(0xFF3A8F8E)],
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x1A000000),
                                offset: Offset(0, 4),
                                blurRadius: 6,
                                spreadRadius: -4,
                              ),
                              BoxShadow(
                                color: Color(0x1A000000),
                                offset: Offset(0, 10),
                                blurRadius: 15,
                                spreadRadius: -3,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Left: Text
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'مرحبا بك',
                                    style: GoogleFonts.readexPro(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      height: 1.1,
                                    ),
                                  ),
                                  Text(
                                    'تابع صحة أطفالك بكل سهولة',
                                    style: GoogleFonts.readexPro(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                      height: 1.1,
                                    ),
                                  ),
                                ],
                              ),
                              // Right: Icon
                              const Icon(
                                Icons.people_outline,
                                color: Colors.white,
                                size: 28,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const SizedBox(height: 24),
                      // Dynamic Dashboard Content based on User Role or ID
                      if (user != null && user!.id.isNotEmpty)
                        ParentDashboardView(parentId: user!.id)
                      else
                        Center(
                          child: Text(
                            'لم يتم التعرف على حساب المستخدم.',
                            style: GoogleFonts.readexPro(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

