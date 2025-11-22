import 'package:shared_preferences/shared_preferences.dart';

class SettingsStorage {
  static const String _hideSmallAssetsKey = 'hide_small_assets';
  final SharedPreferences _prefs;

  SettingsStorage(this._prefs);

  bool get hideSmallAssets => _prefs.getBool(_hideSmallAssetsKey) ?? false;

  Future<void> setHideSmallAssets(bool value) async {
    await _prefs.setBool(_hideSmallAssetsKey, value);
  }
}
