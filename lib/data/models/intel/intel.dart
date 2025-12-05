import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../infrastructure/serialization/converters/dynamic_converter.dart';
import '../../../infrastructure/serialization/converters/naive_to_utc_dateTime_converter.dart';
import '../../../l10n/l10n.dart';
import '../../../shared/mixins/multilingual_content.dart';
import '../../../shared/presentation/extensions/datetime_extension.dart';
import '../../../shared/utils/json_converter/multilingual.dart';
import '../../../utils/validators/token_validator.dart';
import '../language/language.dart';

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
      return DateTime.fromMillisecondsSinceEpoch(
        value.toInt(),
        isUtc: true,
      ).toLocal();
    } catch (e) {
      return null;
    }
  }
  return null;
}

@freezed
sealed class IntelMessage with _$IntelMessage {
  const factory IntelMessage({String? type, Intel? data}) = _IntelMessage;

  factory IntelMessage.fromJson(Map<String, dynamic> json) =>
      _$IntelMessageFromJson(json);
}

// The main Intel data model
@freezed
sealed class Intel with _$Intel {
  const Intel._();

  @JsonSerializable(explicitToJson: true)
  const factory Intel({
    String? id,
    @JsonKey(name: 'published_at')
    @NaiveToUtcDateTimeConverter()
    DateTime? publishedAt,
    @JsonKey(name: 'created_at')
    @NaiveToUtcDateTimeConverter()
    DateTime? createdAt,
    @JsonKey(
      name: 'signal_tags',
      fromJson: multilingualListFromJson,
      toJson: multilingualListToJson,
    )
    @MultilingualListConverter()
    List<Multilingual>? signalTags,
    @JsonKey(name: 'updated_at')
    @NaiveToUtcDateTimeConverter()
    DateTime? updatedAt,
    @JsonKey(name: 'is_valuable') bool? isValuable,
    @JsonKey(name: 'token_keys') List<String>? tokenKeys,
    // @JsonKey(name: "is_published")
    @JsonKey(name: 'source_url') String? sourceUrl,
    @JsonKey(name: 'type') String? type,
    @MultilingualStringConverter() Multilingual? title,
    @MultilingualStringConverter() Multilingual? content,
    @JsonKey(name: 'extra_datas') IntelExtraDatas? extraDatas,
    List<IntelMedia>? medias,
    Analyzed? analyzed,
    // double? score,
    List<String>? tags,
    List<Entity>? entities,
    @JsonKey(name: 'news_logo') String? newsLogo,
    @JsonKey(name: 'news_title') Multilingual? newsTitle,
    @JsonKey(name: 'analyzed_time') double? analyzedTime,
    @JsonKey(name: 'monitor_time') double? monitorTime,
    @JsonKey(name: 'ai_agent') AIAgent? aiAgent,
    @JsonKey(name: 'author') Author? author,
  }) = _Intel;

  factory Intel.fromJson(Map<String, dynamic> json) => _$IntelFromJson(json);

  String publishedAtLocal(BuildContext context) {
    return publishedAt.fmt(context, pattern: 'HH:mm');
  }

  String createdAtLocal(BuildContext context) {
    return createdAt.fmt(context, pattern: 'HH:mm MM-dd');
  }

  String updatedAtLocal(BuildContext context) {
    return updatedAt.fmt(context, pattern: 'HH:mm MM-dd');
  }

  String alphaText(BuildContext context, String analyzed) {
    if (extraDatas?.isAlpha == false) {
      return analyzed;
    }

    final newTokenKeys = tokenKeys?.isNotEmpty ?? false
        ? tokenKeys?.join(',')
        : S.of(context).relatedToken;

    final newText = (entities?.length ?? 0) > 0
        ? analyzed
        : "$analyzed ${S.of(context).tokenNotTrading(newTokenKeys ?? '')}";

    return newText;
  }
}

@freezed
sealed class IntelExtraDatas with _$IntelExtraDatas {
  const factory IntelExtraDatas({
    @Default(false) @JsonKey(name: 'is_alpha') bool? isAlpha,
  }) = _IntelExtraDatas;

