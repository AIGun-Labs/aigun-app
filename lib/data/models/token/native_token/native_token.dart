import 'package:freezed_annotation/freezed_annotation.dart';

part 'native_token.freezed.dart';
part 'native_token.g.dart';

@freezed
sealed class NativeToken with _$NativeToken {
  const factory NativeToken({
    @JsonKey(name: 'decimals') required int decimals,
    @JsonKey(name: 'symbol') required String symbol,
    @JsonKey(name: 'balance') required String balance,
    @JsonKey(name: 'token_price') required String tokenPrice,
    @JsonKey(name: 'chain_id') required String chainId,
    @JsonKey(name: 'chain_name') required String chainName,
    @JsonKey(name: 'chain_type') required String chainType,
    @JsonKey(name: 'raw_balance') required String rawBalance,
    @JsonKey(name: 'network') required String network,
    @JsonKey(name: 'chain_logo') required String chainLogo,
    @JsonKey(name: 'token_address') required String tokenAddress,
    @JsonKey(name: 'token_avatar') required String tokenAvatar,
  }) = _NativeToken;

  factory NativeToken.fromJson(Map<String, dynamic> json) =>
      _$NativeTokenFromJson(json);
}
