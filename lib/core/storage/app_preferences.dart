import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  static const _kOnboardingCompletedKey = "has_completed_onboarding";

  Future<bool> hasCompletedOnboarding() async {
    final prefs = await _prefs;
    return prefs.getBool(_kOnboardingCompletedKey) ?? false;
  }

  Future<void> setOnboardingCompleted(bool value) async {
    final prefs = await _prefs;
    await prefs.setBool(_kOnboardingCompletedKey, value);
  }
}
