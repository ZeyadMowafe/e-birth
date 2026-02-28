import 'dart:io';
import 'package:ebirth/l10n/app_localizations.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebirth/core/constants/app_colors.dart';
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

class DoctorRegisterForm extends StatefulWidget {
  const DoctorRegisterForm({super.key});

  @override
  State<DoctorRegisterForm> createState() => _DoctorRegisterFormState();
}

class _DoctorRegisterFormState extends State<DoctorRegisterForm> {
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
  int _gender = 1;
  int _governorate = 1;
  int _bloodType = 1;
  File? _attachmentFile;
  String? _attachmentName;

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
      initialDate: DateTime(1985, 1, 1),
      firstDate: DateTime(1940),
      lastDate: DateTime.now().subtract(const Duration(days: 365 * 22)),
      locale: const Locale('ar'),
    );
    if (picked != null) setState(() => _birthDate = picked);
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        _attachmentFile = File(result.files.single.path!);
        _attachmentName = result.files.single.name;
      });
    }
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
      if (_attachmentFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('الرجاء رفع مستند إثبات التخصص الطبي'),
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

      context.read<RegisterCubit>().registerDoctor(
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
        attachmentFile: _attachmentFile!,
      );
    }
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Color(0xFF00897B),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Doctor badge ───────────────────────────────────────
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF00897B).withAlpha(20),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF00897B).withAlpha(60)),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.medical_services_outlined,
                  color: Color(0xFF00897B),
                  size: 18,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'سيتم مراجعة بياناتك والمستندات خلال 72 ساعة',
                    style: const TextStyle(
                      color: Color(0xFF00897B),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

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

          // ── Section: Personal ──────────────────────────────────
          _buildSectionTitle('البيانات الشخصية'),
          TextFormField(
            controller: _nameController,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: l10n.name,
              prefixIcon: const Icon(
                Icons.person_outline,
                color: Color(0xFF00897B),
              ),
            ),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? l10n.nameRequired : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _nationalIdController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            textDirection: TextDirection.ltr,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(14),
            ],
            decoration: InputDecoration(
              labelText: l10n.nationalId,
              prefixIcon: const Icon(
                Icons.badge_outlined,
                color: Color(0xFF00897B),
              ),
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
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'تاريخ الميلاد',
                  hintText: _birthDate == null
                      ? 'اختر تاريخ الميلاد'
                      : '${_birthDate!.year}/${_birthDate!.month}/${_birthDate!.day}',
                  prefixIcon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Color(0xFF00897B),
                  ),
                  suffixIcon: const Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.textSecondary,
                  ),
                ),
                controller: TextEditingController(
                  text: _birthDate == null
                      ? ''
                      : '${_birthDate!.year}/${_birthDate!.month}/${_birthDate!.day}',
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<int>(
            value: _gender,
            decoration: const InputDecoration(
              labelText: 'النوع',
              prefixIcon: Icon(Icons.wc_outlined, color: Color(0xFF00897B)),
            ),
            items: const [
              DropdownMenuItem(value: 1, child: Text('ذكر')),
              DropdownMenuItem(value: 2, child: Text('أنثى')),
            ],
            onChanged: (v) => setState(() => _gender = v!),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<int>(
            value: _bloodType,
            decoration: const InputDecoration(
              labelText: 'فصيلة الدم',
              prefixIcon: Icon(
                Icons.bloodtype_outlined,
                color: Color(0xFF00897B),
              ),
            ),
            items: List.generate(
              _bloodTypes.length,
              (i) =>
                  DropdownMenuItem(value: i + 1, child: Text(_bloodTypes[i])),
            ),
            onChanged: (v) => setState(() => _bloodType = v!),
          ),

          // ── Section: Location ──────────────────────────────────
          _buildSectionTitle('العنوان'),
          DropdownButtonFormField<int>(
            value: _governorate,
            decoration: const InputDecoration(
              labelText: 'المحافظة',
              prefixIcon: Icon(
                Icons.location_city_outlined,
                color: Color(0xFF00897B),
              ),
            ),
            items: List.generate(
              _governorates.length,
              (i) =>
                  DropdownMenuItem(value: i + 1, child: Text(_governorates[i])),
            ),
            onChanged: (v) => setState(() => _governorate = v!),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _cityController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'المدينة / المركز',
              prefixIcon: Icon(Icons.map_outlined, color: Color(0xFF00897B)),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _villageController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'القرية / الحي',
              prefixIcon: Icon(Icons.home_outlined, color: Color(0xFF00897B)),
            ),
          ),

          // ── Section: Contact ───────────────────────────────────
          _buildSectionTitle('بيانات التواصل'),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            textDirection: TextDirection.ltr,
            decoration: InputDecoration(
              labelText: l10n.email,
              hintText: l10n.emailHint,
              prefixIcon: const Icon(
                Icons.email_outlined,
                color: Color(0xFF00897B),
              ),
            ),
            validator: (v) {
              if (v == null || v.trim().isEmpty) return l10n.emailRequired;
              final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
              if (!emailRegex.hasMatch(v.trim())) return l10n.emailInvalid;
              return null;
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            textDirection: TextDirection.ltr,
            decoration: InputDecoration(
              labelText: l10n.phoneNumber,
              prefixIcon: const Icon(
                Icons.phone_outlined,
                color: Color(0xFF00897B),
              ),
            ),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? l10n.phoneRequired : null,
          ),

          // ── Section: Security ──────────────────────────────────
          _buildSectionTitle('كلمة المرور'),
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.next,
            textDirection: TextDirection.ltr,
            decoration: InputDecoration(
              labelText: l10n.password,
              prefixIcon: const Icon(
                Icons.lock_outlined,
                color: Color(0xFF00897B),
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
            validator: (v) {
              if (v == null || v.isEmpty) return l10n.passwordRequired;
              if (v.length < 6) return l10n.passwordTooShort;
              return null;
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: _obscureConfirmPassword,
            textInputAction: TextInputAction.done,
            textDirection: TextDirection.ltr,
            onFieldSubmitted: (_) => _onSubmit(),
            decoration: InputDecoration(
              labelText: l10n.confirmPassword,
              prefixIcon: const Icon(
                Icons.lock_clock_outlined,
                color: Color(0xFF00897B),
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
            validator: (v) =>
                v != _passwordController.text ? l10n.passwordsNotMatch : null,
          ),

          // ── Section: Documents ─────────────────────────────────
          _buildSectionTitle('المستندات الطبية'),
          GestureDetector(
            onTap: _pickFile,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _attachmentFile != null
                    ? const Color(0xFF00897B).withAlpha(15)
                    : AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _attachmentFile != null
                      ? const Color(0xFF00897B).withAlpha(80)
                      : AppColors.textSecondary.withAlpha(60),
                  style: BorderStyle.solid,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _attachmentFile != null
                        ? Icons.check_circle_outline
                        : Icons.upload_file_outlined,
                    color: _attachmentFile != null
                        ? const Color(0xFF00897B)
                        : AppColors.textSecondary,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _attachmentName ??
                          'ارفع مستند إثبات التخصص (PDF أو صورة)',
                      style: TextStyle(
                        color: _attachmentFile != null
                            ? const Color(0xFF00897B)
                            : AppColors.textSecondary,
                        fontSize: 13,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (_attachmentFile != null) ...[
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => setState(() {
                        _attachmentFile = null;
                        _attachmentName = null;
                      }),
                      child: Icon(
                        Icons.close,
                        color: AppColors.error,
                        size: 18,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 28),

          // ── Submit Button ──────────────────────────────────────
          BlocBuilder<RegisterCubit, RegisterState>(
            builder: (context, state) {
              final isLoading = state is RegisterLoading;
              return ElevatedButton(
                onPressed: isLoading ? null : _onSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00897B),
                ),
                child: isLoading
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                    : const Text('إرسال طلب التسجيل'),
              );
            },
          ),
        ],
      ),
    );
  }
}
