import 'package:freezed_annotation/freezed_annotation.dart';

part 'profit.freezed.dart';
part 'profit.g.dart';

@freezed
class UserProfit with _$UserProfit {
  const factory UserProfit({
    @JsonKey(name: "balance") required String balance,
    @JsonKey(name: "value") required String value,
    @JsonKey(name: "profit") required String profit,
    @JsonKey(name: "rise_fall") required String riseFall,
  }) = _UserProfit;

  factory UserProfit.fromJson(Map<String, dynamic> json) =>
      _$UserProfitFromJson(json);
}
