import 'package:freezed_annotation/freezed_annotation.dart';

import '../token/token.dart';

part 'balance.freezed.dart';
part 'balance.g.dart';

@freezed
class Balance with _$Balance {
  const factory Balance({
    @JsonKey(name: "total_balance_usd") required String totalBalanceUsd,
    required List<Token> tokens,
  }) = _Balance;

  factory Balance.fromJson(Map<String, dynamic> json) =>
      _$BalanceFromJson(json);
}
