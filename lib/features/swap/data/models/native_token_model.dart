import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/domain/entities/base_token_entity.dart';

part 'native_token_model.freezed.dart';
part 'native_token_model.g.dart';

@freezed
sealed class NativeTokenModel with _$NativeTokenModel {
  const NativeTokenModel._();
  const factory NativeTokenModel({
    @JsonKey(name: 'is_native') required bool isNative,
    @JsonKey(name: 'chain_id') required String chainId,
    @JsonKey(name: 'chain_logo') required String chainLogo,
    @JsonKey(name: 'chain_name') required String chainName,
    @JsonKey(name: 'token_avatar') required String tokenAvatar,
    @JsonKey(name: 'token_name') required String tokenName,
    @JsonKey(name: 'token_address') required String address,
    @JsonKey(name: 'token_price') required String tokenPrice,
    @JsonKey(name: 'raw_balance') required String rawBalance,
    @JsonKey(name: 'balance') required String balance,
    @JsonKey(name: 'decimals') required int decimals,
    @JsonKey(name: 'symbol') required String symbol,
    @JsonKey(name: 'network') required String network,
  }) = _NativeTokenModel;

  factory NativeTokenModel.fromJson(Map<String, dynamic> json) =>
      _$NativeTokenModelFromJson(json);

  BaseTokenEntity toEntity() => BaseTokenEntity(
    chainId: chainId,
    chainLogo: chainLogo,
    chainName: chainName,
    tokenLogo: tokenAvatar,
    tokenName: tokenName,
    tokenPrice: tokenPrice,
    symbol: symbol,
    network: network,
    address: address,
    rawBalance: rawBalance,
    balance: balance,
    decimals: decimals,
    priceChange24h: '',
    marketCap: '',
    isNative: isNative,
    liquidity: '',
    volume24h: '',
  );
}
