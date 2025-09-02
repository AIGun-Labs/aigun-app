import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'intel.freezed.dart';
part 'intel.g.dart';

// Helper function to convert dynamic value to string, handles numbers and nulls
String? _stringFromDynamic(dynamic value) {
  if (value == null) return null;
  if (value is String) return value;
  if (value is num) return value.toString();
  return value.toString();
}

enum MediaType {
  @JsonValue('image')
  image,
  @JsonValue("video")
  video
}

// Top-level message wrapper for WebSocket data
@freezed
class IntelMessage with _$IntelMessage {
  const factory IntelMessage({
    String? type,
    Intel? data,
  }) = _IntelMessage;

  factory IntelMessage.fromJson(Map<String, dynamic> json) =>
      _$IntelMessageFromJson(json);
}

// The main Intel data model
@freezed
class Intel with _$Intel {
  @JsonSerializable(explicitToJson: true)
  const factory Intel({
    String? id,
    @JsonKey(name: 'published_at') DateTime? publishedAt,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'is_valuable') bool? isValuable,
    // @JsonKey(name: "is_published")
    @JsonKey(name: 'source_url') String? sourceUrl,
    String? title,
    String? content,
    @JsonKey(name: 'extra_datas') Map<String, dynamic>? extraDatas,
    List<IntelMedia>? medias,
    Analyzed? analyzed,
    double? score,
    List<String>? tags,
    List<Entity>? entities,
    @JsonKey(name: "analyzed_time") double? analyzedTime,
    @JsonKey(name: "monitor_time") double? monitorTime,
    @JsonKey(name: "ai_agent") AIAgent? aiAgent,
    @JsonKey(name: "author") Author? author,
  }) = _Intel;

  factory Intel.fromJson(Map<String, dynamic> json) => _$IntelFromJson(json);
}

@freezed
class IntelStats with _$IntelStats {
  const factory IntelStats({
    @JsonKey(name: "warning_price_usd", fromJson: _stringFromDynamic)
    String? warningPriceUsd,
    @JsonKey(name: "warning_market_cap", fromJson: _stringFromDynamic)
    String? warningMarketCap,
    @JsonKey(name: "current_price_usd", fromJson: _stringFromDynamic)
    String? currentPriceUsd,
    @JsonKey(name: "current_market_cap", fromJson: _stringFromDynamic)
    String? currentMarketCap,
    @JsonKey(name: "increase_rate", fromJson: _stringFromDynamic)
    String? increaseRate,
    @JsonKey(name: "highest_increase_rate", fromJson: _stringFromDynamic)
    String? heighestIncreaseRate,
  }) = _IntelStats;

  factory IntelStats.fromJson(Map<String, dynamic> json) =>
      _$IntelStatsFromJson(json);
}

@freezed
class AIAgent with _$AIAgent {
  const factory AIAgent({
    String? name,
    String? avatar,
  }) = _AIAgent;

  factory AIAgent.fromJson(Map<String, dynamic> json) =>
      _$AIAgentFromJson(json);
}

@freezed
class Author with _$Author {
  const factory Author({
    String? avatar,
    String? slug,
    IntelPlatform? platform,
    String? prompt,
  }) = _Author;

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);
}

@freezed
class IntelPlatform with _$IntelPlatform {
  const factory IntelPlatform({
    String? name,
    String? id,
    String? logo,
  }) = _IntelPlatform;

  factory IntelPlatform.fromJson(Map<String, dynamic> json) =>
      _$IntelPlatformFromJson(json);
}

@freezed
class IntelMedia with _$IntelMedia {
  const factory IntelMedia({
    String? url,
    MediaType? type,
  }) = _IntelMedia;

  factory IntelMedia.fromJson(Map<String, dynamic> json) =>
      _$IntelMediaFromJson(json);
}

// Analyzed data model
@freezed
class Analyzed with _$Analyzed {
  const factory Analyzed({
    String? zh,
    String? en,
  }) = _Analyzed;

  factory Analyzed.fromJson(Map<String, dynamic> json) =>
      _$AnalyzedFromJson(json);
}

@freezed
class IntelChain with _$IntelChain {
  const factory IntelChain({
    String? name,
    String? id,
    String? address,
    String? logo,
    String? slug,
    @JsonKey(name: "network_id") String? networkId,
  }) = _IntelChain;

  factory IntelChain.fromJson(Map<String, dynamic> json) =>
      _$IntelChainFromJson(json);
}

// Entity data model
// @freezed
// class Entity with _$Entity {
//   const factory Entity({
//     String? id,
//     @JsonKey(name: 'created_at') DateTime? createdAt,
//     @JsonKey(name: 'updated_at') DateTime? updatedAt,
//     String? name,
//     String? slug,
//     String? type,
//     String? avatar,
//     @JsonKey(name: 'influence_level') dynamic influenceLevel,
//     @JsonKey(name: 'influence_score') dynamic influenceScore,
//     String? description,
//     dynamic locations,
//     String? source,
//     @JsonKey(name: 'extra_data') dynamic extraData,
//     @JsonKey(name: 'is_test') dynamic isTest,
//     @JsonKey(name: 'is_visible') dynamic isVisible,
//     @JsonKey(name: 'is_deleted') dynamic isDeleted,
//     @JsonKey(name: "warning_price_usd") double? warningPriceUsd,
//     @JsonKey(name: "warning_market_cap") double? warningMarketCap,
//     @JsonKey(name: "current_price_usd") double? currentPriceUsd,
//     @JsonKey(name: "current_market_cap") double? currentMarketCap,
//     @JsonKey(name: "increase_rate") double? increaseRate,
//     IntelChain? chain,
//     @JsonKey(name: "stats") IntelStats? stats,
//     String? address,
//     dynamic? version,
//   }) = _Entity;

//   factory Entity.fromJson(Map<String, dynamic> json) => _$EntityFromJson(json);
// }

@freezed
class Entity with _$Entity {
  const factory Entity({
    String? id,
    @JsonKey(name: "entity_id") String? entityId,
    String? name,
    String? symbol,
    String? standard,
    int? decimals,
    @JsonKey(name: "contract_address") String? contractAddress,
    String? logo,
    @JsonKey(name: "stats") IntelStats? stats,
    @JsonKey(name: "chain") IntelChain? chain,
    @JsonKey(name: "created_at") DateTime? createdAt,
    @JsonKey(name: "updated_at") DateTime? updatedAt,
  }) = _Entity;

  factory Entity.fromJson(Map<String, dynamic> json) => _$EntityFromJson(json);
}
