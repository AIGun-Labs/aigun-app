import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/domain/entities/token_entity.dart';
import '../../../../shared/domain/interfaces/i_token.dart';
import '../../../../shared/domain/mixins/token_mixin.dart';

part 'top_token_entity.freezed.dart';

@Freezed()
class TopTokenExtra with _$TopTokenExtra {
  @override
  final String? id;
  final DateTime? displayTime;

  const TopTokenExtra({this.id = '', this.displayTime});
}

typedef TopTokenEntity = TokenEntity<TopTokenExtra>;

// @freezed
// sealed class TopTokenEntity
//     with _$TopTokenEntity, TokenMixin
//     implements IToken {
//   const TopTokenEntity._();

//   const factory TopTokenEntity({
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
//     @Default('') String id,
//     required DateTime displayTime,
//   }) = _TopTokenEntity;
// }
