import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:ebirth/core/helper/shared_prefs_helper.dart';
import 'package:ebirth/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:ebirth/features/auth/presentation/pages/login_page.dart';
import 'package:ebirth/features/auth/presentation/pages/register_page.dart';
import 'package:ebirth/features/auth/presentation/pages/reset_password_page.dart';
import 'package:ebirth/features/auth/presentation/pages/verify_otp_page.dart';
import 'package:ebirth/features/home/presentation/pages/home_page.dart';
import 'package:ebirth/features/onboarding/presentation/pages/onboarding_page.dart';

class AppRouter {
  AppRouter._();

  static const String onboardingRoute = '/onboarding';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String homeRoute = '/home';

  static final GoRouter router = GoRouter(
    initialLocation: onboardingRoute,
    redirect: (context, state) async {
      // If already navigating somewhere other than onboarding, let it pass
      if (state.matchedLocation != onboardingRoute) return null;
      // In debug mode: always show onboarding (ignore saved flag)
      if (kDebugMode) return null;
      // In release mode: skip onboarding if already seen
      final seen = await SharedPrefsHelper.isOnboardingSeen();
      if (seen) return loginRoute;
      return null;
    },
    routes: [
      GoRoute(
        path: onboardingRoute,
        name: 'onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: loginRoute,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: registerRoute,
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/forgot-password',
        name: 'forgot-password',
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: '/verify-otp',
        name: 'verify-otp',
        builder: (context, state) {
          final email = state.uri.queryParameters['email'] ?? '';
          return VerifyOtpPage(email: email);
        },
      ),
      GoRoute(
        path: homeRoute,
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/reset-password',
        name: 'reset-password',
        builder: (context, state) {
          final email = state.uri.queryParameters['email'] ?? '';
          final otp = state.uri.queryParameters['otp'] ?? '';
          return ResetPasswordPage(email: email, otp: otp);
        },
      ),
    ],
  );
}
