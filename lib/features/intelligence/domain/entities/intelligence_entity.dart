import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/data/models/multilingual_model.dart';
import 'ai_agent_entity.dart';
import 'author_entity.dart';
import 'extra_datas_entity.dart';
import 'media_entity.dart';
import 'token_entity.dart';

part 'intelligence_entity.freezed.dart';

/// Intelligence Entity - Core business model
///
/// This entity represents the intelligence/intel data in the domain layer.
/// It is framework-independent and contains no JSON serialization logic.
@freezed
sealed class IntelligenceEntity with _$IntelligenceEntity {
  const factory IntelligenceEntity({
    required String id,
    required IntelligenceType type,
    DateTime? publishedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<MultilingualModel>? signalTags,
    bool? isValuable,
    List<String>? tokenKeys,
    String? sourceUrl,
    MultilingualModel? title,
    MultilingualModel? content,
    ExtraDatasEntity? extraDatas,
    List<MediaEntity>? medias,
    MultilingualModel? analyzed,
    List<String>? tags,
    List<TokenEntity>? tokens,
    String? newsLogo,
    MultilingualModel? newsTitle,
    double? analyzedTime,
    double? monitorTime,
    AIAgentEntity? aiAgent,
    AuthorEntity? author,
  }) = _IntelligenceEntity;
  const IntelligenceEntity._();

  /// Check if this intelligence is an event type
  bool get isEventType => type.isEventType;

  /// Check if this intelligence is a radar signal type
  bool get isRadarSignal => type == const IntelligenceType.radarSignal();

  /// Check if this intelligence has tokens
  bool get hasTokens => tokens != null && tokens!.isNotEmpty;

  /// Check if this is an alpha intelligence
  bool get isAlpha => extraDatas?.isAlpha ?? false;
}

/// Intelligence Type - Value Object
///
/// Represents the different types of intelligence/intel
@freezed
sealed class IntelligenceType with _$IntelligenceType {
  const IntelligenceType._();

  const factory IntelligenceType.event() = IntelligenceTypeEvent;
  const factory IntelligenceType.twitter() = IntelligenceTypeTwitter;
  const factory IntelligenceType.telegram() = IntelligenceTypeTelegram;
  const factory IntelligenceType.news() = IntelligenceTypeNews;
  const factory IntelligenceType.radarSignal() = IntelligenceTypeRadarSignal;
  const factory IntelligenceType.unknown(String value) =
      IntelligenceTypeUnknown;

  /// Create from string value
  factory IntelligenceType.fromString(String? value) {
    switch (value) {
      case 'event':
        return const IntelligenceType.event();
      case 'twitter':
        return const IntelligenceType.twitter();
      case 'telegram':
        return const IntelligenceType.telegram();
      case 'news':
        return const IntelligenceType.news();
      case 'radar_signal':
        return const IntelligenceType.radarSignal();
      default:
        return IntelligenceType.unknown(value ?? 'unknown');
    }
  }

  /// Convert to string value
  String get value => when(
    event: () => 'event',
    twitter: () => 'twitter',
    telegram: () => 'telegram',
    news: () => 'news',
    radarSignal: () => 'radar_signal',
    unknown: (v) => v,
  );

  /// Check if this is an event-type intelligence (includes twitter, telegram, news)
  bool get isEventType => maybeWhen(
    event: () => true,
    twitter: () => true,
    telegram: () => true,
    news: () => true,
    orElse: () => false,
  );

  /// List of event types for filtering
  static const List<String> eventTypes = [
    'event',
    'twitter',
    'telegram',
    'news',
  ];

  /// Radar signal type value
  static const String radarSignalValue = 'radar_signal';
}
