import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ebirth/core/constants/app_colors.dart';
import 'package:ebirth/core/widgets/custom_text_field.dart';
import 'package:ebirth/core/widgets/custom_gradient_button.dart';
import 'package:ebirth/features/auth/presentation/cubit/login_cubit.dart';
import 'package:ebirth/features/auth/presentation/cubit/login_state.dart';
import 'package:ebirth/l10n/app_localizations.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LoginCubit>().login(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Form(
      key: _formKey,
      child: AnimationLimiter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 600),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: 50.0,
              child: FadeInAnimation(child: widget),
            ),
            children: [
              // ── Inline Error Banner ───────────────────────────────
              BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  if (state is LoginFailure) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.error.withAlpha(25),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.error.withAlpha(80)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: AppColors.error,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              state.message,
                              style: TextStyle(
                                color: AppColors.error,
                                fontSize: 13,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),

              // ── Form Titles ─────────────────────────────────────────
              const Text(
                'تسجيل الدخول',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  height: 32 / 24,
                  color: Color(0xFF1E2939),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'أهلاً بعودتك، سجل دخولك للمتابعة',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 20 / 14,
                  color: Color(0xFF4A5565),
                ),
              ),
              const SizedBox(height: 24),

              // ── Email / National ID Field ─────────────────────────
              CustomTextField(
                label: 'البريد الإلكتروني أو الرقم القومي',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                textDirection: TextDirection.ltr,
                hintText: 'أدخل البريد الإلكتروني أو الرقم القومي',
                prefixIcon: const Icon(
                  Icons.person_outline,
                  color: Color(0xFF4E8B97),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'الرجاء إدخال البريد الإلكتروني أو الرقم القومي';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // ── Password Field ────────────────────────────────────
              CustomTextField(
                label: 'كلمة المرور',
                controller: _passwordController,
                obscureText: _obscurePassword,
                textInputAction: TextInputAction.done,
                textDirection: TextDirection.ltr,
                onFieldSubmitted: (_) => _onSubmit(),
                hintText: l10n.passwordHint,
                prefixIcon: const Icon(
                  Icons.lock_outlined,
                  color: Color(0xFF4E8B97),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: const Color(0xFF4E8B97).withOpacity(0.7),
                  ),
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.passwordRequired;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              // ── Submit Button (Gradient) ─────────────────────────
              BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  return CustomGradientButton(
                    text: 'تسجيل الدخول',
                    isLoading: state is LoginLoading,
                    onPressed: _onSubmit,
                  );
                },
              ),

              const SizedBox(height: 16),

              // ── Links (Create Account / Forgot Password) ────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Create Account (Left / First in Row)
                  TextButton(
                    onPressed: () => context.pushNamed('role-selection'),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(50, 30),
                      alignment: Alignment.centerLeft,
                    ),
                    child: const Text(
                      'إنشاء حساب جديد',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        height: 24 / 16,
                        color: Color(0xFF00A63E), // Green
                      ),
                    ),
                  ),

                  // Forgot Password (Right / Second in Row)
                  TextButton(
                    onPressed: () => context.pushNamed('forgot-password'),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(50, 30),
                      alignment: Alignment.centerRight,
                    ),
                    child: const Text(
                      'نسيت كلمة المرور؟',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        height: 24 / 16,
                        color: Color(0xFF155DFC), // Blue
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
