import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ebirth/core/constants/app_colors.dart';
import 'package:ebirth/core/widgets/app_toast.dart';
import 'package:ebirth/core/di/injection_container.dart';
import 'package:ebirth/features/auth/presentation/cubit/register_cubit.dart';
import 'package:ebirth/features/auth/presentation/cubit/register_state.dart';
import 'package:ebirth/core/widgets/auth_layout.dart';
import 'package:ebirth/features/auth/presentation/widgets/doctor_register_form.dart';
import 'package:ebirth/features/auth/presentation/widgets/register_form.dart';
import 'package:ebirth/l10n/app_localizations.dart';

class RegisterPage extends StatelessWidget {
  final String role; // 'Parent' or 'Doctor'
  const RegisterPage({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RegisterCubit>(),
      child: _RegisterView(role: role),
    );
  }
}

class _RegisterView extends StatelessWidget {
  final String role;
  const _RegisterView({required this.role});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDoctor = role == 'Doctor';

    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          debugPrint('User Role (Register): ${state.user.role}');
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          if (isDoctor) {
            // Doctor → show pending approval
            context.goNamed('pending-approval');
          } else {
            // Parent → show success and go to login
            AppToast.success(context, l10n.accountCreated(state.user.name));
            context.goNamed('login');
          }
        }
      },
      child: AuthLayout(
        showLogo: false,
        showBackButton: true,
        headerCrossAxisAlignment: CrossAxisAlignment.start,
        headerTopPadding: 90.0, // Same to fit the title appropriately
        bottomSheetHeight: MediaQuery.of(context).size.height * 0.72,
        title: l10n.registerNewAccount,
        titleStyle: const TextStyle(
          fontFamily: 'Arial',
          fontWeight: FontWeight.w700, // Bold
          fontSize: 40,
          height: 40 / 40,
          color: Colors.white,
        ),
        subtitle: l10n.registerJoinNow,
        subtitleStyle: const TextStyle(
          fontWeight: FontWeight.w600, // SemiBold
          fontSize: 16,
          height: 24 / 16,
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Form View (Reusing the white container appearance if needed, or rendering direct)
              // The form is directly inside the child. AuthLayout provides the white background.
              isDoctor ? const DoctorRegisterForm() : const RegisterForm(),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(l10n.alreadyHaveAccount),
                  TextButton(
                    onPressed: () => context.goNamed('login'),
                    child: Text(
                      l10n.signInNow,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
