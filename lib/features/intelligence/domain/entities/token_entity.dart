import 'package:freezed_annotation/freezed_annotation.dart';

import 'chain_entity.dart';
import 'stats_entity.dart';

part 'token_entity.freezed.dart';

/// Token Entity - Represents a token/entity in intelligence
///
/// This entity contains token information associated with intelligence data.
@freezed
sealed class TokenEntity with _$TokenEntity {
  const TokenEntity._();

  const factory TokenEntity({
    String? id,
    String? entityId,
    String? name,
    String? symbol,
    String? standard,
    int? decimals,
    String? contractAddress,
    String? logo,
    StatsEntity? stats,
    ChainEntity? chain,
    DateTime? createdAt,
    DateTime? updatedAt,
    double? score,
    @Default(false) bool isNative,
  }) = _TokenEntity;

  /// Check if this is a native token
  bool get isNativeToken => isNative;

  /// Check if address should be displayed
  bool get shouldShowAddress {
    if (isNative) return false;
    final networkId = chain?.networkId ?? '';
    // Native tokens on certain networks don't show address
    return networkId.isNotEmpty;
  }

  /// Check if chain logo should be displayed
  bool get shouldShowChainLogo {
    final chainSlug = chain?.slug;
    if (chainSlug == null || chainSlug.isEmpty) return false;
    if (logo == null || logo!.isEmpty) return true;
    return true;
  }

  /// Get display name (symbol or name)
  String get displayName => symbol ?? name ?? 'Unknown';

  /// Get formatted contract address (shortened)
  String get shortAddress {
    if (contractAddress == null || contractAddress!.length < 10) {
      return contractAddress ?? '';
    }
    return '${contractAddress!.substring(0, 6)}...${contractAddress!.substring(contractAddress!.length - 4)}';
  }
}
