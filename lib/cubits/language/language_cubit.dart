import 'package:flutter/material.dart';
import 'package:flutter_aigun/enums/storage_key.dart';
import 'package:flutter_aigun/utils/storage/share_preferences_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/language/language_state.dart';
import 'package:get_it/get_it.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(const LanguageState(locale: Locale('zh'))) {
    _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    final prefs = GetIt.I<SharePreferencesService>();
    final languageCode = await prefs.getString(StorageKey.appLanguageCode.value,
        defaultValue: 'zh', useCache: true);
    emit(state.copyWith(locale: Locale(languageCode!)));
  }

  Future<void> setLanguage(BuildContext context, String languageCode) async {
    final prefs = GetIt.I<SharePreferencesService>();
    await prefs.setString(StorageKey.appLanguageCode.value, languageCode);

    final newLocale = Locale(languageCode);
    emit(state.copyWith(locale: newLocale));
  }

  /// 切换语言功能：在中英文之间自动切换
  Future<void> changeLanguage(BuildContext context) async {
    final currentLanguageCode = state.locale.languageCode;
    final newLanguageCode = currentLanguageCode == 'zh' ? 'en' : 'zh';

    await setLanguage(context, newLanguageCode);
  }

  /// 获取当前语言代码
  String getCurrentLanguageCode() {
    return state.locale.languageCode;
  }

  /// 检查当前是否为中文
  bool isChineseSelected() {
    return state.locale.languageCode == 'zh';
  }

  /// 检查当前是否为英文
  bool isEnglishSelected() {
    return state.locale.languageCode == 'en';
  }
}
