import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/language/language.dart';
import '../../../../shared/domain/entities/token_entity.dart';
import '../../../../utils/format/profit.dart';

part 'token_info_entity.freezed.dart';

@Freezed()
class TokenInfoExtra with _$TokenInfoExtra {
  @override
  final String holders;

  @override
  final String highestIncreaseRate;

  @override
  final bool isMainstream;

  @override
  final Multilingual? narrative;

  const TokenInfoExtra({
    required this.holders,
    required this.highestIncreaseRate,
    required this.isMainstream,
    required this.narrative,
  });
}

typedef TokenInfoEntity = TokenEntity<TokenInfoExtra>;

extension TokenInfoEntityX on TokenEntity {
  String get hodlersValue {
    final extra = this.extra as TokenInfoExtra?;
    if (extra == null) return '0';
    final holdersStr = extra.holders;
    final isMainstream = extra.isMainstream;

    if (isMainstream && (int.tryParse(holdersStr) ?? 0) == 0) {
      return '--';
    }
    return holdersStr;
  }

  String get increaserate {
    final extra = this.extra as TokenInfoExtra?;
    if (extra == null) return ProfitFormatter.format('0');
    final parsed = extra.highestIncreaseRate.replaceAll('%', '');
    return ProfitFormatter.format(parsed);
  }
}

// @freezed
// class TokenInfoEntity with _$TokenInfoEntity, TokenMixin implements IToken {
//   @override
//   final String chainId;
//   @override
//   final String chainLogo;
//   @override
//   final String chainName;
//   @override
//   final String network;
//   @override
//   final String tokenLogo;
//   @override
//   final String tokenName;
//   @override
//   final String symbol;
//   @override
//   final String address;
//   @override
//   final int decimals;
//   @override
//   final bool isNative;
//   @override
//   final String tokenPrice;
//   @override
//   final String priceChange24h;
//   @override
//   final String marketCap;
//   @override
//   final String liquidity;
//   @override
//   final String volume24h;
//   @override
//   final String rawBalance;
//   @override
//   final String balance;

//   @override
//   final String holders;

//   @override
//   final String highestIncreaseRate;

//   @override
//   final bool isMainstream;

//   @override
//   final Multilingual? narrative;

//   const TokenInfoEntity({
//     required this.network,
//     required this.rawBalance,
//     required this.balance,
//     required this.chainId,
//     required this.chainLogo,
//     required this.chainName,
//     required this.tokenLogo,
//     required this.tokenName,
//     required this.tokenPrice,
//     required this.symbol,
//     required this.address,
//     required this.decimals,
//     required this.isNative,
//     required this.priceChange24h,
//     required this.marketCap,
//     required this.liquidity,
//     required this.volume24h,
//     required this.holders,
//     required this.highestIncreaseRate,
//     required this.isMainstream,
//     required this.narrative,
//   });

//   String get hodlersValue =>
//       isMainstream == true && (int.tryParse(holders) ?? 0) == 0
//       ? '--'
//       : holders;

//   String get increaserate {
//     final parsed = highestIncreaseRate.replaceAll('%', '');
//     return ProfitFormatter.format(parsed);
//   }
// }
