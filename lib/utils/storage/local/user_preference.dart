import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  static const String _soundKey = "sound_enabled";

  Future<bool> getSoundEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_soundKey) ?? true;
  }

  Future<void> toggleSoundEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    final soundEnabled = await getSoundEnabled();
    await prefs.setBool(_soundKey, !soundEnabled);
  }
}
