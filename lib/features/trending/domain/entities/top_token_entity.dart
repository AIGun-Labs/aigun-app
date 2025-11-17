import 'package:freezed_annotation/freezed_annotation.dart';

part 'top_token_entity.freezed.dart';

@freezed
class TopTokenEntity with _$TopTokenEntity {
  
  const factory TopTokenEntity({
    required String id,
    required String logo,
    required String symbol,
    required String name,
    required String marketCap,
    required String price,
    required String decimals,
    required String contractAddress,
    required String network,
    required String priceChange24h,
  }) = _TopTokenEntity;
}
