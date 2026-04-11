import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../domain/entities/parent_details_entity.dart';
import '../cubit/parent_profile_cubit.dart';
import '../cubit/parent_profile_state.dart';

class ParentProfilePage extends StatelessWidget {
  final UserEntity? user;

  const ParentProfilePage({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF111827), size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'الملف الشخصي',
          style: GoogleFonts.readexPro(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF111827),
          ),
        ),
      ),
      body: BlocBuilder<ParentProfileCubit, ParentProfileState>(
        builder: (context, state) {
          if (state is ParentProfileInitial || state is ParentProfileLoading) {
            return _buildLoadingState();
          } else if (state is ParentProfileError) {
            return _buildErrorState(context, state.message);
          } else if (state is ParentProfileLoaded) {
            return _buildProfileContent(context, state.parentDetails);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const ShimmerLoading.circular(width: 100, height: 100),
          const SizedBox(height: 24),
          const ShimmerLoading.rectangular(height: 24, width: 200),
          const SizedBox(height: 40),
          ...List.generate(5, (index) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: const ShimmerLoading.rectangular(height: 70),
          )),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.redAccent),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.readexPro(color: Colors.redAccent),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (user != null) {
                  context.read<ParentProfileCubit>().fetchParentProfile(user!.id);
                }
              },
              child: const Text('إعادة المحاولة'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, ParentDetailsEntity details) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Header Section
          _buildHeader(details),
          
          // Details Sections
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AnimationLimiter(
              child: Column(
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 600),
                  childAnimationBuilder: (widget) => FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    child: widget,
                  ),
                  children: [
                    const SizedBox(height: 24),
                    
                    // Basic Information Section
                    _buildSectionTitle('المعلومات الأساسية'),
                    const SizedBox(height: 12),
                    _buildInfoCard(Icons.person_outline, 'الاسم بالكامل', details.fullName),
                    _buildInfoCard(Icons.badge_outlined, 'الرقم القومي', details.nationalId),
                    Row(
                      children: [
                        Expanded(child: _buildInfoCard(Icons.cake_outlined, 'تاريخ الميلاد', details.birthDate.split('T')[0])),
                        const SizedBox(width: 12),
                        Expanded(child: _buildInfoCard(Icons.wc_outlined, 'الجنس', details.gender == 'Male' ? 'ذكر' : 'أنثى')),
                      ],
                    ),
                    _buildInfoCard(Icons.bloodtype_outlined, 'فصيلة الدم', details.bloodType.replaceAll('_', ' ')),

                    const SizedBox(height: 24),
                    
                    // Contact & Location Section
                    _buildSectionTitle('بيانات التواصل والعنوان'),
                    const SizedBox(height: 12),
                    _buildInfoCard(Icons.phone_outlined, 'رقم الهاتف', details.phoneNumber),
                    _buildInfoCard(Icons.email_outlined, 'البريد الإلكتروني', details.email),
                    _buildInfoCard(Icons.map_outlined, 'المحافظة / المدينة', '${details.governorate} - ${details.city}'),
                    _buildInfoCard(Icons.home_outlined, 'القرية / العنوان', details.village),

                    const SizedBox(height: 24),
                    
                    // Shortcuts Section
                    _buildSectionTitle('السجلات والخدمات'),
                    const SizedBox(height: 12),
                    _buildMedicalHistoryShortcut(context),

                    const SizedBox(height: 32),
                    _buildActionButtons(context),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(ParentDetailsEntity details) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.only(top: 24, bottom: 32),
      child: Column(
        children: [
          FadeIn(
            duration: const Duration(seconds: 1),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFF3F4F6),
                border: Border.all(color: const Color(0xFFE5E7EB), width: 3),
              ),
              child: const Icon(Icons.person, size: 50, color: Color(0xFF9CA3AF)),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            details.fullName,
            style: GoogleFonts.readexPro(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF3A8F8E).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'ولي أمر',
              style: GoogleFonts.readexPro(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF3A8F8E),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 16,
          decoration: BoxDecoration(
            color: const Color(0xFF3A8F8E),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.readexPro(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF374151),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFF6B7280), size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.readexPro(fontSize: 11, color: const Color(0xFF9CA3AF)),
                ),
                Text(
                  value.isNotEmpty ? value : 'غير متوفر',
                  style: GoogleFonts.readexPro(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF111827),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicalHistoryShortcut(BuildContext context) {
    return InkWell(
      onTap: () => context.pushNamed('parent-medical-history', extra: user),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF3A8F8E).withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF3A8F8E).withOpacity(0.1)),
        ),
        child: Row(
          children: [
            const Icon(Icons.history_edu_outlined, color: Color(0xFF3A8F8E)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'عرض سجلي الطبي الشخصي',
                    style: GoogleFonts.readexPro(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'الوصفات، الفحوصات والتقارير الطبية',
                    style: GoogleFonts.readexPro(fontSize: 10, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 12, color: Color(0xFF3A8F8E)),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton.icon(
            onPressed: () {
              // Edit profile placeholder
            },
            icon: const Icon(Icons.edit_outlined, size: 18),
            label: const Text('تعديل الملف الشخصي'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3A8F8E),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton.icon(
            onPressed: () => context.go('/login'),
            icon: const Icon(Icons.logout, size: 18),
            label: const Text('تسجيل الخروج'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.redAccent,
              side: const BorderSide(color: Colors.redAccent),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
      ],
    );
  }
}
