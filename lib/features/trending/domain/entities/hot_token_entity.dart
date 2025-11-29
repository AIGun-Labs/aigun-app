import 'package:freezed_annotation/freezed_annotation.dart';

part 'hot_token_entity.freezed.dart';

@freezed
sealed class HotTokenEntity with _$HotTokenEntity {
  const factory HotTokenEntity({
    required String name,
    required String symbol,
    required String logo,
    required String marketCap,
    required String decimals,
    required String price,
    required String contractAddress,
    required String chainId,
    required String chainName,
    required String chainLogo,
    required String network,
    required String slug,
    required String chainIndex,
  }) = _HotTokenEntity;
}
