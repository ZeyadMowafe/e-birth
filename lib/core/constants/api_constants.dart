class ApiConstants {
  // ─── Base URL ─────────────────────────────────────────────────────────────
  static const String baseUrl = 'http://ebirth.runasp.net/api/v1';

  // ─── Auth Endpoints ───────────────────────────────────────────────────────
  static const String login = '/Auth/UserLogin';
  static const String register = '/Auth/CreateParent';
  static const String createDoctor = '/Auth/CreateDoctor';
  static const String forgotPassword = '/Auth/ForgetPassword';
  static const String verifyOtp = '/Auth/IsvalidOtp';
  static const String resetPassword = '/Auth/ResetPassword';

  // ─── Parent Endpoints ─────────────────────────────────────────────────────
  static const String getParentWithChildren = '/Parent/GetParentWithChilderen';
  static const String getParentDetails = '/Parent/GetParentDetailsAsync';
  static const String getChildDetails = '/Parent/GetChildDetailsAsync';
  static const String getChildVaccinations = '/Parent/GetChildVaccinationsAsync';
  static const String getChildMedicalHistory = '/Parent/GetChildMedicalHistoryAsync';
  static const String getParentMedicalHistory = '/Parent/GetParentMedicalHistoryAsync';
  static const String getSpecificChildMedicalHistory = '/Parent/GetSpecificChildMedicalHistoryAsync';
  static const String getSpecificParentMedicalHistory = '/Parent/GetSpecificParentMedicalHistoryAsync';

  // ─── Timings ──────────────────────────────────────────────────────────────
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
}
