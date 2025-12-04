import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/multilingual_model.dart';

part 'intel_v2_entity.freezed.dart';

@freezed
class IntelV2Entity with _$IntelV2Entity {
  @override
  final String id;

  @override
  final bool isValuable;

  @override
  final int analyzedTime;

  @override
  final MultilingualModel analyzed;

  @override
  final DateTime createdAt;

  @override
  final DateTime updatedAt;

  @override
  final DateTime publishedAt;

  @override
  final String type;

  @override
  final MultilingualModel title;

  @override
  final MultilingualModel content;

  @override
  final MultilingualModel abstractText;

  @override
  final String sourceUrl;

  @override
  final List<String> tags;

  const IntelV2Entity({
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
}
