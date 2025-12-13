import 'package:json_annotation/json_annotation.dart';

part 'multilingual_model.g.dart';

@JsonSerializable()
class MultilingualModel {
  final String? zh;

  final String? en;

  final String? original;

  final String? jp;

  final String? ko;

  const MultilingualModel({this.zh, this.en, this.original, this.jp, this.ko});

  factory MultilingualModel.fromJson(Map<String, dynamic> json) =>
      _$MultilingualModelFromJson(json);

  Map<String, dynamic> toJson() => _$MultilingualModelToJson(this);
}
