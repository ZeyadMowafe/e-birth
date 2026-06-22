import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ebirth/core/constants/app_colors.dart';
import 'package:ebirth/core/widgets/app_toast.dart';
import 'package:ebirth/core/di/injection_container.dart';
import 'package:ebirth/features/auth/presentation/cubit/login_cubit.dart';
import 'package:ebirth/features/auth/presentation/cubit/login_state.dart';
import 'package:ebirth/core/widgets/auth_layout.dart';
import 'package:ebirth/core/widgets/tap_unfocus.dart';
import 'package:ebirth/features/auth/presentation/widgets/login_form.dart';
import 'package:ebirth/l10n/app_localizations.dart';
import 'package:animate_do/animate_do.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (_) => sl<LoginCubit>(),
      child: _LoginView(l10n: l10n),
    );
  }
}

class _LoginView extends StatelessWidget {
  final AppLocalizations l10n;
  const _LoginView({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          debugPrint('User Role (Login): ${state.user.role}');
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          if (state.user.role.toLowerCase().contains('doctor')) {
            context.goNamed('login-role-choice', extra: state.user);
          } else {
            context.goNamed('home', extra: state.user);
          }
        } else if (state is LoginFailure) {
          AppToast.error(context, state.message);
        }
      },
      child: TapUnfocus(
        child: AuthLayout(
          title: l10n.ebirth,
          subtitle: 'E-Birth System',
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                const LoginForm(), // The updated form

                const SizedBox(height: 48), // Space before the register link
                // ── Footer Register Link ──────────────────────────
                FadeIn(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 400),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        l10n.dontHaveAccount,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                      TextButton(
                        onPressed: () => context.pushNamed('role-selection'),
                        child: Text(
                          l10n.signUpNow,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
