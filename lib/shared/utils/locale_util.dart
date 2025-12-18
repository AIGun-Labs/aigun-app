import 'package:flutter/material.dart';

import '../../core/constant/locale.dart';
import '../data/models/multilingual_model.dart';

final class LocaleUtil {
  LocaleUtil._();

  static String getTextByLanguage(
    BuildContext btx,
    MultilingualModel? content,
  ) {
    if (content == null) return '';
    final code = Localizations.localeOf(btx).languageCode.toLowerCase();

    String? pick(String? v) {
      final s = v?.trim();
      return (s == null || s.isEmpty) ? null : s;
    }

    final matched = content.toJson()[code];

    if (matched != null && matched.isNotEmpty) return matched;

    return pick(content.original) ?? pick(content.en) ?? '';
  }

  static String getLanguageCode(BuildContext context) {
    return Localizations.localeOf(context).languageCode;
  }

  static bool isEnglish(BuildContext context) {
    return Localizations.localeOf(context).languageCode ==
        localeEn.languageCode;
  }

  static bool isChinese(BuildContext context) {
    return Localizations.localeOf(context).languageCode ==
        localeZh.languageCode;
  }
}
