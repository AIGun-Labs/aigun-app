import 'package:freezed_annotation/freezed_annotation.dart';

part 'query_token_entity.freezed.dart';

@freezed
sealed class QueryTokenEntity with _$QueryTokenEntity {
  const factory QueryTokenEntity({
    required String name,
    required String symbol,
    required String address,
    required String network,
    required String logo,
    required String networkLogo,
    required int decimals,
    required bool isNative,
    required bool isInternal,
    required String networkName,
    required int networkId,
    String? marketCap,
    String? priceUsd,
    String? volume24h,
    String? liquidity,
    String? priceChange24h,
    bool? isMainstream,
    String? balance,
    String? rawBalance,
    double? balanceUsd,
  }) = _QueryTokenEntity;
}
