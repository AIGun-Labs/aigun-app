import 'package:freezed_annotation/freezed_annotation.dart';

part 'gas.freezed.dart';
part 'gas.g.dart';

@freezed
class Gas with _$Gas {
  const factory Gas({
    @JsonKey(name: "chain_name") @Default('') String chainName,
    @JsonKey(name: "chain_type") @Default('') String chainType,
    @JsonKey(name: "gas") @Default('') String gas,
    @JsonKey(name: "token_symbol") @Default('') String symbol,
    @JsonKey(name: "network") @Default('') String network,
    @JsonKey(name: "gas_usd") @Default('') String gasUsd,
  }) = _Gas;

  factory Gas.fromJson(Map<String, dynamic> json) => _$GasFromJson(json);
}
