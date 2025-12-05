// lib/core/domain/entities/token_entity.dart

import 'package:freezed_annotation/freezed_annotation.dart';

import '../interfaces/i_token.dart';
import '../mixins/token_mixin.dart';

part 'token_entity.freezed.dart';

///

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
  }) = _TokenEntity;

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
  );
}
