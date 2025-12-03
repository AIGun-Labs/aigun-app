import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/query_token_entity.dart';

part 'query_token_model.freezed.dart';
part 'query_token_model.g.dart';

@freezed
sealed class QueryTokenModel with _$QueryTokenModel {
  const QueryTokenModel._();
  const factory QueryTokenModel({
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'symbol') String? symbol,
    @JsonKey(name: 'address') String? address,
    @JsonKey(name: 'network') String? network,
    @JsonKey(name: 'network_id') int? networkId,
    @JsonKey(name: 'network_name') String? networkName,
    @JsonKey(name: 'is_internal') @Default(false) bool? isInternal,
    @JsonKey(name: 'logo') String? logo,
    @JsonKey(name: 'market_cap') String? marketCap,
    @JsonKey(name: 'price_usd') String? priceUsd,
    @JsonKey(name: 'decimals') int? decimals,
    @JsonKey(name: 'network_logo') String? networkLogo,
    @JsonKey(name: 'volume_24h') String? volume24h,
    @JsonKey(name: 'liquidity') String? liquidity,
    @JsonKey(name: 'price_change_24h') String? priceChange24h,
    @JsonKey(name: 'is_native') @Default(false) bool? isNative,
    @JsonKey(name: 'is_mainstream') bool? isMainstream,
    @JsonKey(name: 'balance') String? balance,
    @JsonKey(name: 'raw_balance') String? rawBalance,
    @JsonKey(name: 'balance_usd') double? balanceUsd,
  }) = _QueryTokenModel;

  factory QueryTokenModel.fromJson(Map<String, dynamic> json) =>
      _$QueryTokenModelFromJson(json);

  QueryTokenEntity toEntity() => QueryTokenEntity(
    networkId: networkId ?? 0,
    networkLogo: logo ?? '',
    networkName: networkName ?? '',
    logo: logo ?? '',
    name: name ?? '',
    priceUsd: priceUsd ?? '',
    symbol: symbol ?? '',
    network: network ?? '',
    address: address ?? '',
    rawBalance: rawBalance ?? '',
    balance: balance ?? '',
    decimals: decimals ?? 0,
    priceChange24h: priceChange24h ?? '',
    marketCap: marketCap ?? '',
    isNative: isNative ?? false,
    isInternal: isInternal ?? false,
    isMainstream: isMainstream,
    volume24h: volume24h,
    liquidity: liquidity,
    balanceUsd: balanceUsd,
  );
}
