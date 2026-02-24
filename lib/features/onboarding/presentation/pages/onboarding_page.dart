import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ebirth/core/constants/app_colors.dart';
import 'package:ebirth/core/widgets/tap_unfocus.dart';
import 'package:ebirth/core/helper/shared_prefs_helper.dart';
import 'package:ebirth/features/onboarding/presentation/widgets/onboarding_slide.dart';
import 'package:ebirth/l10n/app_localizations.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static const _totalPages = 3;

  // Illustrations — network placeholders; replace with real assets later
  static const _images = [
    'https://placehold.co/400x400/EEF4FF/1A73E8/png',
    'https://placehold.co/400x400/F0FFF4/2E7D52/png',
    'https://placehold.co/400x400/FFF8F0/E07B12/png',
  ];

  void _onPageChanged(int page) => setState(() => _currentPage = page);

  Future<void> _finish() async {
    await SharedPrefsHelper.setOnboardingSeen();
    if (mounted) context.goNamed('login');
  }

  void _next() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _finish();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isLast = _currentPage == _totalPages - 1;

    final slides = [
      (
        image: _images[0],
        title: l10n.onboarding1Title,
        desc: l10n.onboarding1Desc,
      ),
      (
        image: _images[1],
        title: l10n.onboarding2Title,
        desc: l10n.onboarding2Desc,
      ),
      (
        image: _images[2],
        title: l10n.onboarding3Title,
        desc: l10n.onboarding3Desc,
      ),
    ];

    return TapUnfocus(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Column(
              children: [
                // ── Header ────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // ── E-Birth centered ───────────────────
                      const Text(
                        'E-Birth',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                          letterSpacing: -0.3,
                        ),
                      ),

                      // ── Skip on the right ──────────────────
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: AnimatedOpacity(
                          opacity: isLast ? 0 : 1,
                          duration: const Duration(milliseconds: 300),
                          child: TextButton(
                            onPressed: isLast ? null : _finish,
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.textSecondary,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 4,
                              ),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              l10n.onboardingSkip,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Page content ──────────────────────────────────────
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    itemCount: _totalPages,
                    itemBuilder: (_, i) => OnboardingSlide(
                      imageUrl: slides[i].image,
                      title: slides[i].title,
                      description: slides[i].desc,
                    ),
                  ),
                ),

                // ── Dots indicator ────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _totalPages,
                    (i) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: _currentPage == i ? 28 : 8,
                      decoration: BoxDecoration(
                        color: _currentPage == i
                            ? AppColors.primary
                            : AppColors.border,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // ── Next / Get Started button ─────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: _next,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: Text(
                          isLast
                              ? l10n.onboardingGetStarted
                              : l10n.onboardingNext,
                          key: ValueKey(isLast),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 36),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
