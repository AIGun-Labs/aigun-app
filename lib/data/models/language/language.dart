import 'package:freezed_annotation/freezed_annotation.dart';

part 'language.freezed.dart';
part 'language.g.dart';

@freezed
class Multilingual with _$Multilingual {
  const factory Multilingual({
    @JsonKey(name: 'zh', defaultValue: '') String? zh,
    @JsonKey(name: 'en', defaultValue: '') String? en,
  }) = _Multilingual;

  factory Multilingual.fromJson(Map<String, dynamic> json) =>
      _$MultilingualFromJson(json);
}
