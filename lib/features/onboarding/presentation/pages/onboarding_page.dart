import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ebirth/core/constants/app_colors.dart';
import 'package:ebirth/core/widgets/tap_unfocus.dart';
import 'package:ebirth/core/helper/shared_prefs_helper.dart';
import 'package:ebirth/features/onboarding/presentation/widgets/onboarding_slide.dart';
import 'package:ebirth/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

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

  // Illustrations — using local assets
  static const _images = [
    'assets/images/onboarding_1.png',
    'assets/images/Overlay.png',
    'assets/images/Overlay+Border+Shadow+OverlayBlur.png',
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

  void _back() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
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
    final isNotFirst = _currentPage > 0;

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
          body: Container(
            decoration: const BoxDecoration(
              color: AppColors.onboardingBackground,
              gradient: AppColors.onboardingGradient,
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // ── Header ────────────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Skip button on the Right (Start in RTL)
                        AnimatedOpacity(
                          opacity: isLast ? 0 : 1,
                          duration: const Duration(milliseconds: 300),
                          child: TextButton(
                            onPressed: isLast ? null : _finish,
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.textSecondary,
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              l10n.onboardingSkip,
                              style: GoogleFonts.readexPro(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.onboardingDesc,
                                height: 1.5,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ),
                        ),

                        // Back arrow on the Left (End in RTL)
                        AnimatedOpacity(
                          opacity: isNotFirst ? 1 : 0,
                          duration: const Duration(milliseconds: 300),
                          child: IconButton(
                            onPressed: isNotFirst ? _back : null,
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: AppColors.onboardingDesc,
                            ),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ── Page content ──────────────────────────────────────
                  Expanded(
                    child: Directionality(
                      textDirection:
                          TextDirection.ltr, // Force slider to start from left
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: _onPageChanged,
                        itemCount: _totalPages,
                        itemBuilder: (_, i) => OnboardingSlide(
                          imageUrl: slides[i].image,
                          title: slides[i].title,
                          description: slides[i].desc,
                          borderRadius: i == 1
                              ? 175
                              : 20, // Keep circular for 2nd if preferred, but user said square. I'll use 20 for all square.
                          fit: i == 2 ? BoxFit.contain : BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  // ── Dots indicator ────────────────────────────────────
                  Directionality(
                    textDirection: TextDirection
                        .ltr, // Force dots to start from left (index 0 on left)
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _totalPages,
                        (i) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 8,
                          width: _currentPage == i ? 24 : 8,
                          decoration: BoxDecoration(
                            color: _currentPage == i
                                ? const Color(0xFF4EBCBA)
                                : const Color(0xFFC0D3D3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ── Next / Get Started button ─────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Container(
                      width: 326,
                      height: 64,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: const LinearGradient(
                          begin: Alignment
                              .centerRight, // 270deg -> from right to left
                          end: Alignment.centerLeft,
                          colors: [
                            AppColors.onboardingButtonStart,
                            AppColors.onboardingButtonEnd,
                          ],
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x334EBCCB), // rgba(78, 188, 186, 0.2)
                            offset: Offset(0, 4),
                            blurRadius: 6,
                            spreadRadius: -4,
                          ),
                          BoxShadow(
                            color: Color(0x334EBCCB),
                            offset: Offset(0, 10),
                            blurRadius: 15,
                            spreadRadius: -3,
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: _next,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.arrow_back, size: 20),
                            const SizedBox(width: 10),
                            Text(
                              isLast
                                  ? l10n.onboardingGetStarted
                                  : l10n.onboardingNext,
                              style: GoogleFonts.readexPro(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                height: 1.5,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 52),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
