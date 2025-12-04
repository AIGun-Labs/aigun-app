import 'package:json_annotation/json_annotation.dart';

import '../../../infrastructure/serialization/converters/naive_to_utc_dateTime_converter.dart';
import 'multilingual_model.dart';

part 'intel_v2_model.g.dart';

@JsonSerializable(explicitToJson: true, checked: true)
class IntelV2Model {
  final String id;

  @JsonKey(name: 'is_valuable', defaultValue: false)
  final bool isValuable;

  @JsonKey(name: 'analyzed_time')
  final int analyzedTime;

  final MultilingualModel analyzed;

  @JsonKey(name: 'analyzed_at')
  @NaiveToUtcDateTimeConverter()
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  @NaiveToUtcDateTimeConverter()
  final DateTime updatedAt;

  @JsonKey(name: 'published_at')
  @NaiveToUtcDateTimeConverter()
  final DateTime publishedAt;

  final String type;

  final MultilingualModel title;

  final MultilingualModel content;

  @JsonKey(name: 'abstract')
  final MultilingualModel abstractText;

  @JsonKey(name: 'source_url')
  final String sourceUrl;

  final List<String> tags;

  const IntelV2Model(
    this.id,
    this.isValuable,
    this.analyzedTime,
    this.analyzed,
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
    this.type,
    this.title,
    this.content,
    this.abstractText,
    this.sourceUrl,
    this.tags,
  );

  factory IntelV2Model.fromJson(Map<String, dynamic> json) =>
      _$IntelV2ModelFromJson(json);

  Map<String, dynamic> toJson() => _$IntelV2ModelToJson(this);
}
