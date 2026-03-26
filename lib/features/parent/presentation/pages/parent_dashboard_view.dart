import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection_container.dart';
import '../cubit/parent_cubit.dart';
import '../cubit/parent_state.dart';
import '../widgets/child_card.dart';

class ParentDashboardView extends StatefulWidget {
  final String parentId;

  const ParentDashboardView({super.key, required this.parentId});

  @override
  State<ParentDashboardView> createState() => _ParentDashboardViewState();
}

class _ParentDashboardViewState extends State<ParentDashboardView> {
  late ParentCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = sl<ParentCubit>()..getParentData(widget.parentId);
  }

  @override
  void didUpdateWidget(covariant ParentDashboardView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.parentId != widget.parentId) {
      _cubit.getParentData(widget.parentId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocBuilder<ParentCubit, ParentState>(
        builder: (context, state) {
          if (state is ParentLoading || state is ParentInitial) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            );
          } else if (state is ParentError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: AppColors.error),
                  const SizedBox(height: 16),
                  Text(
                    'حدث خطأ في جلب البيانات\n${state.message}',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.readexPro(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _cubit.getParentData(widget.parentId),
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            );
          } else if (state is ParentLoaded) {
            final parent = state.parent;
            final children = parent.children;

            if (children.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text(
                    'لا يوجد أطفال مسجلين حالياً',
                    style: GoogleFonts.readexPro(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16, top: 8),
                  child: Text(
                    'أطفالي',
                    style: GoogleFonts.readexPro(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: children.length,
                  itemBuilder: (context, index) {
                    final child = children[index];
                    return ChildCard(
                      child: child,
                      onTap: () {
                        context.pushNamed(
                          'child-details',
                          pathParameters: {'id': child.id.toString()},
                          extra: child, // Pass the child entity directly for immediate UI
                        );
                      },
                    );
                  },
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
