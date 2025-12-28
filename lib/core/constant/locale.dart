import 'dart:ui';

const Locale localeUnkown = Locale.fromSubtags();

const Locale localeZh = Locale('zh');
const Locale localeEn = Locale('en');

const Locale localeJp = Locale('jp', 'JP');
const Locale localeKo = Locale('ko', 'KR');

const Locale localeDe = Locale('de', 'DE');
const Locale localeFr = Locale('fr', 'FR');
const Locale localeIt = Locale('it', 'IT');
const Locale localeEs = Locale('es', 'ES');

List<SupportedLocalesEntity> supportedlocales = [
  SupportedLocalesEntity(name: 'English', locale: localeEn),
  SupportedLocalesEntity(name: '', locale: localeZh),
];

class SupportedLocalesEntity {
  SupportedLocalesEntity({required this.name, required this.locale});

  final String name;
  final Locale locale;
}
