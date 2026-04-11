import 'package:ebirth/core/constants/app_colors.dart';
import 'package:ebirth/features/parent/domain/entities/medical_history_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/di/injection_container.dart';
import '../cubit/medical_record_detail_cubit.dart';
import '../cubit/medical_record_detail_state.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:animate_do/animate_do.dart';

class MedicalHistoryList extends StatelessWidget {
  final List<MedicalHistoryEntity> histories;
  final bool isChild;

  const MedicalHistoryList({super.key, required this.histories, this.isChild = true});

  String _formatDate(String raw) {
    try {
      final dt = DateTime.parse(raw);
      return '${dt.year}/${dt.month.toString().padLeft(2, '0')}/${dt.day.toString().padLeft(2, '0')}';
    } catch (_) {
      return raw;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (histories.isEmpty) {
      return Center(
        child: FadeIn(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 48),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF3A8F8E).withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.history_edu_outlined,
                  size: 64,
                  color: const Color(0xFF3A8F8E).withOpacity(0.2),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'لا يوجد تاريخ طبي مسجل حالياً',
                style: GoogleFonts.readexPro(
                  color: const Color(0xFF6B7280),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'سيتم عرض الزيارات الطبية والتشخيصات هنا.',
                style: GoogleFonts.readexPro(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      );
    }

    return AnimationLimiter(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 8, bottom: 24),
        itemCount: histories.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 500),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: _MedicalHistoryCard(
                  history: histories[index], 
                  formatDate: _formatDate,
                  isChild: isChild,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _MedicalHistoryCard extends StatelessWidget {
  final MedicalHistoryEntity history;
  final String Function(String) formatDate;
  final bool isChild;

  const _MedicalHistoryCard({
    required this.history, 
    required this.formatDate,
    required this.isChild,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            offset: Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Left Accent Bar
            Container(
              width: 6,
              color: const Color(0xFF3A8F8E),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header: Doctor & Date
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF3A8F8E).withOpacity(0.08),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.local_hospital_outlined,
                            color: Color(0xFF3A8F8E),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                history.doctorName,
                                style: GoogleFonts.readexPro(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF111827),
                                ),
                              ),
                              Text(
                                formatDate(history.date),
                                style: GoogleFonts.readexPro(
                                  fontSize: 12,
                                  color: const Color(0xFF6B7280),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Diagnosis Section
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFF3F4F6)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.description_outlined, size: 16, color: Color(0xFF6B7280)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              history.description.isNotEmpty ? history.description : history.title,
                              style: GoogleFonts.readexPro(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF374151),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Medicine Section (if available)
                    if (history.medicine != null && history.medicine!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.medication_outlined, size: 16, color: Color(0xFF3A8F8E)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                history.medicine!,
                                style: GoogleFonts.readexPro(
                                  fontSize: 12,
                                  color: const Color(0xFF4B5563),
                                  fontStyle: FontStyle.italic,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Footer Action
                    const Divider(height: 1, color: Color(0xFFF3F4F6)),
                    const SizedBox(height: 12),
                    InkWell(
                      onTap: () => _showDetailsDialog(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'عرض التقرير الطبي الكامل',
                            style: GoogleFonts.readexPro(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3A8F8E),
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.keyboard_arrow_left_rounded,
                            size: 18,
                            color: Color(0xFF3A8F8E),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDetailsDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BlocProvider<MedicalRecordDetailCubit>(
          create: (context) => sl<MedicalRecordDetailCubit>()
            ..fetchRecordDetails(history.id.toString(), isChild),
          child: DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: Column(
                  children: [
                    // Handle
                    Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    Expanded(
                      child: BlocBuilder<MedicalRecordDetailCubit, MedicalRecordDetailState>(
                        builder: (context, state) {
                          if (state is MedicalRecordDetailLoading) {
                            return const Center(child: CircularProgressIndicator(color: Color(0xFF3A8F8E)));
                          }
                          if (state is MedicalRecordDetailError) {
                            return _buildErrorState(state.message);
                          }
                          
                          final detail = (state is MedicalRecordDetailLoaded) ? state.record : history;
                          return ListView(
                            controller: scrollController,
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            children: [
                              _buildAdvancedHeader(detail),
                              const SizedBox(height: 24),
                              
                              FadeInUp(
                                duration: const Duration(milliseconds: 400),
                                child: _buildAdvancedSection(
                                  title: 'التشخيص / الملاحظات',
                                  icon: Icons.analytics_outlined,
                                  color: const Color(0xFFDBEAFE),
                                  iconColor: const Color(0xFF2563EB),
                                  content: detail.description.isNotEmpty ? detail.description : 'لا يوجد تشخيص مسجل.',
                                ),
                              ),
                              const SizedBox(height: 16),
                              
                              FadeInUp(
                                duration: const Duration(milliseconds: 500),
                                child: _buildAdvancedSection(
                                  title: 'الوصفة العلاجية',
                                  icon: Icons.medication_liquid_outlined,
                                  color: const Color(0xFFF0FDF4),
                                  iconColor: const Color(0xFF16A34A),
                                  content: (detail.medicine != null && detail.medicine!.isNotEmpty) 
                                      ? detail.medicine! 
                                      : 'لا يوجد وصف علاجي.',
                                  isPrescription: true,
                                ),
                              ),
                              const SizedBox(height: 16),
                              
                              FadeInUp(
                                duration: const Duration(milliseconds: 600),
                                child: _buildAttachmentsSection(),
                              ),
                              const SizedBox(height: 40),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildAdvancedHeader(dynamic detail) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3A8F8E), Color(0xFF4EBCBA)],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF3A8F8E).withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.person, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    detail.doctorName,
                    style: GoogleFonts.readexPro(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF111827),
                    ),
                  ),
                  Text(
                    'تقرير زيارة عيادة',
                    style: GoogleFonts.readexPro(fontSize: 12, color: const Color(0xFF6B7280)),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Column(
                children: [
                  const Icon(Icons.calendar_month, size: 14, color: Color(0xFF3A8F8E)),
                  Text(
                    formatDate(detail.date),
                    style: GoogleFonts.readexPro(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAdvancedSection({
    required String title,
    required IconData icon,
    required Color color,
    required Color iconColor,
    required String content,
    bool isPrescription = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: GoogleFonts.readexPro(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF374151),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: GoogleFonts.readexPro(
              fontSize: 14,
              color: const Color(0xFF4B5563),
              height: 1.6,
            ),
          ),
          if (isPrescription) ...[
            const SizedBox(height: 12),
            const Divider(color: Color(0xFFF3F4F6)),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.info_outline, size: 14, color: Color(0xFF9CA3AF)),
                const SizedBox(width: 6),
                Text(
                  'يرجى اتباع الجرعات الموصوفة بدقة.',
                  style: GoogleFonts.readexPro(fontSize: 10, color: const Color(0xFF9CA3AF)),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAttachmentsSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.attach_file, color: Color(0xFF6B7280), size: 18),
              const SizedBox(width: 8),
              Text(
                'المرفقات والأشعات',
                style: GoogleFonts.readexPro(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF374151),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE5E7EB), style: BorderStyle.solid),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.cloud_off_outlined, color: Color(0xFF9CA3AF), size: 32),
                const SizedBox(height: 8),
                Text(
                  'لا توجد ملفات مرفقة بهذا التقرير',
                  style: GoogleFonts.readexPro(fontSize: 12, color: const Color(0xFF9CA3AF)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 48),
          const SizedBox(height: 16),
          Text(message, style: GoogleFonts.readexPro()),
        ],
      ),
    );
  }
}
