import 'package:flutter/material.dart';

class Language {
  static const String en = 'en';
  static const String zh = 'zh';

  static String getLanguageCode(BuildContext context) {
    return Localizations.localeOf(context).languageCode;
  }

  static bool isEnglish(BuildContext context) {
    return Localizations.localeOf(context).languageCode == en;
  }

  static bool isChinese(BuildContext context) {
    return Localizations.localeOf(context).languageCode == zh;
  }
}
