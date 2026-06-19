import 'package:animate_do/animate_do.dart';
import 'package:ebirth/core/constants/app_colors.dart';
import 'package:ebirth/core/widgets/shimmer_loading.dart';
import 'package:ebirth/features/auth/domain/entities/user_entity.dart';
import 'package:ebirth/features/doctor/domain/entities/doctor_profile_entity.dart';
import 'package:ebirth/features/doctor/presentation/cubit/doctor_profile_cubit.dart';
import 'package:ebirth/features/doctor/presentation/cubit/doctor_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:ebirth/core/helper/auth_token_holder.dart';

class DoctorProfilePage extends StatelessWidget {
  final UserEntity? user;
  const DoctorProfilePage({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          'الملف الشخصي للطبيب',
          style: GoogleFonts.readexPro(
            color: const Color(0xFF1E293B),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF4E8B97),
            size: 20,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
        builder: (context, state) {
          if (state is DoctorProfileLoading) {
            return _buildLoadingState();
          } else if (state is DoctorProfileError) {
            return _buildErrorState(state.message);
          } else if (state is DoctorProfileLoaded) {
            return _buildProfileContent(context, state.profile);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const ShimmerLoading.circular(width: 120, height: 120),
          const SizedBox(height: 24),
          const ShimmerLoading.rectangular(height: 100),
          const SizedBox(height: 16),
          const ShimmerLoading.rectangular(height: 150),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 60),
          const SizedBox(height: 16),
          Text(message, style: GoogleFonts.readexPro(color: Colors.red)),
        ],
      ),
    );
  }

  Widget _buildProfileContent(
    BuildContext context,
    DoctorProfileEntity profile,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 40),
      child: Column(
        children: [
          // Header Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 30),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                FadeInDown(
                  duration: const Duration(milliseconds: 600),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF4E8B97).withOpacity(0.2),
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: const Color(0xFF4E8B97).withOpacity(0.1),
                      child: const Icon(
                        Icons.medication_liquid_sharp,
                        size: 50,
                        color: Color(0xFF4E8B97),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  child: Text(
                    profile.fullName,
                    style: GoogleFonts.readexPro(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                FadeInUp(
                  duration: const Duration(milliseconds: 700),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4E8B97).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'طبيب متخصص',
                      style: GoogleFonts.readexPro(
                        color: const Color(0xFF4E8B97),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Main Info Sections
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                _buildInfoSection(
                  title: 'المعلومات الشخصية',
                  items: [
                    _buildInfoTile(
                      Icons.badge_outlined,
                      'الرقم القومي',
                      profile.nationalId,
                    ),
                    _buildInfoTile(
                      Icons.calendar_today_outlined,
                      'تاريخ الميلاد',
                      profile.birthDate.split('T')[0],
                    ),
                    _buildInfoTile(
                      Icons.wc_outlined,
                      'النوع',
                      (profile.gender == '0' || profile.gender == 'Male') ? 'ذكر' : 'أنثى',
                    ),
                    _buildInfoTile(
                      Icons.bloodtype_outlined,
                      'فصيلة الدم',
                      profile.bloodType.replaceAll('_', ' '),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildInfoSection(
                  title: 'بيانات التواصل والموقع',
                  items: [
                    _buildInfoTile(
                      Icons.email_outlined,
                      'البريد الإلكتروني',
                      profile.email,
                    ),
                    _buildInfoTile(
                      Icons.phone_outlined,
                      'رقم الهاتف',
                      profile.phoneNumber,
                    ),
                    _buildInfoTile(
                      Icons.location_on_outlined,
                      'العنوان',
                      profile.governorate == 'غير متوفر' 
                          ? 'غير متوفر' 
                          : '${profile.governorate}${profile.city != "0" ? "، " + profile.city : ""}${profile.village != "0" ? "، " + profile.village : ""}',
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Settings Section
                FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  child: _buildActionTile(
                    Icons.logout_rounded,
                    'تسجيل الخروج',
                    Colors.red,
                    () => _showLogoutDialog(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection({
    required String title,
    required List<Widget> items,
  }) {
    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8, bottom: 12),
            child: Text(
              title,
              style: GoogleFonts.readexPro(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E293B),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4E8B97).withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(children: items),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF4E8B97).withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF4E8B97), size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.readexPro(
                    fontSize: 12,
                    color: const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: GoogleFonts.readexPro(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile(
    IconData icon,
    String title,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: color.withOpacity(0.1)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: GoogleFonts.readexPro(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: color.withOpacity(0.3),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('تسجيل الخروج', style: GoogleFonts.readexPro()),
        content: Text(
          'هل أنت متأكد من رغبتك في تسجيل الخروج؟',
          style: GoogleFonts.readexPro(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'إلغاء',
              style: GoogleFonts.readexPro(color: const Color(0xFF64748B)),
            ),
          ),
          TextButton(
            onPressed: () {
              AuthTokenHolder.clearToken();
              context.go('/login');
            },
            child: Text(
              'تسجيل الخروج',
              style: GoogleFonts.readexPro(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
