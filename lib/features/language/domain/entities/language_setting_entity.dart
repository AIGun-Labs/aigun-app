import 'dart:ui';

class LanguageSettingEntity {
  LanguageSettingEntity._({required this.followSystem, required this.locale});

  factory LanguageSettingEntity.followSystem() => LanguageSettingEntity._(
    followSystem: true,
    locale: PlatformDispatcher.instance.locale,
  );

  factory LanguageSettingEntity.custom({
    required String languageCode,
    String? countryCode,
  }) => LanguageSettingEntity._(
    followSystem: false,
    locale: Locale(languageCode, countryCode),
  );

  final bool followSystem;
  final Locale locale;
}
