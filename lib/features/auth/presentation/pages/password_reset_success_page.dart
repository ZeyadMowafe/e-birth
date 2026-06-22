import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:ebirth/l10n/app_localizations.dart';

class PasswordResetSuccessPage extends StatefulWidget {
  const PasswordResetSuccessPage({super.key});

  @override
  State<PasswordResetSuccessPage> createState() =>
      _PasswordResetSuccessPageState();
}

class _PasswordResetSuccessPageState extends State<PasswordResetSuccessPage> {
  @override
  void initState() {
    super.initState();
    // Redirect to login after 3 seconds
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        context.goNamed('login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: Container(
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // White Circle with Success Icon
              BounceInDown(
                duration: const Duration(milliseconds: 1200),
                child: Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
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
                      'assets/icons/Icon_success.png',
                      width: 48,
                      height: 48,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Success Title
              FadeIn(
                duration: const Duration(milliseconds: 800),
                delay: const Duration(milliseconds: 400),
                  child: SizedBox(
                    width: 294,
                    child: Text(
                      l10n.passwordResetSuccess,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Arial', // User requested Arial
                      fontWeight: FontWeight.w700,
                      fontSize: 32,
                      height: 1.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Redirect Subtitle
              FadeIn(
                duration: const Duration(milliseconds: 800),
                delay: const Duration(milliseconds: 600),
                child: SizedBox(
                  width: 252,
                  child: Text(
                    l10n.passwordResetRedirect,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      height: 1.2,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
