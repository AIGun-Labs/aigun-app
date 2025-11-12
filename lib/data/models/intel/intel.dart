import 'package:flutter/foundation.dart';
import 'package:flutter_aigun/data/models/index.dart';
import 'package:flutter_aigun/shared/mixins/multilingual_content.dart';
import 'package:flutter_aigun/shared/utils/json_converter/multilingual.dart';
import 'package:flutter_aigun/shared/utils/json_converter/utc_to_local_datetime_converter.dart';
import 'package:flutter_aigun/utils/format/date.dart';
import 'package:flutter_aigun/utils/validators/token_validator.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'intel.freezed.dart';
part 'intel.g.dart';

String? _stringFromDynamic(dynamic value) {
  if (value == null) return null;
  if (value is String) return value;
  if (value is num) return value.toString();
  return value.toString();
}

DateTime? _dateTimeFromDynamic(dynamic value) {
  if (value == null) return null;
  if (value is DateTime) return value.toLocal();
  if (value is String) {
    if (value.isEmpty) return null;
    try {
      return DateTime.parse(value).toLocal();
    } catch (e) {
      return null;
    }
  }
  if (value is num) {
    try {
      return DateTime.fromMillisecondsSinceEpoch(value.toInt(), isUtc: true)
          .toLocal();
    } catch (e) {
      return null;
    }
  }
  return null;
}

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
  const Intel._();

  @JsonSerializable(explicitToJson: true)
  const factory Intel({
    String? id,
    @UtcToLocalDatetimeConverter()
    @JsonKey(name: 'published_at')
    DateTime? publishedAt,
    @UtcToLocalDatetimeConverter()
    @JsonKey(name: 'created_at')
    DateTime? createdAt,
    @JsonKey(
      name: "signal_tags",
      fromJson: multilingualListFromJson,
      toJson: multilingualListToJson,
    )
    @MultilingualListConverter()
    List<Multilingual>? signalTags,
    @JsonKey(name: 'updated_at')
    @UtcToLocalDatetimeConverter()
    DateTime? updatedAt,
    @JsonKey(name: 'is_valuable') bool? isValuable,
    @JsonKey(name: "token_keys") List<String>? tokenKeys,
    // @JsonKey(name: "is_published")
    @JsonKey(name: 'source_url') String? sourceUrl,
    @JsonKey(name: "type") String? type,
    String? title,
    String? content,
    @JsonKey(name: 'extra_datas') IntelExtraDatas? extraDatas,
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

  String get publishedAtLocal => publishedAt == null
      ? ""
      : DateUtilsHelper.formatUtcToLocal(publishedAt!, format: "HH:mm");

  String get createdAtLocal =>
      createdAt == null ? "" : DateUtilsHelper.formatUtcToLocal(createdAt!);

  String get updatedAtLocal =>
      updatedAt == null ? "" : DateUtilsHelper.formatUtcToLocal(updatedAt!);
}

@freezed
class IntelExtraDatas with _$IntelExtraDatas {
  const factory IntelExtraDatas({
    @Default(false) @JsonKey(name: "is_alpha") bool? isAlpha,
  }) = _IntelExtraDatas;

  factory IntelExtraDatas.fromJson(Map<String, dynamic> json) =>
      _$IntelExtraDatasFromJson(json);
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
    @JsonKey(name: "highest_decrease_rate", fromJson: _stringFromDynamic)
    String? highestDecreaseRate,
  }) = _IntelStats;

  factory IntelStats.fromJson(Map<String, dynamic> json) =>
      _$IntelStatsFromJson(json);
}

@freezed
class AIAgent with _$AIAgent {
  const factory AIAgent({
    Map<String, String>? name,
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
    @JsonKey(
      fromJson: multilingualStringFromJson,
      toJson: multilingualStringToJson,
    )
    @MultilingualStringConverter()
    Multilingual? prompt,
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
    @JsonKey(name: "type") String? type,
  }) = _IntelMedia;

  factory IntelMedia.fromJson(Map<String, dynamic> json) =>
      _$IntelMediaFromJson(json);
}

// Analyzed data model
@freezed
class Analyzed with _$Analyzed, IMultilingualContent {
  const Analyzed._();

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

@freezed
class Entity with _$Entity {
  const Entity._(); // 添加私有构造函数以支持自定义 getter

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
    @JsonKey(name: "created_at", fromJson: _dateTimeFromDynamic)
    DateTime? createdAt,
    @JsonKey(name: "updated_at", fromJson: _dateTimeFromDynamic)
    DateTime? updatedAt,
    @JsonKey(name: "is_native") bool? isNative,
  }) = _Entity;

  bool get isNativeToken {
    return TokenValidator.isNativeToken(contractAddress,
        network: chain?.slug ?? "");
  }

  factory Entity.fromJson(Map<String, dynamic> json) => _$EntityFromJson(json);
}
