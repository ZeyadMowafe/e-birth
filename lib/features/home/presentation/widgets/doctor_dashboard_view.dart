import 'package:ebirth/core/di/injection_container.dart';
import 'package:ebirth/core/widgets/shimmer_loading.dart';
import 'package:ebirth/features/doctor/presentation/cubit/doctor_dashboard_cubit.dart';
import 'package:ebirth/features/doctor/presentation/cubit/doctor_dashboard_state.dart';
import 'package:ebirth/features/doctor/presentation/cubit/doctor_search_cubit.dart';
import 'package:ebirth/features/doctor/presentation/cubit/doctor_search_state.dart';
import 'package:ebirth/features/doctor/presentation/cubit/add_medical_record_cubit.dart';
import 'package:ebirth/features/doctor/presentation/widgets/add_medical_record_dialog.dart';
import 'package:ebirth/features/parent/presentation/widgets/child_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';

class DoctorDashboardView extends StatefulWidget {
  final String userId;
  const DoctorDashboardView({super.key, required this.userId});

  @override
  State<DoctorDashboardView> createState() => _DoctorDashboardViewState();
}

class _DoctorDashboardViewState extends State<DoctorDashboardView> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              sl<DoctorDashboardCubit>()
                ..fetchDoctorDashboardData(widget.userId),
        ),
        BlocProvider(create: (context) => sl<DoctorSearchCubit>()),
        BlocProvider(create: (context) => sl<AddMedicalRecordCubit>()),
      ],
      child: BlocBuilder<DoctorDashboardCubit, DoctorDashboardState>(
        builder: (context, state) {
          if (state is DoctorDashboardLoading ||
              state is DoctorDashboardInitial) {
            return _buildLoadingState();
          } else if (state is DoctorDashboardError) {
            return _buildErrorState(state.message);
          } else if (state is DoctorDashboardLoaded) {
            final data = state.data;
            return _buildDashboardContent(context, data);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return Column(
      children: [
        const ShimmerLoading.rectangular(height: 120),
        const SizedBox(height: 24),
        const ShimmerLoading.rectangular(height: 100),
      ],
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Text(message, style: GoogleFonts.readexPro(color: Colors.red)),
    );
  }

  Widget _buildDashboardContent(BuildContext context, dynamic data) {
    final children = data.children ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Search Section ─────────────────────────────────────
        _buildSearchBar(context),
        const SizedBox(height: 24),

        // ── Search Results ─────────────────────────────────────
        _buildSearchResults(context),

        // ── Stats Row ──────────────────────────────────────────
        AnimationLimiter(
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.4,
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 600),
              childAnimationBuilder: (widget) => FadeInUp(
                duration: const Duration(milliseconds: 600),
                child: widget,
              ),
              children: [
                // _buildStatCard(
                //   title: 'إجمالي الحالات',
                //   value: '154',
                //   icon: Icons.people_alt_outlined,
                //   color: const Color(0xFF4E8B97),
                // ),
                // _buildStatCard(
                //   title: 'بلاغات اليوم',
                //   value: '12',
                //   icon: Icons.app_registration_outlined,
                //   color: const Color(0xFF2E7D32),
                // ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // ── "My Children" Section (The Hybrid Part) ────────────────
        if (children.isNotEmpty) ...[
          _buildSectionTitle('أطفالي'),
          const SizedBox(height: 16),
          AnimationLimiter(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: children.length,
              itemBuilder: (context, index) {
                final child = children[index];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 600),
                  child: FadeInRight(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ChildCard(
                        child: child,
                        onTap: () {
                          context.pushNamed(
                            'child-details',
                            pathParameters: {'id': child.id.toString()},
                            extra: child,
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
        ],

        // ── Recent Activity Section ─────────────────────────────
        // _buildSectionTitleWithAction('آخر النشاطات الطبية', 'عرض الكل')
        const SizedBox(height: 12),

        // AnimationLimiter(
        //   child: ListView.builder(
        //     shrinkWrap: true,
        //     physics: const NeverScrollableScrollPhysics(),
        //     itemCount: 3,
        //     itemBuilder: (context, index) {
        //       return AnimationConfiguration.staggeredList(
        //         position: index,
        //         duration: const Duration(milliseconds: 600),
        //         child: SlideAnimation(
        //           verticalOffset: 30.0,
        //           child: FadeInAnimation(child: _buildActivityItem(index)),
        //         ),
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              onSubmitted: (val) =>
                  context.read<DoctorSearchCubit>().searchForChild(val),
              decoration: InputDecoration(
                hintText: 'البحث برقم الطفل القومي...',
                hintStyle: GoogleFonts.readexPro(
                  fontSize: 14,
                  color: const Color(0xFF94A3B8),
                ),
                prefixIcon: const Icon(Icons.search, color: Color(0xFF4E8B97)),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Color(0xFF94A3B8)),
                        onPressed: () {
                          _searchController.clear();
                          context.read<DoctorSearchCubit>().clearSearch();
                          setState(() {});
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
              ),
              onChanged: (val) => setState(() {}),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: GestureDetector(
              onTap: () => context.read<DoctorSearchCubit>().searchForChild(
                _searchController.text,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF4E8B97),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'بحث',
                  style: GoogleFonts.readexPro(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(BuildContext context) {
    return BlocBuilder<DoctorSearchCubit, DoctorSearchState>(
      builder: (context, state) {
        if (state is DoctorSearchLoading) {
          return const Padding(
            padding: EdgeInsets.only(bottom: 24),
            child: ShimmerLoading.rectangular(height: 150),
          );
        } else if (state is DoctorSearchError) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.withOpacity(0.1)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      state.message,
                      style: GoogleFonts.readexPro(
                        color: Colors.red,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is DoctorSearchSuccess) {
          final child = state.child;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('نتيجة البحث'),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4E8B97).withOpacity(0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                  border: Border.all(
                    color: const Color(0xFF4E8B97).withOpacity(0.1),
                  ),
                ),
                child: Column(
                  children: [
                    // Header with Avatar and Basic Info
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFF4E8B97).withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.person,
                            color: Color(0xFF4E8B97),
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                child.fullName,
                                style: GoogleFonts.readexPro(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF1E293B),
                                ),
                              ),
                              Text(
                                'الرقم القومي: ${child.childNationalId ?? '---'}',
                                style: GoogleFonts.readexPro(
                                  fontSize: 12,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        ),
                        _buildDataBadge(
                          child.gender == 'Male' ? 'ذكر' : 'أنثى',
                          child.gender == 'Male' ? Colors.blue : Colors.pink,
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Divider(height: 1, color: Color(0xFFF1F5F9)),
                    ),

                    // Detailed Info Grid
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoItem(
                            Icons.cake_outlined,
                            'تاريخ الميلاد',
                            child.birthDate.split('T')[0],
                          ),
                        ),
                        Expanded(
                          child: _buildInfoItem(
                            Icons.bloodtype_outlined,
                            'فصيلة الدم',
                            child.bloodType ?? 'غير محدد',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoItem(
                            Icons.location_on_outlined,
                            'العنوان',
                            '${child.governorate ?? ''} - ${child.city ?? ''}',
                          ),
                        ),
                        Expanded(
                          child: _buildInfoItem(
                            Icons.family_restroom_outlined,
                            'ولي الأمر',
                            child.parentFullName ?? 'غير متوفر',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Actions
                    Row(
                      children: [
                        Expanded(
                          child: _buildActionButton(
                            'إضافة ملاحظة',
                            Icons.add_comment_outlined,
                            const Color(0xFF4E8B97),
                            () {
                              showDialog(
                                context: context,
                                builder: (dialogCtx) => BlocProvider.value(
                                  value: context.read<AddMedicalRecordCubit>(),
                                  child: AddMedicalRecordDialog(
                                    childId: child.id,
                                    childName: child.fullName,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildActionButton(
                            'الملف الكامل',
                            Icons.visibility_outlined,
                            const Color(0xFF1E293B),
                            () {
                              context.pushNamed(
                                'child-details',
                                pathParameters: {'id': child.id.toString()},
                                extra: child,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildDataBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: GoogleFonts.readexPro(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: const Color(0xFF64748B)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.readexPro(
                  fontSize: 10,
                  color: const Color(0xFF94A3B8),
                ),
              ),
              Text(
                value,
                style: GoogleFonts.readexPro(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF334155),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.readexPro(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: const Color(0xFF4E8B97),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.readexPro(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF111827),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitleWithAction(String title, String action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSectionTitle(title),
        TextButton(
          onPressed: () {},
          child: Text(
            action,
            style: GoogleFonts.readexPro(
              fontSize: 13,
              color: const Color(0xFF4E8B97),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const Spacer(),
          Text(
            value,
            style: GoogleFonts.readexPro(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E2939),
            ),
          ),
          Text(
            title,
            style: GoogleFonts.readexPro(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(int index) {
    final titles = [
      'تم تسجيل مولود جديد',
      'تحديث سجل طبي',
      'إصدار شهادة ميلاد',
    ];
    final subtitles = ['خالد أحمد علي', 'سارة محمود حسن', 'ياسين عمر إبراهيم'];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.history,
              color: Color(0xFF64748B),
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titles[index],
                  style: GoogleFonts.readexPro(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E2939),
                  ),
                ),
                Text(
                  subtitles[index],
                  style: GoogleFonts.readexPro(
                    fontSize: 12,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          Text(
            'منذ ${index + 1} ساعة',
            style: GoogleFonts.readexPro(
              fontSize: 10,
              color: const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }
}
