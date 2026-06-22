// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'E-Birth';

  @override
  String get login => 'Login';

  @override
  String get logout => 'Logout';

  @override
  String get register => 'Register';

  @override
  String get name => 'Full Name';

  @override
  String get nationalId => 'National ID';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get emailHint => 'Enter your email';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get loginButton => 'Login';

  @override
  String get welcomeBack => 'Welcome Back!';

  @override
  String get ebirth => 'E-Birth';

  @override
  String get registerSubtitle => 'Enter your details to create a new account';

  @override
  String get alreadyHaveAccount => 'Already have an account? ';

  @override
  String get dontHaveAccount => 'Don\'t have an account? ';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get forgotPasswordTitle => 'Reset Password';

  @override
  String get forgotPasswordSubtitle =>
      'Enter your email to receive a verification code';

  @override
  String get sendResetLink => 'Send Verification Code';

  @override
  String get resetLinkSent =>
      'A verification code has been sent to your email!';

  @override
  String get otpTitle => 'Verification Code';

  @override
  String get otpSubtitle => 'Enter the 6-digit code sent to ';

  @override
  String get verify => 'Verify Code';

  @override
  String get resendOtp => 'Resend Code';

  @override
  String get didNotReceiveCode => 'Didn\'t receive the code?';

  @override
  String get resendCode => 'Resend';

  @override
  String get otpInvalid => 'Invalid verification code';

  @override
  String get signUpNow => 'Sign Up Now';

  @override
  String get signInNow => 'Sign In Now';

  @override
  String get loginSubtitle => 'Sign in to your account';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get emailInvalid => 'Enter a valid email address';

  @override
  String get nameRequired => 'Name is required';

  @override
  String get nationalIdRequired => 'National ID is required';

  @override
  String get nationalIdInvalid => 'National ID must be 14 digits';

  @override
  String get phoneRequired => 'Phone number is required';

  @override
  String get phoneInvalid => 'Enter a valid phone number';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordsNotMatch => 'Passwords do not match';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters';

  @override
  String get serverError => 'A server error occurred, please try again';

  @override
  String get networkError => 'No internet connection';

  @override
  String get unknownError => 'Something went wrong';

  @override
  String get invalidCredentials => 'Invalid email or password';

  @override
  String get loginSuccess => 'Login successful';

  @override
  String get registerSuccess => 'Account created successfully';

  @override
  String get errorOccurred => 'An error occurred, please try again';

  @override
  String get loading => 'Loading...';

  @override
  String accountCreated(Object name) {
    return 'Account created successfully for $name!';
  }

  @override
  String get welcomeToEBirth => 'Welcome to E-Birth! 👋';

  @override
  String get homePageUnderConstruction => 'Home Page - Under Construction';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingGetStarted => 'Get Started';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboarding1Title => 'Register Your Child Easily';

  @override
  String get onboarding1Desc =>
      'Register your newborn\'s data digitally and quickly with the advanced E-Birth system';

  @override
  String get onboarding2Title => 'Track Vaccinations';

  @override
  String get onboarding2Desc =>
      'Receive periodic reminders about your child\'s vaccination schedule to ensure their safety';

  @override
  String get onboarding3Title => 'Complete Medical Records';

  @override
  String get onboarding3Desc =>
      'Keep all medical tests and reports in one secure place';

  @override
  String get male => 'Male';
  @override
  String get female => 'Female';
  @override
  String get notAvailable => 'N/A';
  @override
  String get retry => 'Retry';
  @override
  String get cancel => 'Cancel';
  @override
  String get save => 'Save';
  @override
  String get confirm => 'Confirm';
  @override
  String get profile => 'Profile';
  @override
  String get medicalHistory => 'Medical History';
  @override
  String get notifications => 'Notifications';
  @override
  String get helpAndSupport => 'Help & Support';
  @override
  String get myChildren => 'My Children';
  @override
  String get search => 'Search';
  @override
  String get fullName => 'Full Name';
  @override
  String get birthDate => 'Date of Birth';
  @override
  String get bloodType => 'Blood Type';
  @override
  String get governorate => 'Governorate';
  @override
  String get city => 'City';
  @override
  String get village => 'Village';
  @override
  String get address => 'Address';
  @override
  String get age => 'Age';
  @override
  String get gender => 'Gender';
  @override
  String get noData => 'No data available';
  @override
  String get noChildrenRegistered => 'No children registered yet';
  @override
  String get childInfo => 'Child Profile';
  @override
  String get parentInfo => 'Parent Information';
  @override
  String get parentName => 'Parent Name';
  @override
  String get medicalRecord => 'Medical Record';
  @override
  String get addMedicalRecord => 'Add Medical Record';
  @override
  String get medicalReports => 'Medical Reports';
  @override
  String get diagnosis => 'Diagnosis';
  @override
  String get prescription => 'Prescription';
  @override
  String get attachments => 'Attachments';
  @override
  String get medicine => 'Medicine';
  @override
  String get description => 'Description';
  @override
  String get images => 'Images';
  @override
  String get note => 'Note';
  @override
  String get viewFullFile => 'View Full Profile';
  @override
  String get complete => 'Complete';
  @override
  String get late => 'Late';
  @override
  String get upcoming => 'Upcoming';
  @override
  String get vaccinationDate => 'Vaccination Date';
  @override
  String get completeVaccination => 'Vaccination completed';
  @override
  String get pendingVaccination => 'Pending';
  @override
  String ageYearsMonths(Object years, Object months) => '$years years, $months months';
  @override
  String ageMonths(Object months) => '$months months';
  @override
  String get newborn => 'Newborn';
  @override
  String get confirmLogout => 'Are you sure you want to logout?';
  @override
  String get doctorAccount => 'Doctor Account';
  @override
  String get parentAccount => 'Parent Account';

  @override
  String get homeWelcome => 'Welcome,';
  @override
  String get homeDoctorGreeting => 'Hello Doctor';
  @override
  String get homeWelcomeSubtitle => 'Welcome';
  @override
  String get homeDoctorTitle => 'E-Birth - Doctor Dashboard';
  @override
  String get homeDoctorDesc => 'Track your children\'s health easily';
  @override
  String get homeUnknownUser => 'Unable to identify user account.';

  @override
  String get roleSelectionTitle => 'Create New Account';
  @override
  String get roleSelectionSubtitle => 'Select the type of account you want to create';
  @override
  String get roleParent => 'Parent';
  @override
  String get roleParentDesc => 'An account for parents to follow up on their children';
  @override
  String get roleDoctor => 'Doctor';
  @override
  String get roleDoctorDesc => 'An account for doctors to manage medical records';
  @override
  String get roleAlreadyHaveAccount => 'Already have an account? ';
  @override
  String get roleSignIn => 'Sign In';

  @override
  String get loginRoleChoiceTitle => 'Login';
  @override
  String get loginRoleChoiceSubtitle => 'Choose the appropriate login mode to continue';
  @override
  String get loginAsParent => 'Login as Parent';
  @override
  String get loginAsParentDesc => 'Use the app to follow up on your children and medical reports';
  @override
  String get loginAsDoctor => 'Login as Doctor';
  @override
  String get loginAsDoctorDesc => 'Use the app to manage patients\' medical records';
  @override
  String get loginRoleChangeNote => 'You can always change the login mode from settings';

  @override
  String get registerNewAccount => 'Create New Account';
  @override
  String get registerJoinNow => 'Join E-Birth to follow up on your newborn\'s health';
  @override
  String get registerSelectBirthDate => 'Select Birth Date';
  @override
  String get registerGovernorate => 'Governorate';
  @override
  String get registerCity => 'City / District';
  @override
  String get registerVillage => 'Village / Neighborhood';
  @override
  String get registerAttachmentInfo => 'Professional Certificate';
  @override
  String get registerUploadAttachment => 'Upload specialization proof (PDF or image)';
  @override
  String get registerAttachmentHint => 'Please upload a copy of your medical syndicate card or graduation certificate';
  @override
  String get registerDoctorNote => 'Note: Your application will be reviewed by the administration within 24-48 hours. You will receive an email when your application is approved.';
  @override
  String get registerSelectBirthDateError => 'Please select a birth date';
  @override
  String get registerSelectAttachmentError => 'Please upload a specialization proof document';

  @override
  String get loginFormTitle => 'Login';
  @override
  String get loginFormSubtitle => 'Welcome back, sign in to continue';
  @override
  String get loginFormEmailOrNationalId => 'Email or National ID';
  @override
  String get loginFormEmailOrNationalIdHint => 'Enter email or national ID';
  @override
  String get loginFormEmailOrNationalIdRequired => 'Please enter email or national ID';
  @override
  String get loginFormCreateAccount => 'Create New Account';

  @override
  String get forgotPasswordEmailLabel => 'Email   ';
  @override
  String get forgotPasswordEmailHint => 'Enter your email';
  @override
  String get forgotPasswordRequired => 'Email or national ID is required';
  @override
  String get forgotPasswordValidEmail => 'Please enter a valid email';

  @override
  String get passwordResetSuccess => 'Password has been changed successfully!';
  @override
  String get passwordResetRedirect => 'Redirecting you to the login page...';

  @override
  String get pendingApprovalTitle => 'Your Request is Under Review';
  @override
  String get pendingApprovalStep1 => 'Your request and data have been received successfully ✅';
  @override
  String get pendingApprovalStep2 => 'Document review by E-Birth team';
  @override
  String get pendingApprovalStep3 => 'Send email with review result';
  @override
  String get pendingApprovalTime => 'You will receive a response within 24-48 hours';
  @override
  String get pendingApprovalBackToLogin => 'Back to Login';

  @override
  String get resetPasswordTitle => 'Change Password';
  @override
  String get resetPasswordSubtitle => 'Enter your new password';
  @override
  String get resetPasswordNewPassword => 'New Password';
  @override
  String get resetPasswordNewPasswordHint => 'Enter new password';
  @override
  String get resetPasswordConfirmPassword => 'Confirm Password';
  @override
  String get resetPasswordConfirmPasswordHint => 'Re-enter new password';
  @override
  String get resetPasswordButton => 'Change Password';
  @override
  String get resetPasswordConfirmRequired => 'Password confirmation is required';
  @override
  String get resetPasswordNotMatch => 'Passwords do not match';

  @override
  String get doctorProfileTitle => 'Doctor Profile';
  @override
  String get doctorSpecialist => 'Specialist Doctor';
  @override
  String get doctorPersonalInfo => 'Personal Information';
  @override
  String get doctorContactInfo => 'Contact & Location Info';
  @override
  String get doctorLogoutConfirm => 'Are you sure you want to logout?';

  @override
  String get doctorDashboardNoApprovedTitle => 'Your Request is Under Review';
  @override
  String get doctorDashboardNoApprovedMsg => 'Your account has not been approved yet. Your request will be reviewed and you will receive a response within 48 hours at your registered email.';
  @override
  String get doctorDashboardNoApprovedTime => 'You will receive a response within 24-48 hours';

  @override
  String get childDetailsTitle => 'Patient File';
  @override
  String get childDetailsChildTitle => 'Child File';
  @override
  String get childDetailsBasicInfo => 'Basic Information';
  @override
  String get childDetailsVaccinations => 'Vaccination Schedule';
  @override
  String get childDetailsMedicalHistory => 'Medical History';
  @override
  String get childDetailsPersonalInfo => 'Personal Information';
  @override
  String get childDetailsMedicalHistoryTitle => 'Medical History & Visits';
  @override
  String get childDetailsMedicalHistoryDesc => 'View all previous diagnoses and medical reports';
  @override
  String get childDetailsNoMedicalHistory => 'No medical history recorded yet';
  @override
  String get childDetailsNoMedicalHistoryDesc => 'Medical visits and diagnoses will be displayed here.';
  @override
  String get childDetailsViewReport => 'View Full Medical Report';
  @override
  String get childDetailsNoDiagnosis => 'No diagnosis recorded.';
  @override
  String get childDetailsNoPrescription => 'No prescription recorded.';
  @override
  String get childDetailsClinicReport => 'Clinic Visit Report';
  @override
  String get childDetailsDosageNote => 'Please follow the prescribed dosages carefully.';
  @override
  String get childDetailsNoAttachments => 'No files attached to this report';

  @override
  String get parentProfileBasicInfo => 'Basic Information';
  @override
  String get parentProfileContactAddress => 'Contact & Address Info';
  @override
  String get parentProfileRecords => 'Records & Services';
  @override
  String get parentProfileViewMyHistory => 'View My Personal Medical History';
  @override
  String get parentProfileHistoryDesc => 'Prescriptions, tests and medical reports';
  @override
  String get parentProfileEditProfile => 'Edit Profile';

  @override
  String get parentDashboardParentNotFound => 'Account Not Found';
  @override
  String get parentDashboardParentNotFoundMsg => 'No parent data was found linked to this account. Please contact support.';

  @override
  String otpResendIn(Object seconds) => 'Resend in $seconds seconds';

  @override
  String childCardAge(Object age) => 'Age: $age';
  @override
  String get childCardViewProfile => 'View Full Profile';

  @override
  String get medicalHistoryTitle => 'My Medical History';
  @override
  String get medicalHistoryEmpty => 'No medical records recorded yet.';

  @override
  String get doctorSearchHint => 'Search by child\'s national ID...';
  @override
  String get doctorSearchResult => 'Search Result';
  @override
  String doctorSearchNationalId(Object id) => 'National ID: $id';
  @override
  String get doctorSearchParentName => 'Parent';
  @override
  String get doctorSearchAddNote => 'Add Medical Record';
  @override
  String get doctorSearchFullProfile => 'Full Profile';
  @override
  String get doctorSearchBloodType => 'Blood Type';
  @override
  String get doctorSearchBloodTypeNA => 'N/A';
  @override
  String get doctorSearchAddress => 'Address';

  @override
  String get addRecordTitle => 'Add Medical Record';
  @override
  String addRecordForChild(Object name) => 'For child: $name';
  @override
  String get addRecordMedicine => 'Medicine / Diagnosis';
  @override
  String get addRecordMedicineHint => 'e.g. Children\'s Panadol';
  @override
  String get addRecordMedicineRequired => 'This field is required';
  @override
  String get addRecordDescription => 'Medical Notes';
  @override
  String get addRecordDescriptionHint => 'Write case details and instructions...';
  @override
  String get addRecordDescriptionRequired => 'This field is required';
  @override
  String get addRecordImages => 'Medical Images (Required)';
  @override
  String get addRecordUploadImages => 'Upload images (X-rays, tests, etc.)';
  @override
  String get addRecordImageRequired => 'Please select at least one image';
  @override
  String get addRecordSuccess => 'Medical record added successfully';
  @override
  String addRecordFileError(Object error) => 'Error selecting files: $error';
  @override
  String get addRecordSubmit => 'Save Record';

  @override
  String get vaccinationNoRecords => 'No vaccination records found.';
  @override
  String vaccinationDateLabel(Object date) => 'Vaccination completed on $date';
  @override
  String get vaccinationGoNow => 'Please go to receive the vaccination';
  @override
  String get vaccinationPending => 'Vaccination appointment pending';

  @override
  String get splashHealthSystem => 'Child Health Record Management System';
  @override
  String get splashCareMessage => 'Integrated care for your newborn from the first moment';
}
