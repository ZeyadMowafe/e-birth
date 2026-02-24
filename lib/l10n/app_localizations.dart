import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('ar')];

  /// No description provided for @appName.
  ///
  /// In ar, this message translates to:
  /// **'إي-بيرث'**
  String get appName;

  /// No description provided for @login.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get login;

  /// No description provided for @logout.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الخروج'**
  String get logout;

  /// No description provided for @register.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء حساب'**
  String get register;

  /// No description provided for @name.
  ///
  /// In ar, this message translates to:
  /// **'الاسم بالكامل'**
  String get name;

  /// No description provided for @nationalId.
  ///
  /// In ar, this message translates to:
  /// **'الالرقم القومي'**
  String get nationalId;

  /// No description provided for @phoneNumber.
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف'**
  String get phoneNumber;

  /// No description provided for @confirmPassword.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد كلمة المرور'**
  String get confirmPassword;

  /// No description provided for @email.
  ///
  /// In ar, this message translates to:
  /// **'البريد الإلكتروني'**
  String get email;

  /// No description provided for @password.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور'**
  String get password;

  /// No description provided for @emailHint.
  ///
  /// In ar, this message translates to:
  /// **'أدخل بريدك الإلكتروني'**
  String get emailHint;

  /// No description provided for @passwordHint.
  ///
  /// In ar, this message translates to:
  /// **'أدخل كلمة المرور'**
  String get passwordHint;

  /// No description provided for @loginButton.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get loginButton;

  /// No description provided for @welcomeBack.
  ///
  /// In ar, this message translates to:
  /// **'مرحباً بك مجدداً!'**
  String get welcomeBack;

  /// No description provided for @ebirth.
  ///
  /// In ar, this message translates to:
  /// **'إي-بيرث'**
  String get ebirth;

  /// No description provided for @registerSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'أدخل بياناتك لإنشاء حساب جديد'**
  String get registerSubtitle;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In ar, this message translates to:
  /// **'لديك حساب بالفعل؟ '**
  String get alreadyHaveAccount;

  /// No description provided for @dontHaveAccount.
  ///
  /// In ar, this message translates to:
  /// **'ليس لديك حساب؟ '**
  String get dontHaveAccount;

  /// No description provided for @forgotPassword.
  ///
  /// In ar, this message translates to:
  /// **'نسيت كلمة المرور؟'**
  String get forgotPassword;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In ar, this message translates to:
  /// **'نسيت كلمة المرور'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'أدخل بريدك الإلكتروني لإعادة تعيين كلمة المرور'**
  String get forgotPasswordSubtitle;

  /// No description provided for @sendResetLink.
  ///
  /// In ar, this message translates to:
  /// **'إرسال رابط إعادة التعيين'**
  String get sendResetLink;

  /// No description provided for @resetLinkSent.
  ///
  /// In ar, this message translates to:
  /// **'تم إرسال رابط إعادة التعيين إلى بريدك الإلكتروني!'**
  String get resetLinkSent;

  /// No description provided for @otpTitle.
  ///
  /// In ar, this message translates to:
  /// **'رمز التحقق'**
  String get otpTitle;

  /// No description provided for @otpSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'أدخل الرمز المكون من 4 أرقام المرسل إلى '**
  String get otpSubtitle;

  /// No description provided for @verify.
  ///
  /// In ar, this message translates to:
  /// **'تحقق'**
  String get verify;

  /// No description provided for @resendOtp.
  ///
  /// In ar, this message translates to:
  /// **'إعادة إرسال الرمز'**
  String get resendOtp;

  /// No description provided for @otpInvalid.
  ///
  /// In ar, this message translates to:
  /// **'رمز التحقق غير صالح'**
  String get otpInvalid;

  /// No description provided for @signUpNow.
  ///
  /// In ar, this message translates to:
  /// **'أنشئ حساباً الآن'**
  String get signUpNow;

  /// No description provided for @signInNow.
  ///
  /// In ar, this message translates to:
  /// **'سجل دخولك الآن'**
  String get signInNow;

  /// No description provided for @loginSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'قم بتسجيل الدخول إلى حسابك'**
  String get loginSubtitle;

  /// No description provided for @emailRequired.
  ///
  /// In ar, this message translates to:
  /// **'البريد الإلكتروني مطلوب'**
  String get emailRequired;

  /// No description provided for @emailInvalid.
  ///
  /// In ar, this message translates to:
  /// **'أدخل بريداً إلكترونياً صالحاً'**
  String get emailInvalid;

  /// No description provided for @nameRequired.
  ///
  /// In ar, this message translates to:
  /// **'الاسم مطلوب'**
  String get nameRequired;

  /// No description provided for @nationalIdRequired.
  ///
  /// In ar, this message translates to:
  /// **'الرقم القومي مطلوب'**
  String get nationalIdRequired;

  /// No description provided for @nationalIdInvalid.
  ///
  /// In ar, this message translates to:
  /// **'الرقم القومي يجب أن يتكون من 14 رقماً'**
  String get nationalIdInvalid;

  /// No description provided for @phoneRequired.
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف مطلوب'**
  String get phoneRequired;

  /// No description provided for @phoneInvalid.
  ///
  /// In ar, this message translates to:
  /// **'أدخل رقم هاتف صالحاً'**
  String get phoneInvalid;

  /// No description provided for @passwordRequired.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور مطلوبة'**
  String get passwordRequired;

  /// No description provided for @passwordsNotMatch.
  ///
  /// In ar, this message translates to:
  /// **'كلمات المرور غير متطابقة'**
  String get passwordsNotMatch;

  /// No description provided for @passwordTooShort.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور يجب أن تكون 6 أحرف على الأقل'**
  String get passwordTooShort;

  /// No description provided for @serverError.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ في الخادم، يرجى المحاولة مرة أخرى'**
  String get serverError;

  /// No description provided for @networkError.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد اتصال بالإنترنت'**
  String get networkError;

  /// No description provided for @unknownError.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ ما'**
  String get unknownError;

  /// No description provided for @invalidCredentials.
  ///
  /// In ar, this message translates to:
  /// **'البريد الإلكتروني أو كلمة المرور غير صحيحة'**
  String get invalidCredentials;

  /// No description provided for @loginSuccess.
  ///
  /// In ar, this message translates to:
  /// **'تم تسجيل الدخول بنجاح'**
  String get loginSuccess;

  /// No description provided for @registerSuccess.
  ///
  /// In ar, this message translates to:
  /// **'تم إنشاء الحساب بنجاح'**
  String get registerSuccess;

  /// No description provided for @errorOccurred.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ ما، يرجى المحاولة مرة أخرى'**
  String get errorOccurred;

  /// No description provided for @loading.
  ///
  /// In ar, this message translates to:
  /// **'جاري التحميل...'**
  String get loading;

  /// No description provided for @accountCreated.
  ///
  /// In ar, this message translates to:
  /// **'تم إنشاء الحساب بنجاح لـ {name}!'**
  String accountCreated(Object name);

  /// No description provided for @welcomeToEBirth.
  ///
  /// In ar, this message translates to:
  /// **'مرحباً بك في إي-بيرث! 👋'**
  String get welcomeToEBirth;

  /// No description provided for @homePageUnderConstruction.
  ///
  /// In ar, this message translates to:
  /// **'الصفحة الرئيسية - قيد الإنشاء'**
  String get homePageUnderConstruction;

  /// No description provided for @resetPassword.
  ///
  /// In ar, this message translates to:
  /// **'إعادة تعيين كلمة المرور'**
  String get resetPassword;

  /// No description provided for @onboardingSkip.
  ///
  /// In ar, this message translates to:
  /// **'تخطى'**
  String get onboardingSkip;

  /// No description provided for @onboardingGetStarted.
  ///
  /// In ar, this message translates to:
  /// **'ابدأ الآن'**
  String get onboardingGetStarted;

  /// No description provided for @onboardingNext.
  ///
  /// In ar, this message translates to:
  /// **'التالي'**
  String get onboardingNext;

  /// No description provided for @onboarding1Title.
  ///
  /// In ar, this message translates to:
  /// **'مرحباً في إي-بيرث'**
  String get onboarding1Title;

  /// No description provided for @onboarding1Desc.
  ///
  /// In ar, this message translates to:
  /// **'تطبيقك الموثوق لمتابعة صحة طفلك الرضيع وتسجيل تاريخه الصحي منذ اليوم الأول'**
  String get onboarding1Desc;

  /// No description provided for @onboarding2Title.
  ///
  /// In ar, this message translates to:
  /// **'سجّل أمراض طفلك'**
  String get onboarding2Title;

  /// No description provided for @onboarding2Desc.
  ///
  /// In ar, this message translates to:
  /// **'احتفظ بسجل دقيق لكل مرض وعلاج وزيارة طبية لطفلك الرضيع في مكان واحد آمن'**
  String get onboarding2Desc;

  /// No description provided for @onboarding3Title.
  ///
  /// In ar, this message translates to:
  /// **'متابعة صحية شاملة'**
  String get onboarding3Title;

  /// No description provided for @onboarding3Desc.
  ///
  /// In ar, this message translates to:
  /// **'راقب نمو طفلك وحالته الصحية بسهولة، وشارك السجلات مع طبيبك في أي وقت'**
  String get onboarding3Desc;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
