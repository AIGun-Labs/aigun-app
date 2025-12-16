// features/language/presentation/locale_controller.dart
import 'dart:ui';

import 'package:flutter/foundation.dart';

import '../../../../core/constant/locale.dart';
import '../../domain/entities/language_setting_entity.dart';
import '../../domain/usecases/get_language_setting.dart';
import '../../domain/usecases/save_language_setting.dart';

class LocaleController extends ChangeNotifier {
  LocaleController(this._get, this._save);
  final GetLanguageSetting _get;
  final SaveLanguageSetting _save;

  LanguageSettingEntity _setting = LanguageSettingEntity.followSystem();
  LanguageSettingEntity get setting => _setting;

  bool get followSystem => _setting.followSystem;
  Locale? get appLocale => _setting.locale;

  Future<void> init() async {
    final result = await _get.call(null);
    if (result.isSuccess) {
      _setting = result.value!;
    }
    notifyListeners();
  }

  Future<void> followSystemMode() async {
    final s = LanguageSettingEntity.followSystem();
    await _save(s);
    _setting = s;
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    final s = LanguageSettingEntity.custom(
      languageCode: locale.languageCode,
      countryCode: locale.countryCode,
    );
    await _save(s);
    _setting = s;
    notifyListeners();
  }

  Future<void> setDefaultLocale() async {
    final result = await _get.call(true);
    if (result.isSuccess) {
      _setting = result.value!;
    }
    notifyListeners();
  }

  Future<void> changeWithZhAndEn() async {
    final newLocale = appLocale?.languageCode == localeEn.languageCode
        ? localeZh
        : localeEn;
    await setLocale(newLocale);
  }
}
