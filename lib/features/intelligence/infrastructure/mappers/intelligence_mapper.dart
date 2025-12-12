import '../../../../data/models/intel/intel.dart' as legacy;
import '../../domain/entities/ai_agent_entity.dart';
import '../../domain/entities/author_entity.dart';
import '../../domain/entities/chain_entity.dart';
import '../../domain/entities/extra_datas_entity.dart';
import '../../domain/entities/intelligence_entity.dart';
import '../../domain/entities/media_entity.dart';
import '../../domain/entities/platform_entity.dart';
import '../../domain/entities/stats_entity.dart';
import '../../domain/entities/token_entity.dart';
import '../models/ai_agent_model.dart';
import '../models/author_model.dart';
import '../models/chain_model.dart';
import '../models/entity_model.dart';
import '../models/extra_datas_model.dart';
import '../models/intelligence_model.dart';
import '../models/media_model.dart';
import '../models/platform_model.dart';
import '../models/stats_model.dart';

/// Intelligence Model to Entity Mapper
extension IntelligenceModelMapper on IntelligenceModel {
  /// Convert model to entity
  IntelligenceEntity toEntity() {
    return IntelligenceEntity(
      id: id ?? '',
      type: IntelligenceType.fromString(type),
      publishedAt: publishedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
      signalTags: signalTags,
      isValuable: isValuable,
      tokenKeys: tokenKeys,
      sourceUrl: sourceUrl,
      title: title,
      content: content,
      extraDatas: extraDatas?.toEntity(),
      medias: medias?.map((m) => m.toEntity()).toList(),
      analyzed: analyzed,
      tags: tags,
      tokens: entities?.map((e) => e.toEntity()).toList(),
      newsLogo: newsLogo,
      newsTitle: newsTitle,
      analyzedTime: analyzedTime,
      monitorTime: monitorTime,
      aiAgent: aiAgent?.toEntity(),
      author: author?.toEntity(),
    );
  }
}

/// Extra Datas Model to Entity Mapper
extension ExtraDatasModelMapper on IntelligenceExtraDatasModel {
  ExtraDatasEntity toEntity() {
    return ExtraDatasEntity(
      isAlpha: isAlpha ?? false,
      repostContent: repostContent,
    );
  }
}

/// Media Model to Entity Mapper
extension MediaModelMapper on IntelligenceMediaModel {
  MediaEntity toEntity() {
    return MediaEntity(
      url: url,
      type: MediaType.fromString(type),
    );
  }
}

/// AI Agent Model to Entity Mapper
extension AIAgentModelMapper on IntelligenceAIAgentModel {
  AIAgentEntity toEntity() {
    return AIAgentEntity(
      name: name,
      avatar: avatar,
    );
  }
}

/// Author Model to Entity Mapper
extension AuthorModelMapper on IntelligenceAuthorModel {
  AuthorEntity toEntity() {
    return AuthorEntity(
      avatar: avatar,
      slug: slug,
      platform: platform?.toEntity(),
      prompt: prompt,
    );
  }
}

/// Platform Model to Entity Mapper
extension PlatformModelMapper on IntelligencePlatformModel {
  PlatformEntity toEntity() {
    return PlatformEntity(
      name: name,
      id: id,
      logo: logo,
    );
  }
}

/// Token/Entity Model to Entity Mapper
extension TokenModelMapper on IntelligenceEntityModel {
  TokenEntity toEntity() {
    return TokenEntity(
      id: id,
      entityId: entityId,
      name: name,
      symbol: symbol,
      standard: standard,
      decimals: decimals,
      contractAddress: contractAddress,
      logo: logo,
      stats: stats?.toEntity(),
      chain: chain?.toEntity(),
      createdAt: createdAt,
      updatedAt: updatedAt,
      score: score,
      isNative: isNative ?? false,
    );
  }
}

/// Stats Model to Entity Mapper
extension StatsModelMapper on IntelligenceStatsModel {
  StatsEntity toEntity() {
    return StatsEntity(
      warningPriceUsd: warningPriceUsd,
      warningMarketCap: warningMarketCap,
      currentPriceUsd: currentPriceUsd,
      currentMarketCap: currentMarketCap,
      increaseRate: increaseRate,
      highestIncreaseRate: heighestIncreaseRate,
      highestDecreaseRate: highestDecreaseRate,
    );
  }
}

