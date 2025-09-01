import 'package:freezed_annotation/freezed_annotation.dart';

part 'address.freezed.dart';
part 'address.g.dart';

@freezed
class Address with _$Address {
  const factory Address({
    @JsonKey(name: "chain_id") required String chainId,
    @JsonKey(name: "chain_name") required String chainName,
    @JsonKey(name: "logo_url") required String logoUrl,
    @JsonKey(name: "address") required String address,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}
