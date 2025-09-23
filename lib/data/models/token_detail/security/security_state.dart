import 'package:freezed_annotation/freezed_annotation.dart';

part 'security_state.freezed.dart';
part 'security_state.g.dart';

@freezed
class TokenDetailSecurityState with _$TokenDetailSecurityState {
  const factory TokenDetailSecurityState(
          {@JsonKey(name: "contract_analyzed")
          @Default([])
          List<SecurityItem> contractAnalyzed,
          @JsonKey(name: "trade_tax") required TradeTax tradeTax}) =
      _TokenDetailSecurityState;

  factory TokenDetailSecurityState.fromJson(Map<String, dynamic> json) =>
      _$TokenDetailSecurityStateFromJson(json);
}

@freezed
class SecurityItem with _$SecurityItem {
  const factory SecurityItem({
    @JsonKey(name: "title") required String title,
    @JsonKey(name: "description") required String description,
    @JsonKey(name: "is_safe") required String isSafe,
  }) = _SecurityItem;

  factory SecurityItem.fromJson(Map<String, dynamic> json) =>
      _$SecurityItemFromJson(json);
}

@freezed
class TradeTax with _$TradeTax {
  const factory TradeTax({
    @JsonKey(name: "title") required String title,
    @JsonKey(name: "description") required String description,
    @JsonKey(name: "is_safe") required String is_safe,
  }) = _TradeTax;

  factory TradeTax.fromJson(Map<String, dynamic> json) =>
      _$TradeTaxFromJson(json);
}
