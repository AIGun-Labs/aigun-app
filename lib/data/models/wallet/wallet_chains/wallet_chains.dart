import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_chains.freezed.dart';
part 'wallet_chains.g.dart';

@freezed
sealed class WalletChains with _$WalletChains {
  const factory WalletChains({
    @JsonKey(name: 'chain_id') required int chainId,
    @JsonKey(name: 'chain_type') required String chainType,
    @JsonKey(name: 'chain_name') required String chainName,
    @JsonKey(name: 'logo_url') required String logoUrl,
    @JsonKey(name: 'explorer') required String explorer,
  }) = _WalletChains;

  factory WalletChains.fromJson(Map<String, dynamic> json) =>
      _$WalletChainsFromJson(json);
}
