// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IntelMessageImpl _$$IntelMessageImplFromJson(Map<String, dynamic> json) =>
    _$IntelMessageImpl(
      type: json['type'] as String?,
      data: json['data'] == null
          ? null
          : Intel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$IntelMessageImplToJson(_$IntelMessageImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'data': instance.data,
    };

_$IntelImpl _$$IntelImplFromJson(Map<String, dynamic> json) => _$IntelImpl(
      id: json['id'] as String?,
      isAlpha: json['is_alpha'] as bool?,
      publishedAt: _dateTimeFromDynamic(json['published_at']),
      createdAt: _dateTimeFromDynamic(json['created_at']),
      signalTags: (json['signal_tags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      updatedAt: _dateTimeFromDynamic(json['updated_at']),
      isValuable: json['is_valuable'] as bool?,
      sourceUrl: json['source_url'] as String?,
      type: json['type'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      extraDatas: json['extra_datas'] as Map<String, dynamic>?,
      medias: (json['medias'] as List<dynamic>?)
          ?.map((e) => IntelMedia.fromJson(e as Map<String, dynamic>))
          .toList(),
      analyzed: json['analyzed'] == null
          ? null
          : Analyzed.fromJson(json['analyzed'] as Map<String, dynamic>),
      score: (json['score'] as num?)?.toDouble(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      entities: (json['entities'] as List<dynamic>?)
          ?.map((e) => Entity.fromJson(e as Map<String, dynamic>))
          .toList(),
      analyzedTime: (json['analyzed_time'] as num?)?.toDouble(),
      monitorTime: (json['monitor_time'] as num?)?.toDouble(),
      aiAgent: json['ai_agent'] == null
          ? null
          : AIAgent.fromJson(json['ai_agent'] as Map<String, dynamic>),
      author: json['author'] == null
          ? null
          : Author.fromJson(json['author'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$IntelImplToJson(_$IntelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'is_alpha': instance.isAlpha,
      'published_at': instance.publishedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'signal_tags': instance.signalTags,
      'updated_at': instance.updatedAt?.toIso8601String(),
      'is_valuable': instance.isValuable,
      'source_url': instance.sourceUrl,
      'type': instance.type,
      'title': instance.title,
      'content': instance.content,
      'extra_datas': instance.extraDatas,
      'medias': instance.medias?.map((e) => e.toJson()).toList(),
      'analyzed': instance.analyzed?.toJson(),
      'score': instance.score,
      'tags': instance.tags,
      'entities': instance.entities?.map((e) => e.toJson()).toList(),
      'analyzed_time': instance.analyzedTime,
      'monitor_time': instance.monitorTime,
      'ai_agent': instance.aiAgent?.toJson(),
      'author': instance.author?.toJson(),
    };

_$IntelStatsImpl _$$IntelStatsImplFromJson(Map<String, dynamic> json) =>
    _$IntelStatsImpl(
      warningPriceUsd: _stringFromDynamic(json['warning_price_usd']),
      warningMarketCap: _stringFromDynamic(json['warning_market_cap']),
      currentPriceUsd: _stringFromDynamic(json['current_price_usd']),
      currentMarketCap: _stringFromDynamic(json['current_market_cap']),
      increaseRate: _stringFromDynamic(json['increase_rate']),
      heighestIncreaseRate: _stringFromDynamic(json['highest_increase_rate']),
    );

Map<String, dynamic> _$$IntelStatsImplToJson(_$IntelStatsImpl instance) =>
    <String, dynamic>{
      'warning_price_usd': instance.warningPriceUsd,
      'warning_market_cap': instance.warningMarketCap,
      'current_price_usd': instance.currentPriceUsd,
      'current_market_cap': instance.currentMarketCap,
      'increase_rate': instance.increaseRate,
      'highest_increase_rate': instance.heighestIncreaseRate,
    };

_$AIAgentImpl _$$AIAgentImplFromJson(Map<String, dynamic> json) =>
    _$AIAgentImpl(
      name: (json['name'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$$AIAgentImplToJson(_$AIAgentImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'avatar': instance.avatar,
    };

_$AuthorImpl _$$AuthorImplFromJson(Map<String, dynamic> json) => _$AuthorImpl(
      avatar: json['avatar'] as String?,
      slug: json['slug'] as String?,
      platform: json['platform'] == null
          ? null
          : IntelPlatform.fromJson(json['platform'] as Map<String, dynamic>),
      prompt: json['prompt'] as String?,
    );

Map<String, dynamic> _$$AuthorImplToJson(_$AuthorImpl instance) =>
    <String, dynamic>{
      'avatar': instance.avatar,
      'slug': instance.slug,
      'platform': instance.platform,
      'prompt': instance.prompt,
    };

_$IntelPlatformImpl _$$IntelPlatformImplFromJson(Map<String, dynamic> json) =>
    _$IntelPlatformImpl(
      name: json['name'] as String?,
      id: json['id'] as String?,
      logo: json['logo'] as String?,
    );

Map<String, dynamic> _$$IntelPlatformImplToJson(_$IntelPlatformImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'logo': instance.logo,
    };

_$IntelMediaImpl _$$IntelMediaImplFromJson(Map<String, dynamic> json) =>
    _$IntelMediaImpl(
      url: json['url'] as String?,
      type: $enumDecodeNullable(_$MediaTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$$IntelMediaImplToJson(_$IntelMediaImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'type': _$MediaTypeEnumMap[instance.type],
    };

const _$MediaTypeEnumMap = {
  MediaType.image: 'image',
  MediaType.video: 'video',
};

_$AnalyzedImpl _$$AnalyzedImplFromJson(Map<String, dynamic> json) =>
    _$AnalyzedImpl(
      zh: json['zh'] as String?,
      en: json['en'] as String?,
    );

Map<String, dynamic> _$$AnalyzedImplToJson(_$AnalyzedImpl instance) =>
    <String, dynamic>{
      'zh': instance.zh,
      'en': instance.en,
    };

_$IntelChainImpl _$$IntelChainImplFromJson(Map<String, dynamic> json) =>
    _$IntelChainImpl(
      name: json['name'] as String?,
      id: json['id'] as String?,
      address: json['address'] as String?,
      logo: json['logo'] as String?,
      slug: json['slug'] as String?,
      networkId: json['network_id'] as String?,
    );

Map<String, dynamic> _$$IntelChainImplToJson(_$IntelChainImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'address': instance.address,
      'logo': instance.logo,
      'slug': instance.slug,
      'network_id': instance.networkId,
    };

_$EntityImpl _$$EntityImplFromJson(Map<String, dynamic> json) => _$EntityImpl(
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
      isNative: json['is_native'] as bool?,
    );

Map<String, dynamic> _$$EntityImplToJson(_$EntityImpl instance) =>
    <String, dynamic>{
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
      'is_native': instance.isNative,
    };
