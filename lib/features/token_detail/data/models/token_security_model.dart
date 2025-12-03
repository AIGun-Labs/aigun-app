import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/language/language.dart';

part 'token_security_model.freezed.dart';
part 'token_security_model.g.dart';

@freezed
@JsonSerializable()
class TokenSecurityModel with _$TokenSecurityModel {
  @override
  @JsonKey(name: 'contract_analysis', defaultValue: <SecurityItemModel>[])
  final List<SecurityItemModel> contractAnalysis;

  @override
  @JsonKey(name: 'trade_tax')
  final TradeTaxModel? tradeTax;

  const TokenSecurityModel({
    this.contractAnalysis = const <SecurityItemModel>[],
    this.tradeTax,
  });

  factory TokenSecurityModel.fromJson(Map<String, dynamic> json) =>
      _$TokenSecurityModelFromJson(json);
}

// 普通 DTO + JsonSerializable
@JsonSerializable()
class SecurityItemModel {
  @JsonKey(name: 'title')
  final Multilingual? title;

  @JsonKey(name: 'description')
  final Multilingual? description;

  @JsonKey(name: 'is_safe', defaultValue: false)
  final bool isSafe;

  @JsonKey(name: 'type', defaultValue: 'risk')
  final String type;

  SecurityItemModel({
    this.title,
    this.description,
    this.isSafe = false,
    this.type = 'risk',
  });

  factory SecurityItemModel.fromJson(Map<String, dynamic> json) =>
      _$SecurityItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$SecurityItemModelToJson(this);
}

@JsonSerializable()
class TradeTaxModel {
  @JsonKey(name: 'buy_tax')
  final String buyTax;

  @JsonKey(name: 'sell_tax')
  final String sellTax;

  const TradeTaxModel({required this.buyTax, required this.sellTax});

  factory TradeTaxModel.fromJson(Map<String, dynamic> json) =>
      _$TradeTaxModelFromJson(json);

  Map<String, dynamic> toJson() => _$TradeTaxModelToJson(this);
}
