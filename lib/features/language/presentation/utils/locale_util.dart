import 'dart:ui';

String toIntlLocale(Locale locale) {
  final lang = locale.languageCode;
  final country = locale.countryCode;
  if (country == null || country.isEmpty) return lang;
  return '${lang}_$country';
}

// class IntlSync {
//   static final Set<String> _inited = <String>{};

//   static Future<void> apply(Locale locale) async {
//     final name = Intl.canonicalizedLocale(toIntlLocale(locale));

//     // 设置 Intl 全局默认 locale
//     Intl.defaultLocale = name;

//     // 如果项目里使用了 DateFormat（月份名、星期等），建议初始化
//     if (_inited.add(name)) {
//       await initializeDateFormatting(name);
//     }
//   }
// }
