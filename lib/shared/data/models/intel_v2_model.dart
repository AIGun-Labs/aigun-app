import 'package:json_annotation/json_annotation.dart';

import '../../../infrastructure/serialization/converters/naive_to_utc_date_time_converter.dart';
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

  const IntelV2Model({
    required this.id,
    required this.isValuable,
    required this.analyzedTime,
    required this.analyzed,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.type,
    required this.title,
    required this.content,
    required this.abstractText,
    required this.sourceUrl,
    required this.tags,
  });

  factory IntelV2Model.fromJson(Map<String, dynamic> json) =>
      _$IntelV2ModelFromJson(json);

  Map<String, dynamic> toJson() => _$IntelV2ModelToJson(this);
}
