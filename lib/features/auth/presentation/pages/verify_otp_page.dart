import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ebirth/core/constants/app_colors.dart';
import 'package:ebirth/core/widgets/tap_unfocus.dart';
import 'package:ebirth/core/di/injection_container.dart';
import 'package:ebirth/features/auth/presentation/cubit/verify_otp_cubit.dart';
import 'package:ebirth/features/auth/presentation/cubit/verify_otp_state.dart';
import 'package:ebirth/l10n/app_localizations.dart';

class VerifyOtpPage extends StatelessWidget {
  final String email;

  const VerifyOtpPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<VerifyOtpCubit>(),
      child: _VerifyOtpView(email: email),
    );
  }
}

class _VerifyOtpView extends StatefulWidget {
  final String email;

  const _VerifyOtpView({required this.email});

  @override
  State<_VerifyOtpView> createState() => _VerifyOtpViewState();
}

class _VerifyOtpViewState extends State<_VerifyOtpView> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onVerify() {
    String otp = _controllers.map((c) => c.text).join();
    if (otp.length == 4) {
      context.read<VerifyOtpCubit>().verifyOtp(email: widget.email, otp: otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocConsumer<VerifyOtpCubit, VerifyOtpState>(
      listener: (context, state) {
        if (state is VerifyOtpSuccess) {
          context.pushNamed(
            'reset-password',
            queryParameters: {
              'email': widget.email,
              'otp': _controllers.map((c) => c.text).join(),
            },
          );
        } else if (state is VerifyOtpFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        return TapUnfocus(
          child: Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.textPrimary,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      l10n.otpTitle,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        children: [
                          TextSpan(text: l10n.otpSubtitle),
                          TextSpan(
                            text: widget.email,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 48),

                    // OTP Input Fields
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        4,
                        (index) => SizedBox(
                          width: 60,
                          height: 60,
                          child: TextFormField(
                            controller: _controllers[index],
                            focusNode: _focusNodes[index],
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: AppColors.primary.withAlpha(51),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: AppColors.primary,
                                  width: 2,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty && index < 3) {
                                _focusNodes[index + 1].requestFocus();
                              } else if (value.isEmpty && index > 0) {
                                _focusNodes[index - 1].requestFocus();
                              }
                              if (_controllers.every(
                                (c) => c.text.isNotEmpty,
                              )) {
                                _onVerify();
                              }
                            },
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 48),

                    ElevatedButton(
                      onPressed: state is VerifyOtpLoading ? null : _onVerify,
                      child: state is VerifyOtpLoading
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(l10n.verify),
                    ),

                    const SizedBox(height: 24),

                    TextButton(
                      onPressed: () {
                        // TODO: Implement resend logic
                      },
                      child: Text(
                        l10n.resendOtp,
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
