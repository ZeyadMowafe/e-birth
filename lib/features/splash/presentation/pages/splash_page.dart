import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ebirth/core/constants/app_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;
  late Animation<double> _textFadeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _scaleAnim = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _textFadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.forward();

    // Navigate after animation completes + small delay
    Future.delayed(const Duration(milliseconds: 2600), _navigate);
  }

  Future<void> _navigate() async {
    if (!mounted) return;
    // Force onboarding during development as requested
    context.goNamed('onboarding');
    /*
    final seen = await SharedPrefsHelper.isOnboardingSeen();
    if (!mounted) return;
    if (seen) {
      context.goNamed('login');
    } else {
      context.goNamed('onboarding');
    }
    */
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.25, 1.0), // ~345.44deg
            end: Alignment(-0.25, -1.0),
            colors: [Color(0xFF1DA8C4), Color(0xFFB8ECC8)],
          ),
        ),
        child: Column(
          children: [
            const Spacer(flex: 5),

            // ── Logo ──────────────────────────────────────────────
            FadeTransition(
              opacity: _fadeAnim,
              child: ScaleTransition(
                scale: _scaleAnim,
                child: SizedBox(
                  width: 300,
                  height: 300,
                  child: Image.asset(
                    'assets/images/splash_logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ── App Name: E-Birth ──────────────────────────────────
            FadeTransition(
              opacity: _textFadeAnim,
              child: Text(
                'E-Birth',
                textAlign: TextAlign.center,
                style: GoogleFonts.bevan(
                  color: const Color(0xFF1E2939),
                  fontSize: 45,
                  fontWeight: FontWeight.w400,
                  height: 32 / 45,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ── Subtitle 1 ────────────────────────────────────────
            FadeTransition(
              opacity: _textFadeAnim,
              child: Text(
                'نظام إدارة السجل الصحي للأطفال',
                textAlign: TextAlign.center,
                style: GoogleFonts.notoSansArabic(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  height: 40 / 22,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // ── Subtitle 2 ────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: FadeTransition(
                opacity: _textFadeAnim,
                child: Text(
                  'رعاية متكاملة لمولودك منذ اللحظة الأولى',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.notoSansArabic(
                    color: const Color(0xFFFFFFFF).withAlpha(204), // #FFFFFFCC
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    height: 28 / 18,
                  ),
                ),
              ),
            ),

            const Spacer(flex: 4),

            // ── Bottom: Loading dots ──────────────────────────
            Padding(
              padding: const EdgeInsets.only(bottom: 64),
              child: FadeTransition(
                opacity: _textFadeAnim,
                child: _LoadingDots(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingDots extends StatefulWidget {
  @override
  State<_LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<_LoadingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (i) {
            final offset = ((_controller.value * 3) - i).clamp(0.0, 1.0);
            final opacity = (1 - (offset - 0.5).abs() * 2).clamp(0.3, 1.0);
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withAlpha((opacity * 255).toInt()),
              ),
            );
          }),
        );
      },
    );
  }
}
