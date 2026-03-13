import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:ebirth/features/auth/presentation/cubit/forgot_password_cubit.dart';
import 'package:ebirth/features/auth/presentation/cubit/forgot_password_state.dart';
import 'package:ebirth/core/constants/app_colors.dart';
import 'package:ebirth/core/di/injection_container.dart';
import 'package:ebirth/features/auth/presentation/cubit/verify_otp_cubit.dart';
import 'package:ebirth/features/auth/presentation/cubit/verify_otp_state.dart';
import 'package:ebirth/l10n/app_localizations.dart';
import 'package:ebirth/core/widgets/auth_layout.dart';
import 'package:ebirth/core/widgets/custom_gradient_button.dart';

class VerifyOtpPage extends StatelessWidget {
  final String emailOrNationalId;

  const VerifyOtpPage({super.key, required this.emailOrNationalId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<VerifyOtpCubit>()),
        BlocProvider(create: (_) => sl<ForgotPasswordCubit>()),
      ],
      child: _VerifyOtpView(emailOrNationalId: emailOrNationalId),
    );
  }
}

class _VerifyOtpView extends StatefulWidget {
  final String emailOrNationalId;

  const _VerifyOtpView({required this.emailOrNationalId});

  @override
  State<_VerifyOtpView> createState() => _VerifyOtpViewState();
}

class _VerifyOtpViewState extends State<_VerifyOtpView> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  int _secondsRemaining = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _secondsRemaining = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
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
    if (otp.length == 6) {
      context.read<VerifyOtpCubit>().verifyOtp(
        emailOrNationalId: widget.emailOrNationalId,
        otp: otp,
      );
    }
  }

  void _onResend() {
    if (_secondsRemaining == 0) {
      context.read<ForgotPasswordCubit>().forgotPassword(
        emailOrNationalId: widget.emailOrNationalId,
      );
      _startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return MultiBlocListener(
      listeners: [
        BlocListener<VerifyOtpCubit, VerifyOtpState>(
          listener: (context, state) {
            if (state is VerifyOtpSuccess) {
              context.pushNamed(
                'reset-password',
                queryParameters: {
                  'identifier': widget.emailOrNationalId,
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
        ),
        BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
          listener: (context, state) {
            if (state is ForgotPasswordSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(l10n.resetLinkSent),
                  backgroundColor: AppColors.success,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            } else if (state is ForgotPasswordFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.error,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
        ),
      ],
      child: BlocBuilder<VerifyOtpCubit, VerifyOtpState>(
        builder: (context, state) {
          return AuthLayout(
            showLogo: false,
            showBackButton: true,
            headerCrossAxisAlignment: CrossAxisAlignment.start,
            headerTopPadding: 80.0,
            bottomSheetHeight: MediaQuery.of(context).size.height * 0.72,
            title: l10n.otpTitle,
            titleStyle: const TextStyle(
              fontFamily: 'Arial',
              fontWeight: FontWeight.w700,
              fontSize: 40,
              height: 40 / 40,
              color: Colors.white,
            ),
            subtitle: '${l10n.otpSubtitle} ${widget.emailOrNationalId}',
            subtitleStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              height: 24 / 16,
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24),

                  // OTP Input Fields
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        6,
                        (index) => SizedBox(
                          width: 48,
                          height: 56,
                          child: TextFormField(
                            controller: _controllers[index],
                            focusNode: _focusNodes[index],
                            textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.center,
                            expands: true,
                            maxLines: null,
                            minLines: null,
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
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide(
                                  color: const Color(
                                    0xFF4E8B97,
                                  ).withOpacity(0.2),
                                  width: 1.33,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                  color: Color(0xFF4E8B97),
                                  width: 1.33,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty && index < 5) {
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
                  ),

                  const SizedBox(height: 32),

                  // Resend Code Section
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        l10n.didNotReceiveCode,
                        style: GoogleFonts.arimo(
                          color: const Color(0xFF4A5565),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 20 / 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: _secondsRemaining > 0 ? null : _onResend,
                        child: Text(
                          _secondsRemaining > 0
                              ? 'إعادة الإرسال خلال $_secondsRemaining ثانية'
                              : l10n.resendCode,
                          style: GoogleFonts.arimo(
                            color: _secondsRemaining > 0
                                ? AppColors.textSecondary
                                : const Color(0xFF1DA8C4),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            height: 20 / 14,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  CustomGradientButton(
                    text: l10n.verify,
                    isLoading: state is VerifyOtpLoading,
                    onPressed: _onVerify,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
