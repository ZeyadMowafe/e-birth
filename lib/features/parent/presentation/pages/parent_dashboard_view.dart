import 'package:ebirth/core/constants/app_colors.dart';
import 'package:ebirth/core/di/injection_container.dart';
import 'package:ebirth/core/widgets/shimmer_loading.dart';
import 'package:ebirth/features/parent/domain/entities/parent_entity.dart';
import 'package:ebirth/features/parent/presentation/cubit/parent_cubit.dart';
import 'package:ebirth/features/parent/presentation/cubit/parent_state.dart';
import 'package:ebirth/features/parent/presentation/widgets/child_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:animate_do/animate_do.dart';
import 'package:ebirth/l10n/app_localizations.dart';

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
            final l10n = AppLocalizations.of(context)!;
          if (state is ParentLoading || state is ParentInitial) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ShimmerLoading.rectangular(height: 24, width: 100),
                const SizedBox(height: 16),
                ...List.generate(
                  3,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: const ShimmerLoading.rectangular(height: 120),
                  ),
                ),
              ],
            );
          } else if (state is ParentError) {
            final isParentNotFound = state.message.toLowerCase().contains('parent not found');
            if (isParentNotFound) {
              return _buildParentNotFound();
            }
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 48,
                    color: AppColors.error,
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.readexPro(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _cubit.getParentData(widget.parentId),
                    child: Text(l10n.retry),
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
                    l10n.noChildrenRegistered,
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
                // Section header
                Row(
                  children: [
                    Container(
                      width: 4,
                      height: 20,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3A8F8E),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 8),
                    FadeInRight(
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        l10n.myChildren,
                        style: GoogleFonts.readexPro(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF111827),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3A8F8E).withAlpha(25),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${children.length}',
                        style: GoogleFonts.readexPro(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF3A8F8E),
                        ),
                      ),
                    ),
                  ],
                ),
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
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
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
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildParentNotFound() {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.error.withAlpha(25),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.search_off_rounded,
                color: AppColors.error,
                size: 56,
              ),
            ),
            const SizedBox(height: 28),
            Text(
              l10n.parentDashboardParentNotFound,
              style: GoogleFonts.readexPro(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1F2937),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.parentDashboardParentNotFoundMsg,
              style: GoogleFonts.readexPro(
                fontSize: 14,
                color: const Color(0xFF6B7280),
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => _cubit.getParentData(widget.parentId),
              child: Text(l10n.retry),
            ),
          ],
        ),
      ),
    );
  }
}
