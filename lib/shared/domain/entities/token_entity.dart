// lib/core/domain/entities/token_entity.dart

import 'package:freezed_annotation/freezed_annotation.dart';

import '../interfaces/i_token.dart';
import '../mixins/token_mixin.dart';

part 'token_entity.freezed.dart';

/// 核心 Token 实体
///
/// 这是最基础的 Token 实体，可以在整个应用中使用
/// 其他特定功能的 Token 实体应该在各自的 feature 中定义
@freezed
sealed class TokenEntity with _$TokenEntity, TokenMixin implements IToken {
  const TokenEntity._();

  const factory TokenEntity({
    required String chainId,
    required String chainLogo,
    required String chainName,
    required String tokenLogo,
    required String tokenName,
    required String tokenPrice,
    required String symbol,
    required String network,
    required String address,
    required String rawBalance,
    required String balance,
    required int decimals,
    required String priceChange24h,
    required String marketCap,
    required bool isNative,
    required String liquidity,
    required String volume24h,
  }) = _TokenEntity;

  /// 创建空对象
  factory TokenEntity.empty() => const TokenEntity(
    chainId: '',
    chainLogo: '',
    chainName: '',
    tokenLogo: '',
    tokenName: '',
    tokenPrice: '0',
    symbol: '',
    network: '',
    address: '',
    rawBalance: '0',
    balance: '0',
    decimals: 0,
    priceChange24h: '0',
    marketCap: '0',
    isNative: false,
    liquidity: '0',
    volume24h: '0',
  );

  factory TokenEntity.example() => const TokenEntity(
    chainId: '019782ba-521b-7b7a-b9f5-6fbbf89428ca',
    chainLogo: 'assets/chain/bsc.png',
    chainName: 'bsc',
    tokenLogo: 'image/tokens/019a8721-2de3-7918-8839-ccb30af3082e.webp',
    tokenName: '马到成功',
    tokenPrice: '0.003892663996264399',
    symbol: '马到成功',
    network: 'bsc',
    address: '0xe1e93e92c0c2aff2dc4d7d4a8b250d973cad4444',
    rawBalance: '0',
    balance: '0',
    decimals: 18,
    priceChange24h: '20.44',
    marketCap: '3892663.9844968603',
    isNative: false,
    liquidity: '0',
    volume24h: '0',
  );
}
