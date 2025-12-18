import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constant/locale.dart';
import '../../../../core/constant/storage_keys.dart';
import '../../domain/entities/language_setting_entity.dart';

class LanguageLocalSource {
  LanguageLocalSource(this._prefs);
  final SharedPreferences _prefs;

  static const String _languageCode = StorageKeys.kLangCode;

  static const String _countryCode = StorageKeys.kCountryCode;

  static const String _followSystemLang = StorageKeys.kFollowSystemLang;

  static const String _localeStrKey = StorageKeys.kLocaleStr;

  Future<LanguageSettingEntity> loadSetting() async {
    final followSystemLang = _prefs.getBool(_followSystemLang) ?? true;

    final langCode = _prefs.getString(_languageCode);

    if (langCode == null || langCode.isEmpty) {
      Locale locale = PlatformDispatcher.instance.locale;
      if (locale == localeUnkown) locale = localeEn;
      await saveLocale(locale);

      return LanguageSettingEntity(
        followSystem: followSystemLang,
        locale: locale,
      );
    }

    final countryCode = _prefs.getString(_countryCode);

    return LanguageSettingEntity(
      followSystem: followSystemLang,
      locale: Locale(langCode, countryCode),
    );
  }

  Future<void> saveSetting(LanguageSettingEntity setting) async {
    await saveFollowSystem(setting.followSystem);
    await saveLocale(setting.locale);
  }

  Future<void> saveLocale(Locale locale) async {
    await _prefs.setString(_localeStrKey, locale.toString());
    await _prefs.setString(_languageCode, locale.languageCode);
    if (locale.countryCode != null) {
      await _prefs.setString(_countryCode, locale.countryCode!);
    } else {
      await _prefs.remove(_countryCode);
    }
  }

  Future<void> saveFollowSystem(bool followSystem) async {
    await _prefs.setBool(_followSystemLang, followSystem);
  }
}
