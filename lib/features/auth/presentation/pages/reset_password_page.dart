import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ebirth/core/widgets/app_toast.dart';
import 'package:ebirth/core/di/injection_container.dart';
import 'package:ebirth/features/auth/presentation/cubit/reset_password_cubit.dart';
import 'package:ebirth/features/auth/presentation/cubit/reset_password_state.dart';
import 'package:ebirth/core/widgets/auth_layout.dart';
import 'package:ebirth/core/widgets/custom_text_field.dart';
import 'package:ebirth/core/widgets/custom_gradient_button.dart';
import 'package:animate_do/animate_do.dart';
import 'package:ebirth/l10n/app_localizations.dart';

class ResetPasswordPage extends StatelessWidget {
  final String emailOrNationalId;
  final String otp;

  const ResetPasswordPage({
    super.key,
    required this.emailOrNationalId,
    required this.otp,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ResetPasswordCubit>(),
      child: _ResetPasswordView(emailOrNationalId: emailOrNationalId, otp: otp),
    );
  }
}

class _ResetPasswordView extends StatefulWidget {
  final String emailOrNationalId;
  final String otp;

  const _ResetPasswordView({
    required this.emailOrNationalId,
    required this.otp,
  });

  @override
  State<_ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<_ResetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ResetPasswordCubit>().resetPassword(
        emailOrNationalId: widget.emailOrNationalId,
        otp: widget.otp,
        newPassword: _newPasswordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          // Navigate to the visual success screen
          context.pushNamed('reset-password-success');
        } else if (state is ResetPasswordFailure) {
          AppToast.error(context, state.message);
        }
      },
      child: BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
        builder: (context, state) {
          return AuthLayout(
            showLogo: false,
            showBackButton: true,
            headerCrossAxisAlignment: CrossAxisAlignment.start,
            headerTopPadding: 90.0,
            bottomSheetHeight: MediaQuery.of(context).size.height * 0.72,
            title: l10n.resetPasswordTitle,
            subtitle: l10n.resetPasswordSubtitle,
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
                        label: l10n.resetPasswordNewPassword,
                        controller: _newPasswordController,
                        obscureText: _obscureNew,
                        textInputAction: TextInputAction.next,
                        textDirection: TextDirection.ltr,
                        hintText: l10n.resetPasswordNewPasswordHint,
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: Color(0xFF4E8B97),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureNew
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: const Color(0xFF4E8B97).withOpacity(0.7),
                          ),
                          onPressed: () =>
                              setState(() => _obscureNew = !_obscureNew),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return l10n.passwordRequired;
                          }
                          if (value.trim().length < 6) {
                            return l10n.passwordTooShort;
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    FadeInLeft(
                      duration: const Duration(milliseconds: 600),
                      delay: const Duration(milliseconds: 200),
                      child: CustomTextField(
                        label: l10n.resetPasswordConfirmPassword,
                        controller: _confirmPasswordController,
                        obscureText: _obscureConfirm,
                        textInputAction: TextInputAction.done,
                        textDirection: TextDirection.ltr,
                        hintText: l10n.resetPasswordConfirmPasswordHint,
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: Color(0xFF4E8B97),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirm
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: const Color(0xFF4E8B97).withOpacity(0.7),
                          ),
                          onPressed: () =>
                              setState(() => _obscureConfirm = !_obscureConfirm),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return l10n.resetPasswordConfirmRequired;
                          }
                          if (value.trim() !=
                              _newPasswordController.text.trim()) {
                            return l10n.resetPasswordNotMatch;
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) => _onSubmit(),
                      ),
                    ),
                    const SizedBox(height: 32),
                    FadeInUp(
                      duration: const Duration(milliseconds: 600),
                      delay: const Duration(milliseconds: 400),
                      child: CustomGradientButton(
                        text: l10n.resetPasswordButton,
                        isLoading: state is ResetPasswordLoading,
                        onPressed: _onSubmit,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
