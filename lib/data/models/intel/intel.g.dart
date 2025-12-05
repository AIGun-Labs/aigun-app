// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IntelMessage _$IntelMessageFromJson(Map<String, dynamic> json) =>
    _IntelMessage(
      type: json['type'] as String?,
      data: json['data'] == null
          ? null
          : Intel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IntelMessageToJson(_IntelMessage instance) =>
    <String, dynamic>{'type': instance.type, 'data': instance.data};

_Intel _$IntelFromJson(Map<String, dynamic> json) => _Intel(
  id: json['id'] as String?,
  publishedAt: const NaiveToUtcDateTimeConverter().fromJson(
    json['published_at'],
  ),
  createdAt: const NaiveToUtcDateTimeConverter().fromJson(json['created_at']),
  signalTags: multilingualListFromJson(json['signal_tags']),
  updatedAt: const NaiveToUtcDateTimeConverter().fromJson(json['updated_at']),
  isValuable: json['is_valuable'] as bool?,
  tokenKeys: (json['token_keys'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  sourceUrl: json['source_url'] as String?,
  type: json['type'] as String?,
  title: const MultilingualStringConverter().fromJson(json['title']),
  content: const MultilingualStringConverter().fromJson(json['content']),
  extraDatas: json['extra_datas'] == null
      ? null
      : IntelExtraDatas.fromJson(json['extra_datas'] as Map<String, dynamic>),
  medias: (json['medias'] as List<dynamic>?)
      ?.map((e) => IntelMedia.fromJson(e as Map<String, dynamic>))
      .toList(),
  analyzed: json['analyzed'] == null
      ? null
      : Analyzed.fromJson(json['analyzed'] as Map<String, dynamic>),
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  entities: (json['entities'] as List<dynamic>?)
      ?.map((e) => Entity.fromJson(e as Map<String, dynamic>))
      .toList(),
  newsLogo: json['news_logo'] as String?,
  newsTitle: json['news_title'] == null
      ? null
      : Multilingual.fromJson(json['news_title'] as Map<String, dynamic>),
  analyzedTime: (json['analyzed_time'] as num?)?.toDouble(),
  monitorTime: (json['monitor_time'] as num?)?.toDouble(),
  aiAgent: json['ai_agent'] == null
      ? null
      : AIAgent.fromJson(json['ai_agent'] as Map<String, dynamic>),
  author: json['author'] == null
      ? null
      : Author.fromJson(json['author'] as Map<String, dynamic>),
);

Map<String, dynamic> _$IntelToJson(_Intel instance) => <String, dynamic>{
  'id': instance.id,
  'published_at': _$JsonConverterToJson<Object?, DateTime>(
    instance.publishedAt,
    const NaiveToUtcDateTimeConverter().toJson,
  ),
  'created_at': _$JsonConverterToJson<Object?, DateTime>(
    instance.createdAt,
    const NaiveToUtcDateTimeConverter().toJson,
  ),
  'signal_tags': multilingualListToJson(instance.signalTags),
  'updated_at': _$JsonConverterToJson<Object?, DateTime>(
    instance.updatedAt,
    const NaiveToUtcDateTimeConverter().toJson,
  ),
  'is_valuable': instance.isValuable,
  'token_keys': instance.tokenKeys,
  'source_url': instance.sourceUrl,
  'type': instance.type,
  'title': const MultilingualStringConverter().toJson(instance.title),
  'content': const MultilingualStringConverter().toJson(instance.content),
  'extra_datas': instance.extraDatas?.toJson(),
  'medias': instance.medias?.map((e) => e.toJson()).toList(),
  'analyzed': instance.analyzed?.toJson(),
  'tags': instance.tags,
  'entities': instance.entities?.map((e) => e.toJson()).toList(),
  'news_logo': instance.newsLogo,
  'news_title': instance.newsTitle?.toJson(),
  'analyzed_time': instance.analyzedTime,
  'monitor_time': instance.monitorTime,
  'ai_agent': instance.aiAgent?.toJson(),
  'author': instance.author?.toJson(),
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);

_IntelExtraDatas _$IntelExtraDatasFromJson(Map<String, dynamic> json) =>
    _IntelExtraDatas(isAlpha: json['is_alpha'] as bool? ?? false);

Map<String, dynamic> _$IntelExtraDatasToJson(_IntelExtraDatas instance) =>
    <String, dynamic>{'is_alpha': instance.isAlpha};

_IntelStats _$IntelStatsFromJson(Map<String, dynamic> json) => _IntelStats(
  warningPriceUsd: _stringFromDynamic(json['warning_price_usd']),
  warningMarketCap: _stringFromDynamic(json['warning_market_cap']),
  currentPriceUsd: _stringFromDynamic(json['current_price_usd']),
  currentMarketCap: _stringFromDynamic(json['current_market_cap']),
  increaseRate: _stringFromDynamic(json['increase_rate']),
  heighestIncreaseRate: _stringFromDynamic(json['highest_increase_rate']),
  highestDecreaseRate: _stringFromDynamic(json['highest_decrease_rate']),
);

Map<String, dynamic> _$IntelStatsToJson(_IntelStats instance) =>
    <String, dynamic>{
      'warning_price_usd': instance.warningPriceUsd,
      'warning_market_cap': instance.warningMarketCap,
      'current_price_usd': instance.currentPriceUsd,
      'current_market_cap': instance.currentMarketCap,
      'increase_rate': instance.increaseRate,
      'highest_increase_rate': instance.heighestIncreaseRate,
      'highest_decrease_rate': instance.highestDecreaseRate,
    };

_AIAgent _$AIAgentFromJson(Map<String, dynamic> json) => _AIAgent(
  name: (json['name'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
  avatar: json['avatar'] as String?,
);

Map<String, dynamic> _$AIAgentToJson(_AIAgent instance) => <String, dynamic>{
  'name': instance.name,
  'avatar': instance.avatar,
};

_Author _$AuthorFromJson(Map<String, dynamic> json) => _Author(
  avatar: json['avatar'] as String?,
  slug: json['slug'] as String?,
  platform: json['platform'] == null
      ? null
      : IntelPlatform.fromJson(json['platform'] as Map<String, dynamic>),
  prompt: multilingualStringFromJson(json['prompt']),
);

Map<String, dynamic> _$AuthorToJson(_Author instance) => <String, dynamic>{
  'avatar': instance.avatar,
  'slug': instance.slug,
  'platform': instance.platform,
  'prompt': multilingualStringToJson(instance.prompt),
};

_IntelPlatform _$IntelPlatformFromJson(Map<String, dynamic> json) =>
    _IntelPlatform(
      name: json['name'] as String?,
      id: json['id'] as String?,
      logo: json['logo'] as String?,
    );

Map<String, dynamic> _$IntelPlatformToJson(_IntelPlatform instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'logo': instance.logo,
    };

_IntelMedia _$IntelMediaFromJson(Map<String, dynamic> json) =>
    _IntelMedia(url: json['url'] as String?, type: json['type'] as String?);

Map<String, dynamic> _$IntelMediaToJson(_IntelMedia instance) =>
    <String, dynamic>{'url': instance.url, 'type': instance.type};

_Analyzed _$AnalyzedFromJson(Map<String, dynamic> json) =>
    _Analyzed(zh: json['zh'] as String?, en: json['en'] as String?);

Map<String, dynamic> _$AnalyzedToJson(_Analyzed instance) => <String, dynamic>{
  'zh': instance.zh,
  'en': instance.en,
};

_IntelChain _$IntelChainFromJson(Map<String, dynamic> json) => _IntelChain(
  name: json['name'] as String?,
  id: json['id'] as String?,
  address: json['address'] as String?,
  logo: json['logo'] as String?,
  slug: json['slug'] as String?,
  networkId: json['network_id'] as String?,
);

Map<String, dynamic> _$IntelChainToJson(_IntelChain instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'address': instance.address,
      'logo': instance.logo,
      'slug': instance.slug,
      'network_id': instance.networkId,
    };

_Entity _$EntityFromJson(Map<String, dynamic> json) => _Entity(
  id: json['id'] as String?,
  entityId: json['entity_id'] as String?,
  name: json['name'] as String?,
  symbol: json['symbol'] as String?,
  standard: json['standard'] as String?,
  decimals: (json['decimals'] as num?)?.toInt(),
  contractAddress: json['contract_address'] as String?,
  logo: json['logo'] as String?,
  stats: json['stats'] == null
      ? null
      : IntelStats.fromJson(json['stats'] as Map<String, dynamic>),
  chain: json['chain'] == null
      ? null
      : IntelChain.fromJson(json['chain'] as Map<String, dynamic>),
  createdAt: _dateTimeFromDynamic(json['created_at']),
  updatedAt: _dateTimeFromDynamic(json['updated_at']),
  score: const DynamicDoubleConverter().fromJson(json['score']),
  isNative: json['is_native'] as bool?,
);

Map<String, dynamic> _$EntityToJson(_Entity instance) => <String, dynamic>{
  'id': instance.id,
  'entity_id': instance.entityId,
  'name': instance.name,
  'symbol': instance.symbol,
  'standard': instance.standard,
  'decimals': instance.decimals,
  'contract_address': instance.contractAddress,
  'logo': instance.logo,
  'stats': instance.stats,
  'chain': instance.chain,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
  'score': const DynamicDoubleConverter().toJson(instance.score),
  'is_native': instance.isNative,
};