  factory IntelExtraDatas.fromJson(Map<String, dynamic> json) =>
      _$IntelExtraDatasFromJson(json);
}

@freezed
sealed class IntelStats with _$IntelStats {
  const factory IntelStats({
    @JsonKey(name: 'warning_price_usd', fromJson: _stringFromDynamic)
    String? warningPriceUsd,
    @JsonKey(name: 'warning_market_cap', fromJson: _stringFromDynamic)
    String? warningMarketCap,
    @JsonKey(name: 'current_price_usd', fromJson: _stringFromDynamic)
    String? currentPriceUsd,
    @JsonKey(name: 'current_market_cap', fromJson: _stringFromDynamic)
    String? currentMarketCap,
    @JsonKey(name: 'increase_rate', fromJson: _stringFromDynamic)
    String? increaseRate,
    @JsonKey(name: 'highest_increase_rate', fromJson: _stringFromDynamic)
    String? heighestIncreaseRate,
    @JsonKey(name: 'highest_decrease_rate', fromJson: _stringFromDynamic)
    String? highestDecreaseRate,
  }) = _IntelStats;

  factory IntelStats.fromJson(Map<String, dynamic> json) =>
      _$IntelStatsFromJson(json);
}

@freezed
sealed class AIAgent with _$AIAgent {
  const factory AIAgent({Map<String, String>? name, String? avatar}) = _AIAgent;

  factory AIAgent.fromJson(Map<String, dynamic> json) =>
      _$AIAgentFromJson(json);
}

@freezed
sealed class Author with _$Author {
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
sealed class IntelPlatform with _$IntelPlatform {
  const factory IntelPlatform({String? name, String? id, String? logo}) =
      _IntelPlatform;

  factory IntelPlatform.fromJson(Map<String, dynamic> json) =>
      _$IntelPlatformFromJson(json);
}

@freezed
sealed class IntelMedia with _$IntelMedia {
  const factory IntelMedia({String? url, @JsonKey(name: 'type') String? type}) =
      _IntelMedia;

  factory IntelMedia.fromJson(Map<String, dynamic> json) =>
      _$IntelMediaFromJson(json);
}

// Analyzed data model
@freezed
sealed class Analyzed with _$Analyzed, IMultilingualContent {
  const Analyzed._();

  const factory Analyzed({String? zh, String? en}) = _Analyzed;

  factory Analyzed.fromJson(Map<String, dynamic> json) =>
      _$AnalyzedFromJson(json);
}

@freezed
sealed class IntelChain with _$IntelChain {
  const factory IntelChain({
    String? name,
    String? id,
    String? address,
    String? logo,
    String? slug,
    @JsonKey(name: 'network_id') String? networkId,
  }) = _IntelChain;

  factory IntelChain.fromJson(Map<String, dynamic> json) =>
      _$IntelChainFromJson(json);
}

@freezed
sealed class Entity with _$Entity {
  const Entity._();

  const factory Entity({
    String? id,
    @JsonKey(name: 'entity_id') String? entityId,
    String? name,
    String? symbol,
    String? standard,
    int? decimals,
    @JsonKey(name: 'contract_address') String? contractAddress,
    String? logo,
    @JsonKey(name: 'stats') IntelStats? stats,
    @JsonKey(name: 'chain') IntelChain? chain,
    @JsonKey(name: 'created_at', fromJson: _dateTimeFromDynamic)
    DateTime? createdAt,
    @JsonKey(name: 'updated_at', fromJson: _dateTimeFromDynamic)
    DateTime? updatedAt,
    @DynamicDoubleConverter() @JsonKey(name: 'score') double? score,
    @JsonKey(name: 'is_native') bool? isNative,
  }) = _Entity;

  bool get isNativeToken {
    return isNative ?? TokenValidator.isNative(isNative ?? false);
  }

  bool get shouldShowAddress {
    return TokenValidator.shouldShowAddress(
      isNative ?? false,
      chain?.networkId ?? '',
    );
  }

  bool get shouldShowChainLogo {
    return TokenValidator.shouldShowChainLogo(chain?.slug, logo);
  }

  factory Entity.fromJson(Map<String, dynamic> json) => _$EntityFromJson(json);
}
