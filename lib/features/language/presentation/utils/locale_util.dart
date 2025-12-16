import 'dart:ui';

String toIntlLocale(Locale locale) {
  final lang = locale.languageCode;
  final country = locale.countryCode;
  if (country == null || country.isEmpty) return lang;
  return '${lang}_$country';
}
