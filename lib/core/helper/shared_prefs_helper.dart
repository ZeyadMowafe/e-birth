import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  SharedPrefsHelper._();

  static const String _onboardingSeenKey = 'onboarding_seen';

  static Future<bool> isOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingSeenKey) ?? false;
  }

  static Future<void> setOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingSeenKey, true);
  }
}
