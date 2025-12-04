import 'package:json_annotation/json_annotation.dart';

part 'multilingual_model.g.dart';

@JsonSerializable()
class MultilingualModel {
  @JsonKey(defaultValue: '')
  final String zh;

  @JsonKey(defaultValue: '')
  final String en;

  @JsonKey(defaultValue: '')
  final String original;

  @JsonKey(defaultValue: '')
  final String jp;

  @JsonKey(defaultValue: '')
  final String? ko;

  const MultilingualModel({
    this.zh = '',
    this.en = '',
    this.original = '',
    this.jp = '',
    this.ko = '',
  });

  factory MultilingualModel.fromJson(Map<String, dynamic> json) =>
      _$MultilingualModelFromJson(json);

  Map<String, dynamic> toJson() => _$MultilingualModelToJson(this);
}
