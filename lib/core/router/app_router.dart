import 'package:go_router/go_router.dart';
import 'package:ebirth/features/auth/domain/entities/user_entity.dart';
import 'package:ebirth/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:ebirth/features/auth/presentation/pages/login_page.dart';
import 'package:ebirth/features/auth/presentation/pages/login_role_choice_page.dart';
import 'package:ebirth/features/auth/presentation/pages/pending_approval_page.dart';
import 'package:ebirth/features/auth/presentation/pages/password_reset_success_page.dart';
import 'package:ebirth/features/auth/presentation/pages/register_page.dart';
import 'package:ebirth/features/auth/presentation/pages/reset_password_page.dart';
import 'package:ebirth/features/auth/presentation/pages/role_selection_page.dart';
import 'package:ebirth/features/auth/presentation/pages/verify_otp_page.dart';
import 'package:ebirth/features/home/presentation/pages/home_page.dart';
import 'package:ebirth/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:ebirth/features/splash/presentation/pages/splash_page.dart';
import 'package:ebirth/features/parent/presentation/pages/child_details_page.dart';
import 'package:ebirth/features/parent/domain/entities/child_entity.dart';

class AppRouter {
  AppRouter._();

  static const String splashRoute = '/splash';
  static const String onboardingRoute = '/onboarding';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String homeRoute = '/home';

  static final GoRouter router = GoRouter(
    initialLocation: splashRoute,
    routes: [
      GoRoute(
        path: splashRoute,
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
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
        path: '/role-selection',
        name: 'role-selection',
        builder: (context, state) => const RoleSelectionPage(),
      ),
      GoRoute(
        path: registerRoute,
        name: 'register',
        builder: (context, state) {
          final role = (state.extra as String?) ?? 'Parent';
          return RegisterPage(role: role);
        },
      ),
      GoRoute(
        path: '/pending-approval',
        name: 'pending-approval',
        builder: (context, state) => const PendingApprovalPage(),
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
          final identifier = state.uri.queryParameters['identifier'] ?? '';
          return VerifyOtpPage(emailOrNationalId: identifier);
        },
      ),
      GoRoute(
        path: '/login-role-choice',
        name: 'login-role-choice',
        builder: (context, state) {
          final user = state.extra as UserEntity;
          return LoginRoleChoicePage(user: user);
        },
      ),
      GoRoute(
        path: homeRoute,
        name: 'home',
        builder: (context, state) {
          final user = state.extra as UserEntity?;
          return HomePage(user: user);
        },
      ),
      GoRoute(
        path: '/reset-password',
        name: 'reset-password',
        builder: (context, state) {
          final identifier = state.uri.queryParameters['identifier'] ?? '';
          final otp = state.uri.queryParameters['otp'] ?? '';
          return ResetPasswordPage(emailOrNationalId: identifier, otp: otp);
        },
      ),
      GoRoute(
        path: '/reset-password-success',
        name: 'reset-password-success',
        builder: (context, state) => const PasswordResetSuccessPage(),
      ),
      GoRoute(
        path: '/child-details/:id',
        name: 'child-details',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          final initialChild = state.extra as ChildEntity?;
          return ChildDetailsPage(
            childId: id,
            initialChild: initialChild,
          );
        },
      ),
    ],
  );
}
