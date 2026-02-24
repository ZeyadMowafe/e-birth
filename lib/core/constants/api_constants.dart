class ApiConstants {
  // ─── Base URL ─────────────────────────────────────────────────────────────
  // Switch this to the real backend URL when ready:
  static const String baseUrl = 'https://api.escuelajs.co/api/v1';

  // ─── Auth Endpoints ───────────────────────────────────────────────────────
  static const String login = '/auth/login';
  static const String register = '/users/'; // Platzi registration endpoint
  static const String forgotPassword = '/auth/forgot-password'; // Placeholder
  static const String verifyOtp = '/auth/verify-otp'; // Placeholder
  static const String resetPassword = '/auth/reset-password'; // Placeholder

  // ─── Timings ──────────────────────────────────────────────────────────────
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
}
