import 'package:freezed_annotation/freezed_annotation.dart';

part 'security_state.freezed.dart';
part 'security_state.g.dart';

@freezed
class TokenDetailSecurity with _$TokenDetailSecurity {
  const factory TokenDetailSecurity(
          {@JsonKey(name: "contract_analy")
          @Default([])
          List<SecurityItem> contractAnaly,
          @JsonKey(name: "trade_tax") required TradeTax tradeTax}) =
      _TokenDetailSecurity;

  factory TokenDetailSecurity.fromJson(Map<String, dynamic> json) =>
      _$TokenDetailSecurityFromJson(json);
}

@freezed
class SecurityItem with _$SecurityItem {
  const factory SecurityItem({
    @JsonKey(name: "title") required String title,
    @JsonKey(name: "description") required String description,
    @JsonKey(name: "is_safe") required bool isSafe,
    @JsonKey(name: "type") @Default("risk") String type,
  }) = _SecurityItem;

  factory SecurityItem.fromJson(Map<String, dynamic> json) =>
      _$SecurityItemFromJson(json);
}

@freezed
class TradeTax with _$TradeTax {
  const factory TradeTax({
    @JsonKey(name: "buy_tax") required String buyTax,
    @JsonKey(name: "sell_tax") required String sellTax,
  }) = _TradeTax;

  factory TradeTax.fromJson(Map<String, dynamic> json) =>
      _$TradeTaxFromJson(json);
}
