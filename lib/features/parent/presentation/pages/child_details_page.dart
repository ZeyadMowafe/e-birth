import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/di/injection_container.dart';
import '../../domain/entities/child_entity.dart';
import '../cubit/child_details_cubit.dart';
import '../cubit/child_details_state.dart';
import '../widgets/vaccination_timeline.dart';
import '../widgets/medical_history_list.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import 'package:animate_do/animate_do.dart';

class ChildDetailsPage extends StatefulWidget {
  final String childId;
  final ChildEntity? initialChild;

  const ChildDetailsPage({
    super.key,
    required this.childId,
    this.initialChild,
  });

  @override
  State<ChildDetailsPage> createState() => _ChildDetailsPageState();
}

class _ChildDetailsPageState extends State<ChildDetailsPage> {
  late ChildDetailsCubit _cubit;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _cubit = sl<ChildDetailsCubit>()..fetchChildDetails(widget.childId);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  String _formatAge(ChildEntity? c) {
    if (c == null) return '-';
    if (c.ageWithYears > 0) return '${c.ageWithYears} سنة و ${c.ageWithMonths} شهر';
    if (c.ageWithMonths > 0) return '${c.ageWithMonths} شهر';
    return 'حديث الولادة';
  }

  String _formatDate(String raw) {
    try {
      final dt = DateTime.parse(raw);
      return '${dt.year}/${dt.month.toString().padLeft(2, '0')}/${dt.day.toString().padLeft(2, '0')}';
    } catch (_) {
      return raw;
    }
  }

  String _formatGender(String g) {
    if (g.toLowerCase() == 'male' || g == 'ذكر') return 'ذكر';
    if (g.toLowerCase() == 'female' || g == 'أنثى') return 'أنثى';
    return g;
  }

  String _formatBlood(String? b) {
    if (b == null) return 'غير متوفر';
    return b.replaceAll('_Positive', '+').replaceAll('_Negative', '-');
  }

