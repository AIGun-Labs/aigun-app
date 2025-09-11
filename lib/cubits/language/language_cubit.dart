import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/app.dart';
import 'package:flutter_aigun/cubits/language/language_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(const LanguageState(locale: Locale('en'))) {
    _loadSavedLanguage();
  }

  static const String _languageCodeKey = 'language_code';

  Future<void> _loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_languageCodeKey) ?? 'en';
    emit(state.copyWith(locale: Locale(languageCode)));
  }

  Future<void> setLanguage(BuildContext context, String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageCodeKey, languageCode);

    final newLocale = Locale(languageCode);
    emit(state.copyWith(locale: newLocale));

    // 更新应用的locale
    AIGunApp.of(context)?.setLocale(newLocale);
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
