// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'إي-بيرث';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get register => 'إنشاء حساب';

  @override
  String get name => 'الاسم بالكامل';

  @override
  String get nationalId => 'الالرقم القومي';

  @override
  String get phoneNumber => 'رقم الهاتف';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get emailHint => 'أدخل بريدك الإلكتروني';

  @override
  String get passwordHint => 'أدخل كلمة المرور';

  @override
  String get loginButton => 'تسجيل الدخول';

  @override
  String get welcomeBack => 'مرحباً بك مجدداً!';

  @override
  String get ebirth => 'إي-بيرث';

  @override
  String get registerSubtitle => 'أدخل بياناتك لإنشاء حساب جديد';

  @override
  String get alreadyHaveAccount => 'لديك حساب بالفعل؟ ';

  @override
  String get dontHaveAccount => 'ليس لديك حساب؟ ';

  @override
  String get forgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get forgotPasswordTitle => 'استعادة كلمة المرور';

  @override
  String get forgotPasswordSubtitle =>
      'أدخل بريدك الإلكتروني لاستلام رمز التحقق';

  @override
  String get sendResetLink => 'إرسال رمز التحقق';

  @override
  String get resetLinkSent => 'تم إرسال رمز التحقق إلى بريدك الإلكتروني!';

  @override
  String get otpTitle => 'رمز التحقق';

  @override
  String get otpSubtitle => 'أدخل الرمز المكون من 6 أرقام المرسل إلى ';

  @override
  String get verify => 'تأكيد الرمز';

  @override
  String get resendOtp => 'إعادة إرسال الرمز';

  @override
  String get didNotReceiveCode => 'لم تستلم الرمز؟';

  @override
  String get resendCode => 'إعادة الإرسال';

  @override
  String get otpInvalid => 'رمز التحقق غير صالح';

  @override
  String get signUpNow => 'أنشئ حساباً الآن';

  @override
  String get signInNow => 'سجل دخولك الآن';

  @override
  String get loginSubtitle => 'قم بتسجيل الدخول إلى حسابك';

  @override
  String get emailRequired => 'البريد الإلكتروني مطلوب';

  @override
  String get emailInvalid => 'أدخل بريداً إلكترونياً صالحاً';

  @override
  String get nameRequired => 'الاسم مطلوب';

  @override
  String get nationalIdRequired => 'الرقم القومي مطلوب';

  @override
  String get nationalIdInvalid => 'الرقم القومي يجب أن يتكون من 14 رقماً';

  @override
  String get phoneRequired => 'رقم الهاتف مطلوب';

  @override
  String get phoneInvalid => 'أدخل رقم هاتف صالحاً';

  @override
  String get passwordRequired => 'كلمة المرور مطلوبة';

  @override
  String get passwordsNotMatch => 'كلمات المرور غير متطابقة';

  @override
  String get passwordTooShort => 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';

  @override
  String get serverError => 'حدث خطأ في الخادم، يرجى المحاولة مرة أخرى';

  @override
  String get networkError => 'لا يوجد اتصال بالإنترنت';

  @override
  String get unknownError => 'حدث خطأ ما';

  @override
  String get invalidCredentials => 'البريد الإلكتروني أو كلمة المرور غير صحيحة';

  @override
  String get loginSuccess => 'تم تسجيل الدخول بنجاح';

  @override
  String get registerSuccess => 'تم إنشاء الحساب بنجاح';

  @override
  String get errorOccurred => 'حدث خطأ ما، يرجى المحاولة مرة أخرى';

  @override
  String get loading => 'جاري التحميل...';

  @override
  String accountCreated(Object name) {
    return 'تم إنشاء الحساب بنجاح لـ $name!';
  }

  @override
  String get welcomeToEBirth => 'مرحباً بك في إي-بيرث! 👋';

  @override
  String get homePageUnderConstruction => 'الصفحة الرئيسية - قيد الإنشاء';

  @override
  String get resetPassword => 'إعادة تعيين كلمة المرور';

  @override
  String get onboardingSkip => 'تخطى';

  @override
  String get onboardingGetStarted => 'ابدأ الآن';

  @override
  String get onboardingNext => 'التالي';

  @override
  String get onboarding1Title => 'سجل طفلك بسهولة';

  @override
  String get onboarding1Desc =>
      'سجل بيانات مولودك الجديد رقمياً وبالسرعة الفائقة مع نظام الولادة الإلكتروني المطور';

  @override
  String get onboarding2Title => 'متابعة التطعيمات';

  @override
  String get onboarding2Desc =>
      'تلقى تنبيهات دورية بمواعيد تطعيمات طفلك لضمان سلامته';

  @override
  String get onboarding3Title => 'سجل طبي متكامل';

  @override
  String get onboarding3Desc =>
      'احتفظ بكافة الفحوصات والتقارير الطبية في مكان واحد آمن';
}
