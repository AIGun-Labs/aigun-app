import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'language_setting_entity.freezed.dart';

@freezed
class LanguageSettingEntity with _$LanguageSettingEntity {
  LanguageSettingEntity({required this.followSystem, required this.locale});
  @override
  final bool followSystem;
  @override
  final Locale locale;
}
