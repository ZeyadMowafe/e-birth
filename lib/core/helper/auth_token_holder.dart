/// A simple in-memory token holder that persists for the app's lifetime.
/// Populated immediately after login and cleared on logout.
class AuthTokenHolder {
  AuthTokenHolder._();

  static String? _token;

  static String? get token => _token;

  static void setToken(String token) {
    _token = token;
  }

  static void clearToken() {
    _token = null;
  }
}
