import 'package:ebirth/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebirth/core/constants/app_colors.dart';
import 'package:ebirth/features/auth/presentation/cubit/register_cubit.dart';
import 'package:ebirth/features/auth/presentation/cubit/register_state.dart';


class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _nationalIdController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _nationalIdController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<RegisterCubit>().register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        nationalId: _nationalIdController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Name Field
          TextFormField(
            controller: _nameController,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: l10n.name,
              prefixIcon: const Icon(
                Icons.person_outline,
                color: AppColors.primary,
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return l10n.nameRequired;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Email Field
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: l10n.email,
              hintText: l10n.emailHint,
              prefixIcon: const Icon(
                Icons.email_outlined,
                color: AppColors.primary,
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return l10n.emailRequired;
              }
              final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
              if (!emailRegex.hasMatch(value.trim())) {
                return l10n.emailInvalid;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // National ID Field
          TextFormField(
            controller: _nationalIdController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(14),
            ],
            decoration: InputDecoration(
              labelText: l10n.nationalId,
              prefixIcon: const Icon(
                Icons.badge_outlined,
                color: AppColors.primary,
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return l10n.nationalIdRequired;
              }
              if (value.length != 14) {
                return l10n.nationalIdInvalid;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Phone Field
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: l10n.phoneNumber,
              prefixIcon: const Icon(
                Icons.phone_outlined,
                color: AppColors.primary,
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return l10n.phoneRequired;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Password Field
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: l10n.password,
              prefixIcon: const Icon(
                Icons.lock_outlined,
                color: AppColors.primary,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.textSecondary,
                ),
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return l10n.passwordRequired;
              }
              if (value.length < 6) {
                return l10n.passwordTooShort;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Confirm Password Field
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: _obscureConfirmPassword,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _onSubmit(),
            decoration: InputDecoration(
              labelText: l10n.confirmPassword,
              prefixIcon: const Icon(
                Icons.lock_clock_outlined,
                color: AppColors.primary,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirmPassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.textSecondary,
                ),
                onPressed: () => setState(
                  () => _obscureConfirmPassword = !_obscureConfirmPassword,
                ),
              ),
            ),
            validator: (value) {
              if (value != _passwordController.text) {
                return l10n.passwordsNotMatch;
              }
              return null;
            },
          ),
          const SizedBox(height: 28),

          // Submit Button
          BlocBuilder<RegisterCubit, RegisterState>(
            builder: (context, state) {
              final isLoading = state is RegisterLoading;
              return ElevatedButton(
                onPressed: isLoading ? null : _onSubmit,
                child: isLoading
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                    : Text(l10n.register),
              );
            },
          ),
        ],
      ),
    );
  }
}

