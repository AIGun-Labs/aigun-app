import 'package:freezed_annotation/freezed_annotation.dart';

part 'native_token.freezed.dart';
part 'native_token.g.dart';

@freezed
class NativeToken with _$NativeToken {
  const factory NativeToken(
      {@JsonKey(name: "chain_id") required int chainId,
      @JsonKey(name: "chain_type") required String chainType,
      @JsonKey(name: "chain_name") required String chainName,
      @JsonKey(name: "chain_logo") required String chainLogo,
      @JsonKey(name: "logo") @Default("") String? logo,
      @JsonKey(name: "name") @Default("") String? name,
      @JsonKey(name: "decimals") required int decimals,
      @JsonKey(name: "slug") String? slug}) = _NativeToken;

  factory NativeToken.fromJson(Map<String, dynamic> json) =>
      _$NativeTokenFromJson(json);
}
