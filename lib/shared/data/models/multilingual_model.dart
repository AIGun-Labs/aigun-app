import 'package:freezed_annotation/freezed_annotation.dart';

part 'multilingual_model.g.dart';

@JsonSerializable()
class MultilingualModel {
  const MultilingualModel({this.zh, this.en, this.original, this.ja, this.ko});

  factory MultilingualModel.empty() =>
      const MultilingualModel(zh: '', en: '', original: '', ja: '', ko: '');

  factory MultilingualModel.fromJson(Map<String, dynamic> json) =>
      _$MultilingualModelFromJson(json);

  Map<String, dynamic> toJson() => _$MultilingualModelToJson(this);

  final String? zh;
  final String? en;
  final String? original;
  final String? ja;
  final String? ko;

  bool get isEmpty =>
      (zh == null || zh!.isEmpty) &&
      (en == null || en!.isEmpty) &&
      (original == null || original!.isEmpty) &&
      (ja == null || ja!.isEmpty) &&
      (ko == null || ko!.isEmpty);
}
