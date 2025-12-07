import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/language/language.dart';
import '../../../../infrastructure/serialization/converters/naive_to_utc_dateTime_converter.dart';
import '../../../../l10n/l10n.dart';
import '../../../../shared/presentation/extensions/datetime_extension.dart';
import '../../../../shared/utils/json_converter/multilingual.dart';
import '../../../../utils/language_utils.dart';
import 'ai_agent_model.dart';
import 'author_model.dart';
import 'entity_model.dart';
import 'extra_datas_model.dart';
import 'media_model.dart';

part 'intelligence_model.freezed.dart';
part 'intelligence_model.g.dart';

// The main Intel data model
@freezed
sealed class IntelligenceModel with _$IntelligenceModel {
  const IntelligenceModel._();

  @JsonSerializable(explicitToJson: true)
  const factory IntelligenceModel({
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
    @JsonKey(name: 'extra_datas') IntelligenceExtraDatasModel? extraDatas,
      List<IntelligenceMediaModel>? medias,
    Multilingual? analyzed,
    // double? score,
    List<String>? tags,
    List<IntelligenceEntityModel>? entities,
    @JsonKey(name: 'news_logo') String? newsLogo,
    @JsonKey(name: 'news_title') Multilingual? newsTitle,
    @JsonKey(name: 'analyzed_time') double? analyzedTime,
    @JsonKey(name: 'monitor_time') double? monitorTime,
    @JsonKey(name: 'ai_agent') IntelligenceAIAgentModel? aiAgent,
    @JsonKey(name: 'author') IntelligenceAuthorModel? author,
  }) = _IntelligenceModel;

  factory IntelligenceModel.fromJson(Map<String, dynamic> json) =>
      _$IntelligenceModelFromJson(json);

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

  String localAnalyze(BuildContext context) =>
      LanguageUtils.getContentByLanguage(context, analyzed);
}
