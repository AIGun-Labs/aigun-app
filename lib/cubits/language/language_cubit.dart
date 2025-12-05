import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../enums/storage_key.dart';
import '../../utils/storage/share_preferences_service.dart';
import 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(const LanguageState(locale: Locale('zh'))) {
    _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    final prefs = GetIt.I<SharePreferencesService>();
    final languageCode = await prefs.getString(
      StorageKey.appLanguageCode.value,
      defaultValue: 'zh',
      useCache: true,
    );
    emit(state.copyWith(locale: Locale(languageCode!)));
  }

  Future<void> setLanguage(BuildContext context, String languageCode) async {
    final prefs = GetIt.I<SharePreferencesService>();
    await prefs.setString(StorageKey.appLanguageCode.value, languageCode);

    final newLocale = Locale(languageCode);
    emit(state.copyWith(locale: newLocale));
  }

  Future<void> changeLanguage(BuildContext context) async {
    final currentLanguageCode = state.locale.languageCode;
    final newLanguageCode = currentLanguageCode == 'zh' ? 'en' : 'zh';

    await setLanguage(context, newLanguageCode);
  }

  String getCurrentLanguageCode() {
    return state.locale.languageCode;
  }

  bool isChineseSelected() {
    return state.locale.languageCode == 'zh';
  }

  bool isEnglishSelected() {
    return state.locale.languageCode == 'en';
  }
}
