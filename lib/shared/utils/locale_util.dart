import 'package:flutter/material.dart';

import '../../core/constant/locale.dart';
import '../data/models/multilingual_model.dart';

final class LocaleUtil {
  LocaleUtil._();

  static String getTextByLanguage(
    BuildContext context,
    MultilingualModel? content,
  ) {
    final locale = Localizations.localeOf(context);

    final languageCode = locale.languageCode;

    if (languageCode == localeZh.languageCode) {
      return content?.zh ?? '';
    } else if (languageCode == localeEn.languageCode) {
      return content?.en ?? '';
    } else {
      return content?.original ?? '';
    }
  }
}
