import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/domain/interfaces/i_token.dart';
import '../../../../shared/domain/mixins/token_mixin.dart';
import '../../../../utils/format/profit.dart';

part 'token_info_entity.freezed.dart';

@freezed
class TokenInfoEntity with _$TokenInfoEntity, TokenMixin implements IToken {
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
  final String tokenPrice;
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
  final String holders;

  @override
  final String highestIncreaseRate;

  @override
  final bool isMainstream;

  const TokenInfoEntity({
    required this.network,
    required this.rawBalance,
    required this.balance,
    required this.chainId,
    required this.chainLogo,
    required this.chainName,
    required this.tokenLogo,
    required this.tokenName,
    required this.tokenPrice,
    required this.symbol,
    required this.address,
    required this.decimals,
    required this.isNative,
    required this.priceChange24h,
    required this.marketCap,
    required this.liquidity,
    required this.volume24h,
    required this.holders,
    required this.highestIncreaseRate,
    required this.isMainstream,
  });

  String get hodlersValue =>
      isMainstream == true && (int.tryParse(holders) ?? 0) == 0
      ? '--'
      : holders;

  String get increaserate {
    final parsed = highestIncreaseRate.replaceAll('%', '');
    return ProfitFormatter.format(parsed);
  }
}
