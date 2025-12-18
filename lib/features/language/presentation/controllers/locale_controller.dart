// features/language/presentation/locale_controller.dart
import 'dart:ui';

import 'package:flutter/foundation.dart';

import '../../../../core/constant/locale.dart';
import '../../domain/entities/language_setting_entity.dart';
import '../../domain/usecases/load_language_setting.dart';
import '../../domain/usecases/save_follow_system.dart';
import '../../domain/usecases/save_language_setting.dart';
import '../../domain/usecases/save_locale.dart';

class LocaleController extends ChangeNotifier {
  LocaleController(
    this._loadSetting,
    this._saveSetting,
    this._saveLocale,
    this._saveFollowSystem,
  );
  final LoadLanguageSetting _loadSetting;
  final SaveLanguageSetting _saveSetting;
  final SaveLocale _saveLocale;
  final SaveFollowSystem _saveFollowSystem;

  LanguageSettingEntity _setting = LanguageSettingEntity(
    followSystem: true,
    locale: PlatformDispatcher.instance.locale,
  );
  LanguageSettingEntity get setting => _setting;

  bool get followSystem => _setting.followSystem;
  Locale get appLocale => _setting.locale;

  Future<void> init() async {
    final result = await _loadSetting.call();
    if (result.isSuccess) {
      _setting = result.value!;
    }
    notifyListeners();
  }

  Future<void> followSystemMode(bool followSystem) async {
    await _saveFollowSystem.call(followSystem);
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    await _saveLocale.call(locale);
    _setting = LanguageSettingEntity(
      followSystem: followSystem,
      locale: locale,
    );
    notifyListeners();
  }

  Future<void> saveSetting(LanguageSettingEntity setting) async {
    await _saveSetting.call(setting);
    _setting = setting;
    notifyListeners();
  }

  Future<void> changeWithZhAndEn() async {
    final newLocale = appLocale.languageCode == localeEn.languageCode
        ? localeZh
        : localeEn;
    await saveSetting(
      LanguageSettingEntity(followSystem: false, locale: newLocale),
    );
  }
}
