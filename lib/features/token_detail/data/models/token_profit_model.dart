import 'package:json_annotation/json_annotation.dart';

part 'token_profit_model.g.dart';

@JsonSerializable()
final class TokenProfitModel {
  final String balance;
  final String value;
  final String profit;

  @JsonKey(name: 'rise_fall')
  final String riseFall;

  const TokenProfitModel({
    required this.balance,
    required this.value,
    required this.profit,
    required this.riseFall,
  });

  factory TokenProfitModel.fromJson(Map<String, dynamic> json) =>
      _$TokenProfitModelFromJson(json);
}
