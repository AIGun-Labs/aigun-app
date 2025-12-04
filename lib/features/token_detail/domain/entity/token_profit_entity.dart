import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_profit_entity.freezed.dart';

@Freezed()
class TokenProfitEntity with _$TokenProfitEntity {
  @override
  final String riseFall;
  @override
  final String balance;
  @override
  final String value;
  @override
  final String profit;

  const TokenProfitEntity({
    required this.balance,
    required this.value,
    required this.profit,
    required this.riseFall,
  });
}
