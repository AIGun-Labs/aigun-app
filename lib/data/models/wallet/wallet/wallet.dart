import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet.freezed.dart';
part 'wallet.g.dart';

// 地址模型
@freezed
class WalletAddress with _$WalletAddress {
  const factory WalletAddress(
      {@JsonKey(name: "chain_id") String? chainId,
      @JsonKey(name: "chain_name") String? chainName,
      @JsonKey(name: "logo_url") String? logoUrl,
      @JsonKey(name: "address_type") String? addressType,
      @JsonKey(name: "address") String? address}) = _WalletAddress;

  factory WalletAddress.fromJson(Map<String, dynamic> json) =>
      _$WalletAddressFromJson(json);
}

// 钱包模型
@freezed
class Wallet with _$Wallet {
  const factory Wallet({
    @JsonKey(name: "id") String? id,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "addresses") List<WalletAddress>? addresses,
  }) = _Wallet;

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);
}
