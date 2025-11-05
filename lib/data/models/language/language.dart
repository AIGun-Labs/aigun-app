import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_aigun/shared/mixins/multilingual_content.dart';

part 'language.freezed.dart';
part 'language.g.dart';

@freezed
class Multilingual with _$Multilingual, IMultilingualContent {
  const Multilingual._();

  const factory Multilingual({
    @JsonKey(name: 'zh', defaultValue: '') String? zh,
    @JsonKey(name: 'en', defaultValue: '') String? en,
  }) = _Multilingual;

  factory Multilingual.fromJson(Map<String, dynamic> json) =>
      _$MultilingualFromJson(json);
}
