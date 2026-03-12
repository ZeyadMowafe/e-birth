import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ebirth/core/widgets/tap_unfocus.dart';

class AuthLayout extends StatelessWidget {
  final Widget child;
  final String title;
  final String subtitle;
  final bool showLogo;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final CrossAxisAlignment headerCrossAxisAlignment;
  final double? bottomSheetHeight;
  final EdgeInsetsGeometry bottomSheetPadding;

  const AuthLayout({
    super.key,
    required this.child,
    this.title = 'نظام المواليد الإلكتروني',
    this.subtitle = 'E-Birth System',
    this.showLogo = true,
    this.titleStyle,
    this.subtitleStyle,
    this.headerCrossAxisAlignment = CrossAxisAlignment.center,
    this.bottomSheetHeight,
    this.bottomSheetPadding = const EdgeInsets.only(
      top: 20,
      left: 24,
      right: 24,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return TapUnfocus(
      child: Scaffold(
        body: Stack(
          children: [
            // ── Background Gradient ────────────────────────────────
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFB8ECC8), Color(0xFF1DA8C4)],
                  stops: [0.0, 0.4],
                ),
              ),
            ),

            // ── Header Content ───────────────────────────────────────
            SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 40, left: 24, right: 24),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: headerCrossAxisAlignment,
                      children: [
                        if (showLogo) ...[
                          // White Box (Logo area)
                          Container(
                            width: 96,
                            height: 96,
                            padding: const EdgeInsets.only(left: 0.02),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x1A000000), // #0000001A
                                  blurRadius: 6,
                                  offset: Offset(0, 4),
                                  spreadRadius: -4,
                                ),
                                BoxShadow(
                                  color: Color(0x1A000000), // #0000001A
                                  blurRadius: 15,
                                  offset: Offset(0, 10),
                                  spreadRadius: -3,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/images/splash_logo.png',
                                width: 60,
                                height: 60,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],

                        // Arabic Title
                        Text(
                          title,
                          textAlign:
                              headerCrossAxisAlignment ==
                                  CrossAxisAlignment.center
                              ? TextAlign.center
                              : TextAlign.start,
                          style:
                              titleStyle ??
                              const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                height: 36 / 36,
                                color: Colors.white,
                              ),
                        ),
                        const SizedBox(height: 26),

                        // English Subtitle
                        Text(
                          subtitle,
                          textAlign:
                              headerCrossAxisAlignment ==
                                  CrossAxisAlignment.center
                              ? TextAlign.center
                              : TextAlign.start,
                          style:
                              subtitleStyle ??
                              GoogleFonts.audiowide(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                height: 20 / 18,
                                color: Colors.white,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // ── Bottom Sheet Container (2/3 of screen) ─────────────
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height:
                    bottomSheetHeight ??
                    MediaQuery.of(context).size.height * 0.66,
                padding: bottomSheetPadding,
                decoration: const BoxDecoration(
                  color: Color(0xFFF6F8F8), // background: #F6F8F8;
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
