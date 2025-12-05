import 'package:shared_preferences/shared_preferences.dart';

class PermissionStorage {
  final SharedPreferences _prefs;
  PermissionStorage(this._prefs);

  static const String _privacyPermissionKey = 'privacy_permission';

  Future<bool> getPrivacyPermission() async {
    return _prefs.getBool(_privacyPermissionKey) ?? false;
  }

  Future<void> setPrivacyPermission(bool agreed) async {
    await _prefs.setBool(_privacyPermissionKey, agreed);
  }

  Future<void> clearPrivacyPermission() async {
    await _prefs.remove(_privacyPermissionKey);
  }
}
