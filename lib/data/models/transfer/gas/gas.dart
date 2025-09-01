import 'package:freezed_annotation/freezed_annotation.dart';

part 'gas.freezed.dart';
part 'gas.g.dart';

@freezed
class Gas with _$Gas {
  const factory Gas({
    @JsonKey(name: "chain_name") required String chainName,
    @JsonKey(name: "chain_type") required String chainType,
    @JsonKey(name: "gas") required String gas,
    @JsonKey(name: "symbol") required String symbol,
  }) = _Gas;

  factory Gas.fromJson(Map<String, dynamic> json) => _$GasFromJson(json);
}
