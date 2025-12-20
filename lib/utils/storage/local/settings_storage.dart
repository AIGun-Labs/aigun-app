import 'package:shared_preferences/shared_preferences.dart';

class SettingsStorage {
  SettingsStorage(this._prefs);
  static const String _hideSmallAssetsKey = 'hide_small_assets';
  static const String _hideSolMinimumWarningKey = 'hide_sol_minimum_warning';
  final SharedPreferences _prefs;

  bool get hideSmallAssets => _prefs.getBool(_hideSmallAssetsKey) ?? false;

  Future<void> setHideSmallAssets(bool value) async {
    await _prefs.setBool(_hideSmallAssetsKey, value);
  }

  /// Get user preference for hiding SOL minimum balance warning
  bool get hideSolMinimumWarning =>
      _prefs.getBool(_hideSolMinimumWarningKey) ?? false;

  /// Set user preference for hiding SOL minimum balance warning
  Future<void> setHideSolMinimumWarning(bool value) async {
    await _prefs.setBool(_hideSolMinimumWarningKey, value);
  }
}
