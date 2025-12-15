import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constant/storage_keys.dart';
import '../../domain/entities/language_setting_entity.dart';

class LanguageLocalSource {
  LanguageLocalSource(this._prefs);
  final SharedPreferences _prefs;

  static const String _languageCode = StorageKeys.kLangCode;

  static const String _countryCode = StorageKeys.kCountryCode;

  static const String _followSystemLang = StorageKeys.kFollowSystemLang;

  Future<LanguageSettingEntity> load() async {
    final followSystemLang = _prefs.getBool(_followSystemLang) ?? true;

    if (followSystemLang) {
      return LanguageSettingEntity.followSystem();
    }

    final langCode = _prefs.getString(_languageCode);

    if (langCode == null || langCode.isEmpty) {
      return LanguageSettingEntity.followSystem();
    }

    final countryCode = _prefs.getString(_countryCode);
    return LanguageSettingEntity.custom(
      languageCode: langCode,
      countryCode: countryCode,
    );
  }

  Future<void> save(LanguageSettingEntity setting) async {
    await _prefs.setBool(_followSystemLang, setting.followSystem);

    if (setting.followSystem) {
      await _prefs.remove(_languageCode);
      await _prefs.remove(_countryCode);
      return;
    }

    final locale = setting.locale;
    await _prefs.setString(_languageCode, locale.languageCode);
    if (locale.countryCode != null) {
      await _prefs.setString(_countryCode, locale.countryCode!);
    } else {
      await _prefs.remove(_countryCode);
    }
  }
}
