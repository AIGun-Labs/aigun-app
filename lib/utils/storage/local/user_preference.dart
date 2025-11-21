import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  static const String _soundKey = 'sound_enabled';
  final SharedPreferences _prefs;
  UserPreference(this._prefs);
  Future<bool> getSoundEnabled() async {
    return _prefs.getBool(_soundKey) ?? true;
  }

  Future<void> toggleSoundEnabled() async {
    final soundEnabled = await getSoundEnabled();
    await _prefs.setBool(_soundKey, !soundEnabled);
  }
}