/// Chain Model to Entity Mapper
extension ChainModelMapper on IntelligenceChainModel {
  ChainEntity toEntity() {
    return ChainEntity(
      name: name,
      id: id,
      address: address,
      logo: logo,
      slug: slug,
      networkId: networkId,
    );
  }
}

// =============================================================================
// REVERSE MAPPING: Entity to Legacy Intel Model
// =============================================================================
// These mappers are used during the migration period to convert domain entities
// back to legacy models for rendering with existing widgets.
// TODO: Remove these once all widgets are migrated to use entities directly.

/// Intelligence Entity to Legacy Intel Mapper
extension IntelligenceEntityToLegacyMapper on IntelligenceEntity {
  /// Convert entity to legacy Intel model for rendering
  legacy.Intel toLegacyModel() {
    return legacy.Intel(
      id: id,
      type: type.value,
      publishedAt: publishedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
      signalTags: signalTags,
      isValuable: isValuable,
      tokenKeys: tokenKeys,
      sourceUrl: sourceUrl,
      title: title,
      content: content,
      extraDatas: extraDatas?.toLegacyModel(),
      medias: medias?.map((m) => m.toLegacyModel()).toList(),
      analyzed: analyzed,
      tags: tags,
      entities: tokens?.map((t) => t.toLegacyModel()).toList(),
      newsLogo: newsLogo,
      newsTitle: newsTitle,
      analyzedTime: analyzedTime,
      monitorTime: monitorTime,
      aiAgent: aiAgent?.toLegacyModel(),
      author: author?.toLegacyModel(),
    );
  }
}

/// Extra Datas Entity to Legacy Mapper
extension ExtraDatasEntityToLegacyMapper on ExtraDatasEntity {
  legacy.IntelExtraDatas toLegacyModel() {
    return legacy.IntelExtraDatas(
      isAlpha: isAlpha,
      repostContent: repostContent,
    );
  }
}

/// Media Entity to Legacy Mapper
extension MediaEntityToLegacyMapper on MediaEntity {
  legacy.IntelMedia toLegacyModel() {
    return legacy.IntelMedia(
      url: url,
      type: type.value,
    );
  }
}

/// AI Agent Entity to Legacy Mapper
extension AIAgentEntityToLegacyMapper on AIAgentEntity {
  legacy.AIAgent toLegacyModel() {
    return legacy.AIAgent(
      name: name,
      avatar: avatar,
    );
  }
}

/// Author Entity to Legacy Mapper
extension AuthorEntityToLegacyMapper on AuthorEntity {
  legacy.Author toLegacyModel() {
    return legacy.Author(
      avatar: avatar,
      slug: slug,
      platform: platform?.toLegacyModel(),
      prompt: prompt,
    );
  }
}

/// Platform Entity to Legacy Mapper
extension PlatformEntityToLegacyMapper on PlatformEntity {
  legacy.IntelPlatform toLegacyModel() {
    return legacy.IntelPlatform(
      name: name,
      id: id,
      logo: logo,
    );
  }
}

/// Token Entity to Legacy Entity Mapper
extension TokenEntityToLegacyMapper on TokenEntity {
  legacy.Entity toLegacyModel() {
    return legacy.Entity(
      id: id,
      entityId: entityId,
      name: name,
      symbol: symbol,
      standard: standard,
      decimals: decimals,
      contractAddress: contractAddress,
      logo: logo,
      stats: stats?.toLegacyModel(),
      chain: chain?.toLegacyModel(),
      createdAt: createdAt,
      updatedAt: updatedAt,
      score: score,
      isNative: isNative,
    );
  }
}

/// Stats Entity to Legacy Mapper
extension StatsEntityToLegacyMapper on StatsEntity {
  legacy.IntelStats toLegacyModel() {
    return legacy.IntelStats(
      warningPriceUsd: warningPriceUsd,
      warningMarketCap: warningMarketCap,
      currentPriceUsd: currentPriceUsd,
      currentMarketCap: currentMarketCap,
      increaseRate: increaseRate,
      heighestIncreaseRate: highestIncreaseRate,
      highestDecreaseRate: highestDecreaseRate,
    );
  }
}

/// Chain Entity to Legacy Mapper
extension ChainEntityToLegacyMapper on ChainEntity {
  legacy.IntelChain toLegacyModel() {
    return legacy.IntelChain(
      name: name,
      id: id,
      address: address,
      logo: logo,
      slug: slug,
      networkId: networkId,
    );
  }
}
