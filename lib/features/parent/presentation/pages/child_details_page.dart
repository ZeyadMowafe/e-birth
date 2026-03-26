import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection_container.dart';
import '../../domain/entities/child_entity.dart';
import '../cubit/child_details_cubit.dart';
import '../cubit/child_details_state.dart';
import '../widgets/vaccination_timeline.dart';
import '../widgets/medical_history_list.dart';
import '../widgets/child_basic_info_tab.dart';

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

class _ChildDetailsPageState extends State<ChildDetailsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ChildDetailsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _cubit = sl<ChildDetailsCubit>()..fetchChildDetails(widget.childId);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: CustomScrollView(
          slivers: [
            // Header
            SliverAppBar(
              expandedHeight: 220,
              pinned: true,
              backgroundColor: AppColors.primary,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  widget.initialChild?.fullName ?? 'التفاصيل',
                  style: GoogleFonts.readexPro(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF4EBCBA), Color(0xFF3A8F8E)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 48),
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Center(
                            child: Text(
                              widget.initialChild?.fullName.isNotEmpty == true
                                  ? widget.initialChild!.fullName[0].toUpperCase()
                                  : '؟',
                              style: GoogleFonts.readexPro(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'العمر: ${widget.initialChild?.ageWithYears ?? '-'} سنة و ${widget.initialChild?.ageWithMonths ?? '-'} شهر',
                          style: GoogleFonts.readexPro(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            
            // Tab Bar
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                TabBar(
                  controller: _tabController,
                  labelColor: AppColors.primary,
                  unselectedLabelColor: AppColors.textSecondary,
                  labelStyle: GoogleFonts.readexPro(fontWeight: FontWeight.bold),
                  indicatorColor: AppColors.primary,
                  indicatorWeight: 3,
                  tabs: const [
                    Tab(text: 'البيانات الأساسية'),
                    Tab(text: 'التطعيمات'),
                    Tab(text: 'التاريخ الطبي'),
                  ],
                ),
              ),
            ),

            // Content Body
            SliverFillRemaining(
              child: BlocBuilder<ChildDetailsCubit, ChildDetailsState>(
                builder: (context, state) {
                  if (state is ChildDetailsLoading || state is ChildDetailsInitial) {
                    return const Center(child: CircularProgressIndicator(color: AppColors.primary));
                  } else if (state is ChildDetailsError) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.error_outline, size: 48, color: AppColors.error),
                          const SizedBox(height: 16),
                          Text(
                            'حدث خطأ: ${state.message}',
                            style: GoogleFonts.readexPro(color: AppColors.textPrimary),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => _cubit.fetchChildDetails(widget.childId),
                            child: const Text('إعادة المحاولة'),
                          ),
                        ],
                      ),
                    );
                  } else if (state is ChildDetailsLoaded) {
                    return TabBarView(
                      controller: _tabController,
                      children: [
                        ChildBasicInfoTab(child: state.childDetails),
                        VaccinationTimeline(vaccinations: state.vaccinations),
                        MedicalHistoryList(histories: state.medicalHistories),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