  @override
  Widget build(BuildContext context) {
    final initialChild = widget.initialChild;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F4F6),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
            child: Column(
              children: [
                // ── Back button + title ──────────────────────────────
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x1A000000),
                              blurRadius: 4,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 16,
                          color: Color(0xFF374151),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'ملف الطفل',
                      style: GoogleFonts.readexPro(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF111827),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // ── Hero Card (341×120) ─────────────────────────────
                FadeInDown(
                  duration: const Duration(milliseconds: 600),
                  child: Container(
                    width: 341,
                    height: 120,
                    padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1A000000),
                          offset: Offset(0, 1),
                          blurRadius: 2,
                          spreadRadius: -1,
                        ),
                        BoxShadow(
                          color: Color(0x1A000000),
                          offset: Offset(0, 1),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Avatar 80×80
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFFDBEAFE), Color(0xFFBEDBFF)],
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            initialChild?.fullName.isNotEmpty == true
                                ? initialChild!.fullName[0].toUpperCase()
                                : '؟',
                            style: GoogleFonts.readexPro(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1D4ED8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Name + age + national id
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              initialChild?.fullName ?? 'جاري التحميل...',
                              style: GoogleFonts.readexPro(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF111827),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'العمر: ${_formatAge(initialChild)}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF6B7280),
                              ),
                            ),
                            const SizedBox(height: 2),
                            BlocBuilder<ChildDetailsCubit, ChildDetailsState>(
                              builder: (context, state) {
                                final nationalId = state is ChildDetailsLoaded
                                    ? (state.childDetails.childNationalId ?? 'غير متوفر')
                                    : (initialChild?.childNationalId ?? '-');
                                return Text(
                                  'ر.ق: $nationalId',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF9CA3AF),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),),

                const SizedBox(height: 16),

                // ── Custom Tab Bar (341×40) ─────────────────────────
                SizedBox(
                  width: 341,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTab(0, 'البيانات الأساسية'),
                      _buildTab(1, 'جدول التطعيمات'),
                      _buildTab(2, 'التاريخ المرضي'),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // ── Tab Content ─────────────────────────────────────
                BlocBuilder<ChildDetailsCubit, ChildDetailsState>(
                  builder: (context, state) {
                    if (state is ChildDetailsLoading || state is ChildDetailsInitial) {
                      return Column(
                        children: [
                          const SizedBox(height: 20),
                          ...List.generate(4, (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: const ShimmerLoading.rectangular(height: 60),
                          )),
                        ],
                      );
                    }
                    if (state is ChildDetailsError) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: Column(
                          children: [
                            const Icon(Icons.error_outline, size: 48, color: Colors.red),
                            const SizedBox(height: 12),
                            Text(
                              'حدث خطأ: ${state.message}',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.readexPro(fontSize: 13),
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () => _cubit.fetchChildDetails(widget.childId),
                              child: const Text('إعادة المحاولة'),
                            ),
                          ],
                        ),
                      );
                    }
                    if (state is ChildDetailsLoaded) {
                      if (_selectedTab == 0) {
                        return FadeInUp(
                          duration: const Duration(milliseconds: 500),
                          child: _buildInfoCard(state.childDetails, screenWidth),
                        );
                      } else if (_selectedTab == 1) {
                        return VaccinationTimeline(vaccinations: state.vaccinations);
                      } else {
                        return FadeInUp(
                          duration: const Duration(milliseconds: 500),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF4EBCBA).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(Icons.history_edu, color: Color(0xFF4EBCBA), size: 20),
                                    ),
                                    const SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'التاريخ المرضي والزيارات',
                                          style: GoogleFonts.readexPro(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF111827),
                                          ),
                                        ),
                                        Text(
                                          'عرض لجميع التشخيصات والتقارير الطبية السابقة',
                                          style: GoogleFonts.readexPro(
                                            fontSize: 11,
                                            color: const Color(0xFF6B7280),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              MedicalHistoryList(
                                histories: state.medicalHistories,
                                isChild: true,
                              ),
                            ],
                          ),
                        );
                      }
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Tab button ──────────────────────────────────────────────────
  Widget _buildTab(int index, String label) {
    final isActive = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Container(
        width: 105,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF4EBCBA) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: isActive
              ? [
                  const BoxShadow(
                    color: Color(0x40000000),
                    blurRadius: 7,
                    spreadRadius: 0,
                    offset: Offset(0, 0),
                    blurStyle: BlurStyle.inner,
                  ),
                ]
              : [
                  const BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 3,
                    offset: Offset(0, 1),
                  ),
                ],
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Arial',
            fontWeight: FontWeight.w700,
            fontSize: 11,
            color: isActive ? Colors.white : const Color(0xFF6B7280),
            height: 1.3,
          ),
        ),
      ),
    );
  }

  // ── Basic Info Card (341×541) ────────────────────────────────────
  Widget _buildInfoCard(ChildEntity child, double screenWidth) {
    return Container(
      width: 341,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, 1),
            blurRadius: 2,
            spreadRadius: -1,
          ),
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, 1),
            blurRadius: 3,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          Row(
            children: [
              Container(
                width: 4,
                height: 18,
                decoration: BoxDecoration(
                  color: const Color(0xFF4EBCBA),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'المعلومات الشخصية',
                style: GoogleFonts.readexPro(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF111827),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          _infoRow(icon: Icons.person_outline, label: 'الاسم بالكامل', value: child.fullName),
          _divider(),
          _infoRow(icon: Icons.badge_outlined, label: 'الرقم القومي', value: child.childNationalId ?? 'غير متوفر'),
          _divider(),
          _infoRow(icon: Icons.cake_outlined, label: 'تاريخ الميلاد', value: _formatDate(child.birthDate)),
          _divider(),
          _infoRow(icon: Icons.access_time_outlined, label: 'العمر', value: _formatAge(child)),
          _divider(),
          _infoRow(
            icon: child.gender.toLowerCase() == 'female' ? Icons.female : Icons.male,
            label: 'الجنس',
            value: _formatGender(child.gender),
          ),
          _divider(),
          _infoRow(icon: Icons.water_drop_outlined, label: 'فصيلة الدم', value: _formatBlood(child.bloodType)),
          _divider(),
          _infoRow(icon: Icons.location_city_outlined, label: 'المحافظة', value: child.governorate ?? 'غير متوفر'),
          _divider(),
          _infoRow(icon: Icons.apartment_outlined, label: 'المدينة', value: child.city ?? 'غير متوفر'),
          _divider(),
          _infoRow(icon: Icons.holiday_village_outlined, label: 'القرية', value: child.village ?? 'غير متوفر'),
        ],
      ),
    );
  }

  Widget _infoRow({required IconData icon, required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, size: 16, color: const Color(0xFF4EBCBA)),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF6B7280),
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() => const Divider(height: 1, color: Color(0xFFF3F4F6));

  // ── Generic content wrapper ─────────────────────────────────────
  Widget _buildContentWrapper({required Widget child}) {
    return Container(
      width: 341,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, 1),
            blurRadius: 3,
          ),
        ],
      ),
      child: child,
    );
  }
}
