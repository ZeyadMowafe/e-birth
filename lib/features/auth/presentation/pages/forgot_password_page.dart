import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ebirth/core/widgets/app_toast.dart';
import 'package:ebirth/core/di/injection_container.dart';
import 'package:ebirth/features/auth/presentation/cubit/forgot_password_cubit.dart';
import 'package:ebirth/features/auth/presentation/cubit/forgot_password_state.dart';
import 'package:ebirth/l10n/app_localizations.dart';
import 'package:ebirth/core/widgets/auth_layout.dart';
import 'package:ebirth/core/widgets/custom_text_field.dart';
import 'package:ebirth/core/widgets/custom_gradient_button.dart';
import 'package:animate_do/animate_do.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ForgotPasswordCubit>(),
      child: const _ForgotPasswordView(),
    );
  }
}

class _ForgotPasswordView extends StatefulWidget {
  const _ForgotPasswordView();

  @override
  State<_ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<_ForgotPasswordView> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onSendLink() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ForgotPasswordCubit>().forgotPassword(
        emailOrNationalId: _emailController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordSuccess) {
          AppToast.success(context, l10n.resetLinkSent);
          context.pushNamed(
            'verify-otp',
            queryParameters: {'identifier': _emailController.text.trim()},
          );
        } else if (state is ForgotPasswordFailure) {
          AppToast.error(context, state.message);
        }
      },
      builder: (context, state) {
        return AuthLayout(
          showLogo: false,
          showBackButton: true,
          headerCrossAxisAlignment: CrossAxisAlignment.start,
          headerTopPadding: 90.0,
          bottomSheetHeight: MediaQuery.of(context).size.height * 0.72,
          title: l10n.forgotPasswordTitle,
          titleStyle: const TextStyle(
            fontFamily: 'Arial',
            fontWeight: FontWeight.w700,
            fontSize: 40,
            height: 40 / 40,
            color: Colors.white,
          ),
          subtitle: l10n.forgotPasswordSubtitle,
          subtitleStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            height: 24 / 16,
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24),
                  FadeInLeft(
                    duration: const Duration(milliseconds: 600),
                    child: CustomTextField(
                      label: l10n.forgotPasswordEmailLabel,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      textDirection: TextDirection.ltr,
                      hintText: l10n.forgotPasswordEmailHint,
                      prefixIcon: const Icon(
                        Icons.person_outline,
                        color: Color(0xFF4E8B97),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return l10n.forgotPasswordRequired;
                        }
                        final val = value.trim();
                        final emailRegex = RegExp(
                          r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
                        );
                        final idRegex = RegExp(r'^\d{14}$');

                        if (!emailRegex.hasMatch(val)) {
                          return l10n.forgotPasswordValidEmail;
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) => _onSendLink(),
                    ),
                  ),
                  const SizedBox(height: 32),
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 300),
                    child: CustomGradientButton(
                      text: l10n.sendResetLink,
                      isLoading: state is ForgotPasswordLoading,
                      onPressed: _onSendLink,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
