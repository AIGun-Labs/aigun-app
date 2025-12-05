import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/mixins/multilingual_content.dart';
import '../../../utils/language_utils.dart';

part 'language.freezed.dart';
part 'language.g.dart';

@freezed
sealed class Multilingual with _$Multilingual, IMultilingualContent {
  const Multilingual._();

  const factory Multilingual({
    @JsonKey(name: 'zh', defaultValue: '') String? zh,
    @JsonKey(name: 'en', defaultValue: '') String? en,
    @JsonKey(name: 'original', defaultValue: '') String? original,
    @JsonKey(name: 'jp', defaultValue: '') String? jp,
    @JsonKey(name: 'ko', defaultValue: '') String? ko,
  }) = _Multilingual;

  factory Multilingual.fromJson(Map<String, dynamic> json) =>
      _$MultilingualFromJson(json);

  String getByLocale(BuildContext context) =>
      LanguageUtils.getContentByLanguage(context, this);

  factory Multilingual.empty() => const Multilingual();

  bool get isEmpty =>
      (zh == null || zh!.isEmpty) &&
      (en == null || en!.isEmpty) &&
      (original == null || original!.isEmpty) &&
      (jp == null || jp!.isEmpty) &&
      (ko == null || ko!.isEmpty);
}
