import 'package:freezed_annotation/freezed_annotation.dart';

part 'collect_token_model.freezed.dart';
part 'collect_token_model.g.dart';

@freezed
sealed class CollectTokenModel with _$CollectTokenModel {
  const factory CollectTokenModel({
    @JsonKey(name: 'network', defaultValue: '') required String network,
    @JsonKey(name: 'contract_address', defaultValue: '')
    required String contractAddress,
    @JsonKey(name: 'is_top', defaultValue: false) required bool isTop,
    required String symbol,
    @JsonKey(name: 'token_name', defaultValue: '') required String tokenName,
    @JsonKey(name: 'token_logo', defaultValue: '') required String tokenLogo,
    @JsonKey(name: 'market_cap', defaultValue: '') required String marketCap,
    @JsonKey(name: 'price_change_24h', defaultValue: '')
    required String priceChange24h,
    @JsonKey(name: 'price_usd', defaultValue: '') required String priceUsd,
    @JsonKey(name: 'chain_name', defaultValue: '') required String chainName,
    @JsonKey(name: 'chain_logo', defaultValue: '') required String chainLogo,
    @JsonKey(name: 'is_native', defaultValue: false) required bool isNative,
    @JsonKey(name: 'balance', defaultValue: '') required String balance,
    @JsonKey(name: 'raw_balance', defaultValue: '') required String rawBalance,
    @JsonKey(name: 'balance_usd', defaultValue: 0) required int balanceUsd,
  }) = _CollectTokenModel;

  factory CollectTokenModel.fromJson(Map<String, dynamic> json) =>
      _$CollectTokenModelFromJson(json);
}
