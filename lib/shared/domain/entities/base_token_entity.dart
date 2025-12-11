// lib/core/domain/entities/token_entity.dart

// import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../interfaces/i_base_token.dart';
import '../mixins/base_token_mixin.dart';

part 'base_token_entity.freezed.dart';

/// 核心 Token 实体
///
/// 这是最基础的 Token 实体，可以在整个应用中使用
/// 其他特定功能的 Token 实体应该在各自的 feature 中定义
@freezed
class BaseTokenEntity
    with _$BaseTokenEntity, BaseTokenMixin
    implements IBaseToken {
  @override
  final String chainId;
  @override
  final String chainLogo;
  @override
  final String chainName;
  @override
  final String network;
  @override
  final String tokenLogo;
  @override
  final String tokenName;
  @override
  final String symbol;
  @override
  final String address;
  @override
  final int decimals;
  @override
  final bool isNative;
  @override
  final String price;
  @override
  final String priceChange24h;
  @override
  final String marketCap;
  @override
  final String liquidity;
  @override
  final String volume24h;
  @override
  final String rawBalance;
  @override
  final String balance;

  @override
  final String? balanceUsd;
  @override
  final String? description;
  @override
  final DateTime? displayTime;
  @override
  final bool? isVerified;
  @override
  final String? standard;
  @override
  final String? type;
  @override
  final bool? isTop;

  const BaseTokenEntity({
    required this.chainId,
    required this.chainLogo,
    required this.chainName,
    required this.tokenLogo,
    required this.tokenName,
    required this.price,
    required this.symbol,
    required this.network,
    required this.address,
    required this.rawBalance,
    required this.balance,
    required this.decimals,
    required this.priceChange24h,
    required this.marketCap,
    required this.isNative,
    required this.liquidity,
    required this.volume24h,
    this.balanceUsd,
    this.description,
    this.displayTime,
    this.isVerified,
    this.standard,
    this.type,
    this.isTop,
  });

  /// 创建空对象
  factory BaseTokenEntity.empty() => BaseTokenEntity(
    chainId: '',
    chainLogo: '',
    chainName: '',
    tokenLogo: '',
    tokenName: '',
    price: '0',
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

  factory BaseTokenEntity.example() => BaseTokenEntity(
    chainId: '019782ba-521b-7b7a-b9f5-6fbbf89428ca',
    chainLogo: 'assets/chain/bsc.png',
    chainName: 'bsc',
    tokenLogo: 'image/tokens/019a8721-2de3-7918-8839-ccb30af3082e.webp',
    tokenName: '马到成功',
    price: '0.003892663996264399',
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
