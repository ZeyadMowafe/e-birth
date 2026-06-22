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
  String get nationalId => 'الرقم القومي';

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

  @override
  String get male => 'ذكر';
  @override
  String get female => 'أنثى';
  @override
  String get notAvailable => 'غير متوفر';
  @override
  String get retry => 'إعادة المحاولة';
  @override
  String get cancel => 'إلغاء';
  @override
  String get save => 'حفظ';
  @override
  String get confirm => 'تأكيد';
  @override
  String get profile => 'الملف الشخصي';
  @override
  String get medicalHistory => 'تاريخي الطبي';
  @override
  String get notifications => 'الإشعارات';
  @override
  String get helpAndSupport => 'المساعدة والدعم';
  @override
  String get myChildren => 'أطفالي';
  @override
  String get search => 'بحث';
  @override
  String get fullName => 'الاسم بالكامل';
  @override
  String get birthDate => 'تاريخ الميلاد';
  @override
  String get bloodType => 'فصيلة الدم';
  @override
  String get governorate => 'المحافظة';
  @override
  String get city => 'المدينة';
  @override
  String get village => 'القرية';
  @override
  String get address => 'العنوان';
  @override
  String get age => 'العمر';
  @override
  String get gender => 'النوع';
  @override
  String get noData => 'لا توجد بيانات';
  @override
  String get noChildrenRegistered => 'لا يوجد أطفال مسجلين حالياً';
  @override
  String get childInfo => 'ملف الطفل';
  @override
  String get parentInfo => 'بيانات ولي الأمر';
  @override
  String get parentName => 'اسم ولي الأمر';
  @override
  String get medicalRecord => 'سجل طبي';
  @override
  String get addMedicalRecord => 'إضافة سجل طبي';
  @override
  String get medicalReports => 'التقارير الطبية';
  @override
  String get diagnosis => 'التشخيص';
  @override
  String get prescription => 'الوصفة العلاجية';
  @override
  String get attachments => 'المرفقات';
  @override
  String get medicine => 'الدواء';
  @override
  String get description => 'الوصف';
  @override
  String get images => 'الصور';
  @override
  String get note => 'ملاحظة';
  @override
  String get viewFullFile => 'عرض الملف الكامل';
  @override
  String get complete => 'مكتمل';
  @override
  String get late => 'متأخر';
  @override
  String get upcoming => 'قادم';
  @override
  String get vaccinationDate => 'تاريخ التطعيم';
  @override
  String get completeVaccination => 'تم التطعيم';
  @override
  String get pendingVaccination => 'قيد الانتظار';
  @override
  String ageYearsMonths(Object years, Object months) => '$years سنة و $months شهر';
  @override
  String ageMonths(Object months) => '$months شهر';
  @override
  String get newborn => 'حديث الولادة';
  @override
  String get confirmLogout => 'هل أنت متأكد من رغبتك في تسجيل الخروج؟';
  @override
  String get doctorAccount => 'حساب طبيب';
  @override
  String get parentAccount => 'حساب ولي أمر';

  @override
  String get homeWelcome => 'أهلاً بك،';
  @override
  String get homeDoctorGreeting => 'أهلاً دكتور';
  @override
  String get homeWelcomeSubtitle => 'مرحبا بك';
  @override
  String get homeDoctorTitle => 'نظام المواليد - لوحة تحكم الطبيب';
  @override
  String get homeDoctorDesc => 'تابع صحة أطفالك بكل سهولة';
  @override
  String get homeUnknownUser => 'لم يتم التعرف على حساب المستخدم.';

  @override
  String get roleSelectionTitle => 'إنشاء حساب جديد';
  @override
  String get roleSelectionSubtitle => 'حدد نوع الحساب الذي تريد إنشاءه';
  @override
  String get roleParent => 'ولي أمر';
  @override
  String get roleParentDesc => 'حساب للآباء والأمهات لمتابعة أطفالهم';
  @override
  String get roleDoctor => 'طبيب';
  @override
  String get roleDoctorDesc => 'حساب للأطباء لإدارة السجلات الطبية';
  @override
  String get roleAlreadyHaveAccount => 'لديك حساب بالفعل؟ ';
  @override
  String get roleSignIn => 'تسجيل الدخول';

  @override
  String get loginRoleChoiceTitle => 'تسجيل الدخول';
  @override
  String get loginRoleChoiceSubtitle => 'اختر وضع الدخول المناسب لك للمتابعة';
  @override
  String get loginAsParent => 'دخول كـ ولي أمر';
  @override
  String get loginAsParentDesc => 'استخدام التطبيق لمتابعة أطفالك والتقارير الطبية';
  @override
  String get loginAsDoctor => 'دخول كـ طبيب';
  @override
  String get loginAsDoctorDesc => 'استخدام التطبيق لإدارة السجلات الطبية للمرضى';
  @override
  String get loginRoleChangeNote => 'يمكنك دائماً تغيير وضع الدخول من الإعدادات';

  @override
  String get registerNewAccount => 'إنشاء حساب جديد';
  @override
  String get registerJoinNow => 'انضم إلى نظام E-Birth لمتابعة صحة مولودك';
  @override
  String get registerSelectBirthDate => 'اختر تاريخ الميلاد';
  @override
  String get registerGovernorate => 'المحافظة';
  @override
  String get registerCity => 'المدينة / المركز';
  @override
  String get registerVillage => 'القرية / الحي';
  @override
  String get registerAttachmentInfo => 'مرفق اثبات المهنة';
  @override
  String get registerUploadAttachment => 'ارفع مستند إثبات التخصص (PDF أو صورة)';
  @override
  String get registerAttachmentHint => 'يرجى رفع صورة من بطاقة نقابة الأطباء أو شهادة التخرج';
  @override
  String get registerDoctorNote => 'ملاحظة: سيتم مراجعة طلبك من قبل الإدارة خلال 24-48 ساعة. ستتلقى رسالة على البريد الإلكتروني عند قبول طلبك.';
  @override
  String get registerSelectBirthDateError => 'الرجاء تحديد تاريخ الميلاد';
  @override
  String get registerSelectAttachmentError => 'الرجاء رفع مستند إثبات التخصص الطبي';

  @override
  String get loginFormTitle => 'تسجيل الدخول';
  @override
  String get loginFormSubtitle => 'أهلاً بعودتك، سجل دخولك للمتابعة';
  @override
  String get loginFormEmailOrNationalId => 'البريد الإلكتروني أو الرقم القومي';
  @override
  String get loginFormEmailOrNationalIdHint => 'أدخل البريد الإلكتروني أو الرقم القومي';
  @override
  String get loginFormEmailOrNationalIdRequired => 'الرجاء إدخال البريد الإلكتروني أو الرقم القومي';
  @override
  String get loginFormCreateAccount => 'إنشاء حساب جديد';

  @override
  String get forgotPasswordEmailLabel => 'البريد الإلكتروني   ';
  @override
  String get forgotPasswordEmailHint => 'أدخل البريد الإلكتروني';
  @override
  String get forgotPasswordRequired => 'البريد الإلكتروني أو الرقم القومي مطلوب';
  @override
  String get forgotPasswordValidEmail => 'يرجى إدخال بريد إلكتروني صحيح';

  @override
  String get passwordResetSuccess => 'تم تغيير كلمة المرور بنجاح!';
  @override
  String get passwordResetRedirect => 'جاري تحويلك لصفحة تسجيل الدخول...';

  @override
  String get pendingApprovalTitle => 'طلبك قيد المراجعة';
  @override
  String get pendingApprovalStep1 => 'تم استلام طلبك وبياناتك بنجاح ✅';
  @override
  String get pendingApprovalStep2 => 'مراجعة المستندات من فريق E-Birth';
  @override
  String get pendingApprovalStep3 => 'إرسال بريد إلكتروني بنتيجة المراجعة';
  @override
  String get pendingApprovalTime => 'سيتم الرد خلال 24-48 ساعة';
  @override
  String get pendingApprovalBackToLogin => 'العودة إلى تسجيل الدخول';

  @override
  String get resetPasswordTitle => 'تغيير كلمة المرور';
  @override
  String get resetPasswordSubtitle => 'أدخل كلمة المرور الجديدة';
  @override
  String get resetPasswordNewPassword => 'كلمة المرور الجديدة';
  @override
  String get resetPasswordNewPasswordHint => 'أدخل كلمة المرور الجديدة';
  @override
  String get resetPasswordConfirmPassword => 'تأكيد كلمة المرور';
  @override
  String get resetPasswordConfirmPasswordHint => 'أعد إدخال كلمة المرور الجديدة';
  @override
  String get resetPasswordButton => 'تغيير كلمة المرور';
  @override
  String get resetPasswordConfirmRequired => 'تأكيد كلمة المرور مطلوب';
  @override
  String get resetPasswordNotMatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get doctorProfileTitle => 'الملف الشخصي للطبيب';
  @override
  String get doctorSpecialist => 'طبيب متخصص';
  @override
  String get doctorPersonalInfo => 'المعلومات الشخصية';
  @override
  String get doctorContactInfo => 'بيانات التواصل والموقع';
  @override
  String get doctorLogoutConfirm => 'هل أنت متأكد من رغبتك في تسجيل الخروج؟';

  @override
  String get doctorDashboardNoApprovedTitle => 'طلبك قيد المراجعة';
  @override
  String get doctorDashboardNoApprovedMsg => 'حسابك لم يتم الموافقة عليه بعد. سيتم مراجعة طلبك والرد عليك خلال 48 ساعة على البريد الإلكتروني المسجل.';
  @override
  String get doctorDashboardNoApprovedTime => 'سيتم الرد خلال 24-48 ساعة';

  @override
  String get childDetailsTitle => 'ملف المريض';
  @override
  String get childDetailsChildTitle => 'ملف الطفل';
  @override
  String get childDetailsBasicInfo => 'البيانات الأساسية';
  @override
  String get childDetailsVaccinations => 'جدول التطعيمات';
  @override
  String get childDetailsMedicalHistory => 'التاريخ المرضي';
  @override
  String get childDetailsPersonalInfo => 'المعلومات الشخصية';
  @override
  String get childDetailsMedicalHistoryTitle => 'التاريخ المرضي والزيارات';
  @override
  String get childDetailsMedicalHistoryDesc => 'عرض لجميع التشخيصات والتقارير الطبية السابقة';
  @override
  String get childDetailsNoMedicalHistory => 'لا يوجد تاريخ طبي مسجل حالياً';
  @override
  String get childDetailsNoMedicalHistoryDesc => 'سيتم عرض الزيارات الطبية والتشخيصات هنا.';
  @override
  String get childDetailsViewReport => 'عرض التقرير الطبي الكامل';
  @override
  String get childDetailsNoDiagnosis => 'لا يوجد تشخيص مسجل.';
  @override
  String get childDetailsNoPrescription => 'لا يوجد وصف علاجي.';
  @override
  String get childDetailsClinicReport => 'تقرير زيارة عيادة';
  @override
  String get childDetailsDosageNote => 'يرجى اتباع الجرعات الموصوفة بدقة.';
  @override
  String get childDetailsNoAttachments => 'لا توجد ملفات مرفقة بهذا التقرير';

  @override
  String get parentProfileBasicInfo => 'المعلومات الأساسية';
  @override
  String get parentProfileContactAddress => 'بيانات التواصل والعنوان';
  @override
  String get parentProfileRecords => 'السجلات والخدمات';
  @override
  String get parentProfileViewMyHistory => 'عرض سجلي الطبي الشخصي';
  @override
  String get parentProfileHistoryDesc => 'الوصفات، الفحوصات والتقارير الطبية';
  @override
  String get parentProfileEditProfile => 'تعديل الملف الشخصي';

  @override
  String get parentDashboardParentNotFound => 'لم يتم العثور على الحساب';
  @override
  String get parentDashboardParentNotFoundMsg => 'لم يتم العثور على بيانات ولي الأمر المرتبطة بهذا الحساب. يرجى التواصل مع الدعم الفني.';

  @override
  String otpResendIn(Object seconds) => 'إعادة الإرسال خلال $seconds ثانية';

  @override
  String childCardAge(Object age) => 'العمر: $age';
  @override
  String get childCardViewProfile => 'عرض الملف الكامل';

  @override
  String get medicalHistoryTitle => 'تاريخي الطبي';
  @override
  String get medicalHistoryEmpty => 'لا يوجد سجلات طبية مسجلة بعد.';

  @override
  String get doctorSearchHint => 'البحث برقم الطفل القومي...';
  @override
  String get doctorSearchResult => 'نتيجة البحث';
  @override
  String doctorSearchNationalId(Object id) => 'الرقم القومي: $id';
  @override
  String get doctorSearchParentName => 'ولي الأمر';
  @override
  String get doctorSearchAddNote => 'إضافة ملاحظة';
  @override
  String get doctorSearchFullProfile => 'الملف الكامل';
  @override
  String get doctorSearchBloodType => 'فصيلة الدم';
  @override
  String get doctorSearchBloodTypeNA => 'غير محدد';
  @override
  String get doctorSearchAddress => 'العنوان';

  @override
  String get addRecordTitle => 'إضافة سجل طبي';
  @override
  String addRecordForChild(Object name) => 'للطفل: $name';
  @override
  String get addRecordMedicine => 'اسم الدواء / التشخيص';
  @override
  String get addRecordMedicineHint => 'مثال: بنادول للأطفال';
  @override
  String get addRecordMedicineRequired => 'يرجى إدخال الحقل';
  @override
  String get addRecordDescription => 'الملاحظات الطبية';
  @override
  String get addRecordDescriptionHint => 'اكتب تفاصيل الحالة والتعليمات...';
  @override
  String get addRecordDescriptionRequired => 'يرجى إدخال التفاصيل';
  @override
  String get addRecordImages => 'الصور الطبية (إجباري)';
  @override
  String get addRecordUploadImages => 'إرفاق صور (أشعة، تحاليل، إلخ)';
  @override
  String get addRecordImageRequired => 'يرجى اختيار صورة واحدة على الأقل';
  @override
  String get addRecordSuccess => 'تمت إضافة السجل بنجاح';
  @override
  String addRecordFileError(Object error) => 'خطأ في اختيار الملفات: $error';
  @override
  String get addRecordSubmit => 'حفظ السجل';

  @override
  String get vaccinationNoRecords => 'لا توجد سجلات تطعيم.';
  @override
  String vaccinationDateLabel(Object date) => 'تم التطعيم في $date';
  @override
  String get vaccinationGoNow => 'يرجى التوجه لتلقي التطعيم';
  @override
  String get vaccinationPending => 'موعد التطعيم في الانتظار';

  @override
  String get splashHealthSystem => 'نظام إدارة السجل الصحي للأطفال';
  @override
  String get splashCareMessage => 'رعاية متكاملة لمولودك منذ اللحظة الأولى';
}
