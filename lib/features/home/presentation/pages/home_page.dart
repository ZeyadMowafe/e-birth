import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:ebirth/core/constants/app_colors.dart';
import 'package:ebirth/core/cubit/locale_cubit.dart';
import 'package:ebirth/core/widgets/tap_unfocus.dart';
import 'package:ebirth/features/auth/domain/entities/user_entity.dart';
import 'package:ebirth/core/helper/auth_token_holder.dart';
import 'package:ebirth/core/helper/shared_prefs_helper.dart';
import '../../../../features/parent/presentation/pages/parent_dashboard_view.dart';
import '../widgets/doctor_dashboard_view.dart';
import 'package:animate_do/animate_do.dart';
import 'package:ebirth/l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  final UserEntity? user;
  const HomePage({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final displayName = user?.displayName ?? '';
    final screenWidth = MediaQuery.of(context).size.width;

    return TapUnfocus(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 80,
          titleSpacing: 20,
          title: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFFF9FAFB),
                  border: Border.all(color: const Color(0xFFF3F4F6)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/icons/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'E-Birth',
                    style: GoogleFonts.manuale(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      letterSpacing: -0.5,
                      color: const Color(0xFF111818),
                    ),
                  ),
                  if (displayName.isNotEmpty)
                    Text(
                      '${l10n.homeWelcome} $displayName',
                      style: GoogleFonts.readexPro(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: const Color(0xFF3A8F8E),
                      ),
                    ),
                ],
              ),
            ],
          ),
          actions: [
            Builder(
              builder: (ctx) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: InkWell(
                  onTap: () => Scaffold.of(ctx).openEndDrawer(),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: const Icon(
                      Icons.settings_outlined,
                      color: Color(0xFF4B5563),
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        endDrawer: Drawer(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              bottomLeft: Radius.circular(24),
            ),
          ),
          child: Column(
            children: [
              // Drawer Header
              Container(
                padding: const EdgeInsets.only(top: 60, bottom: 24, left: 24, right: 24),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFDBEAFE), Color(0xFFC6F6D5)],
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x1A000000),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          )
                        ],
                      ),
                      child: const Center(
                        child: Icon(Icons.person, size: 32, color: Color(0xFF3A8F8E)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            displayName.isNotEmpty ? displayName : l10n.homeUnknownUser,
                            style: GoogleFonts.readexPro(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1F2937),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user?.role.toLowerCase().contains('doctor') == true
                                ? l10n.doctorAccount
                                : l10n.parentAccount,
                            style: GoogleFonts.readexPro(
                              fontSize: 12,
                              color: const Color(0xFF4B5563),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              
              // Settings Options
              _buildDrawerItem(
                icon: Icons.person_outline,
                title: l10n.profile,
                onTap: () {
                  Navigator.of(context).pop();
                  context.pushNamed('profile', extra: user);
                },
              ),
              _buildDrawerItem(
                icon: Icons.history_edu_outlined,
                title: l10n.medicalHistory,
                onTap: () {
                  Navigator.of(context).pop();
                  context.pushNamed('parent-medical-history', extra: user);
                },
              ),
              _buildDrawerItem(
                icon: Icons.notifications_none_outlined,
                title: l10n.notifications,
                onTap: () {
                  Navigator.of(context).pop();
                  // TODO: Navigate to notifications
                },
              ),
              _buildDrawerItem(
                icon: Icons.language_outlined,
                title: context.select((LocaleCubit c) => c.state.languageCode) == 'ar'
                    ? 'English'
                    : 'العربية',
                onTap: () {
                  Navigator.of(context).pop();
                  context.read<LocaleCubit>().toggle();
                },
              ),
              _buildDrawerItem(
                icon: Icons.help_outline,
                title: l10n.helpAndSupport,
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              
              const Spacer(),
              const Divider(height: 1, color: Color(0xFFF3F4F6)),
              
              // Logout Option
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () async {
                    AuthTokenHolder.clearToken();
                    await SharedPrefsHelper.clearToken();
                    if (context.mounted) context.goNamed('login');
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF2F2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.logout, color: Color(0xFFEF4444), size: 20),
                        const SizedBox(width: 8),
                        Text(
                          l10n.logout,
                          style: GoogleFonts.readexPro(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFEF4444),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
        body: Column(
          children: [
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
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: user?.role.toLowerCase().contains('doctor') == true
                                  ? [const Color(0xFF427D8D), const Color(0xFF4E8B97)]
                                  : [const Color(0xFF4EBCBA), const Color(0xFF3A8F8E)],
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
                                      user?.role.toLowerCase().contains('doctor') == true
                                          ? l10n.homeDoctorGreeting
                                          : l10n.homeWelcomeSubtitle,
                                      style: GoogleFonts.readexPro(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        height: 1.1,
                                      ),
                                    ),
                                    Text(
                                      user?.role.toLowerCase().contains('doctor') == true
                                          ? l10n.homeDoctorTitle
                                          : l10n.homeDoctorDesc,
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
                              Icon(
                                user?.role.toLowerCase().contains('doctor') == true
                                    ? Icons.medical_services_outlined
                                    : Icons.people_outline,
                                color: Colors.white,
                                size: 28,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // ── Children Cards ─────────────────────────────────
                      if (user != null && user!.id.isNotEmpty)
                        Center(
                          child: SizedBox(
                            width: 345,
                            child: user!.role.toLowerCase().contains('doctor')
                                ? DoctorDashboardView(userId: user!.id)
                                : ParentDashboardView(parentId: user!.id),
                          ),
                        )
                      else
                        Center(
                          child: Text(
                            l10n.homeUnknownUser,
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

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF6B7280), size: 24),
            const SizedBox(width: 16),
            Text(
              title,
              style: GoogleFonts.readexPro(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF374151),
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF9CA3AF)),
          ],
        ),
      ),
    );
  }
}


