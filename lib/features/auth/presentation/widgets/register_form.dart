import 'package:ebirth/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebirth/core/constants/app_colors.dart';
import 'package:ebirth/core/widgets/custom_gradient_button.dart';
import 'package:ebirth/core/widgets/custom_text_field.dart';
import 'package:ebirth/features/auth/presentation/cubit/register_cubit.dart';
import 'package:ebirth/features/auth/presentation/cubit/register_state.dart';

// ─── Egyptian Governorates ─────────────────────────────────────────────────
const _governorates = [
  'القاهرة',
  'الإسكندرية',
  'الجيزة',
  'القليوبية',
  'الشرقية',
  'المنوفية',
  'الغربية',
  'كفر الشيخ',
  'البحيرة',
  'الدقهلية',
  'دمياط',
  'بورسعيد',
  'الإسماعيلية',
  'السويس',
  'شمال سيناء',
  'جنوب سيناء',
  'الفيوم',
  'بني سويف',
  'المنيا',
  'أسيوط',
  'سوهاج',
  'قنا',
  'الأقصر',
  'أسوان',
  'البحر الأحمر',
  'الوادي الجديد',
  'مطروح',
];

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
  final _villageController = TextEditingController();
  final _cityController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  DateTime? _birthDate;
  int _gender = 1; // 1=Male, 2=Female
  int _governorate = 1;
  int _bloodType = 1;

  static const _bloodTypes = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _nationalIdController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _villageController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  Future<void> _pickBirthDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1995, 1, 1),
      firstDate: DateTime(1940),
      lastDate: DateTime.now().subtract(const Duration(days: 365 * 10)),
      locale: const Locale('ar'),
    );
    if (picked != null) setState(() => _birthDate = picked);
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_birthDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('الرجاء تحديد تاريخ الميلاد'),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(16),
          ),
        );
        return;
      }
      final birthDateStr =
          '${_birthDate!.year}-${_birthDate!.month.toString().padLeft(2, '0')}-${_birthDate!.day.toString().padLeft(2, '0')}';

      context.read<RegisterCubit>().register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        nationalId: _nationalIdController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        birthDate: birthDateStr,
        village: _villageController.text.trim(),
        city: _cityController.text.trim(),
        gender: _gender,
        governorate: _governorate,
        bloodType: _bloodType,
      );
    }
  }

  // Widget _buildSectionTitle(String title) {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 16, bottom: 8),
  //     child: Text(
  //       title,
  //       style: const TextStyle(
  //         fontSize: 13,
  //         fontWeight: FontWeight.w600,
  //         color: AppColors.primary,
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Inline Error Banner ────────────────────────────────
          BlocBuilder<RegisterCubit, RegisterState>(
            builder: (context, state) {
              if (state is RegisterFailure) {
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

          // ── Section: Personal Info ─────────────────────────────
          CustomTextField(
            label: l10n.name,
            controller: _nameController,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            textAlign: TextAlign.right,
            hintText: l10n.name,
            prefixIcon: const Icon(
              Icons.person_outline,
              color: Color(0xFF4E8B97),
            ),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? l10n.nameRequired : null,
          ),
          const SizedBox(height: 12),

          CustomTextField(
            label: l10n.nationalId,
            controller: _nationalIdController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            textDirection: TextDirection.ltr,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(14),
            ],
            hintText: l10n.nationalId,
            prefixIcon: const Icon(
              Icons.badge_outlined,
              color: Color(0xFF4E8B97),
            ),
            validator: (v) {
              if (v == null || v.isEmpty) return l10n.nationalIdRequired;
              if (v.length != 14) return l10n.nationalIdInvalid;
              return null;
            },
          ),
          const SizedBox(height: 12),

          GestureDetector(
            onTap: _pickBirthDate,
            child: AbsorbPointer(
              child: CustomTextField(
                label: 'تاريخ الميلاد',
                controller: TextEditingController(
                  text: _birthDate == null
                      ? ''
                      : '${_birthDate!.year}/${_birthDate!.month}/${_birthDate!.day}',
                ),
                hintText: _birthDate == null
                    ? 'اختر تاريخ الميلاد'
                    : '${_birthDate!.year}/${_birthDate!.month}/${_birthDate!.day}',
                prefixIcon: const Icon(
                  Icons.calendar_today_outlined,
                  color: Color(0xFF4E8B97),
                ),
                suffixIcon: const Icon(
                  Icons.arrow_drop_down,
                  color: Color(0xFF4E8B97),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Gender
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'النوع',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  height: 20 / 14,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<int>(
                value: _gender,
                decoration: const InputDecoration(
                  hintText: 'النوع',
                  prefixIcon: Icon(Icons.wc_outlined, color: Color(0xFF4E8B97)),
                ),
                items: const [
                  DropdownMenuItem(value: 1, child: Text('ذكر')),
                  DropdownMenuItem(value: 2, child: Text('أنثى')),
                ],
                onChanged: (v) => setState(() => _gender = v!),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Blood Type
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'فصيلة الدم',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  height: 20 / 14,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<int>(
                value: _bloodType,
                decoration: const InputDecoration(
                  hintText: 'فصيلة الدم',
                  prefixIcon: Icon(
                    Icons.bloodtype_outlined,
                    color: Color(0xFF4E8B97),
                  ),
                ),
                items: List.generate(
                  _bloodTypes.length,
                  (i) => DropdownMenuItem(
                    value: i + 1,
                    child: Text(_bloodTypes[i]),
                  ),
                ),
                onChanged: (v) => setState(() => _bloodType = v!),
              ),
            ],
          ),

          // ── Section: Location ──────────────────────────────────
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'المحافظة',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  height: 20 / 14,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<int>(
                value: _governorate,
                decoration: const InputDecoration(
                  hintText: 'المحافظة',
                  prefixIcon: Icon(
                    Icons.location_city_outlined,
                    color: Color(0xFF4E8B97),
                  ),
                ),
                items: List.generate(
                  _governorates.length,
                  (i) => DropdownMenuItem(
                    value: i + 1,
                    child: Text(_governorates[i]),
                  ),
                ),
                onChanged: (v) => setState(() => _governorate = v!),
              ),
            ],
          ),
          const SizedBox(height: 12),

          CustomTextField(
            label: 'المدينة / المركز',
            controller: _cityController,
            textInputAction: TextInputAction.next,
            textAlign: TextAlign.right,
            hintText: 'المدينة / المركز',
            prefixIcon: const Icon(
              Icons.map_outlined,
              color: Color(0xFF4E8B97),
            ),
          ),
          const SizedBox(height: 12),

          CustomTextField(
            label: 'القرية / الحي',
            controller: _villageController,
            textInputAction: TextInputAction.next,
            textAlign: TextAlign.right,
            hintText: 'القرية / الحي',
            prefixIcon: const Icon(
              Icons.home_outlined,
              color: Color(0xFF4E8B97),
            ),
          ),

          // ── Section: Contact ───────────────────────────────────
          CustomTextField(
            label: l10n.email,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            textDirection: TextDirection.ltr,
            hintText: l10n.emailHint,
            prefixIcon: const Icon(
              Icons.email_outlined,
              color: Color(0xFF4E8B97),
            ),
            validator: (v) {
              if (v == null || v.trim().isEmpty) return l10n.emailRequired;
              final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
              if (!emailRegex.hasMatch(v.trim())) return l10n.emailInvalid;
              return null;
            },
          ),
          const SizedBox(height: 12),

          CustomTextField(
            label: l10n.phoneNumber,
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            textDirection: TextDirection.ltr,
            hintText: l10n.phoneNumber,
            prefixIcon: const Icon(
              Icons.phone_outlined,
              color: Color(0xFF4E8B97),
            ),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? l10n.phoneRequired : null,
          ),

          // ── Section: Security ──────────────────────────────────
          CustomTextField(
            label: l10n.password,
            controller: _passwordController,
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.next,
            textDirection: TextDirection.ltr,
            hintText: l10n.password,
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
            validator: (v) {
              if (v == null || v.isEmpty) return l10n.passwordRequired;
              if (v.length < 6) return l10n.passwordTooShort;
              return null;
            },
          ),
          const SizedBox(height: 12),

          CustomTextField(
            label: l10n.confirmPassword,
            controller: _confirmPasswordController,
            obscureText: _obscureConfirmPassword,
            textInputAction: TextInputAction.done,
            textDirection: TextDirection.ltr,
            onFieldSubmitted: (_) => _onSubmit(),
            hintText: l10n.confirmPassword,
            prefixIcon: const Icon(
              Icons.lock_clock_outlined,
              color: Color(0xFF4E8B97),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirmPassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: const Color(0xFF4E8B97).withOpacity(0.7),
              ),
              onPressed: () => setState(
                () => _obscureConfirmPassword = !_obscureConfirmPassword,
              ),
            ),
            validator: (v) =>
                v != _passwordController.text ? l10n.passwordsNotMatch : null,
          ),
          const SizedBox(height: 28),

          // ── Submit Button ──────────────────────────────────────
          BlocBuilder<RegisterCubit, RegisterState>(
            builder: (context, state) {
              final isLoading = state is RegisterLoading;
              return CustomGradientButton(
                text: l10n.register,
                isLoading: isLoading,
                onPressed: _onSubmit,
              );
            },
          ),
        ],
      ),
    );
  }
}
