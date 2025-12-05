import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/domain/entities/token_entity.dart';

part 'collect_token_entity.freezed.dart';

@Freezed()
class CollectTokenExtra with _$CollectTokenExtra {
  @override
  final bool? isTop;

  const CollectTokenExtra({this.isTop = false});
}

typedef CollectTokenEntity = TokenEntity<CollectTokenExtra>;

// @freezed
// sealed class CollectTokenEntity
//     with _$CollectTokenEntity, TokenMixin
//     implements IToken {
//   // 添加私有构造函数
//   const CollectTokenEntity._();

//   const factory CollectTokenEntity({
//     required String chainId,
//     required String chainLogo,
//     required String chainName,
//     required String tokenLogo,
//     required String tokenName,
//     required String tokenPrice,
//     required String symbol,
//     required String network,
//     required String address,
//     required String rawBalance,
//     required String balance,
//     required int decimals,
//     required String priceChange24h,
//     required String marketCap,
//     required bool isNative,
//     required String liquidity,
//     required String volume24h,
//     @Default(false) bool isTop,
//   }) = _CollectTokenEntity;
// }
