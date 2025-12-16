import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/data/models/multilingual_model.dart';

part 'token_security_model.freezed.dart';
part 'token_security_model.g.dart';

@freezed
@JsonSerializable()
class TokenSecurityModel with _$TokenSecurityModel {
  const TokenSecurityModel({required this.contractAnalysis, this.tradeTax});

  factory TokenSecurityModel.fromJson(Map<String, dynamic> json) =>
      _$TokenSecurityModelFromJson(json);
  @override
  @JsonKey(name: 'contract_analysis', defaultValue: <SecurityItemModel>[])
  final List<SecurityItemModel> contractAnalysis;

  @override
  @JsonKey(name: 'trade_tax')
  final TradeTaxModel? tradeTax;
}

// 普通 DTO + JsonSerializable
@JsonSerializable()
class SecurityItemModel {
  SecurityItemModel({
    this.title,
    this.description,
    this.isSafe = false,
    this.type = 'risk',
  });

  factory SecurityItemModel.fromJson(Map<String, dynamic> json) =>
      _$SecurityItemModelFromJson(json);
  @JsonKey(name: 'title')
  final MultilingualModel? title;

  @JsonKey(name: 'description')
  final MultilingualModel? description;

  @JsonKey(name: 'is_safe', defaultValue: false)
  final bool isSafe;

  @JsonKey(name: 'type', defaultValue: 'risk')
  final String type;

  Map<String, dynamic> toJson() => _$SecurityItemModelToJson(this);
}

@JsonSerializable()
class TradeTaxModel {
  const TradeTaxModel({required this.buyTax, required this.sellTax});

  factory TradeTaxModel.fromJson(Map<String, dynamic> json) =>
      _$TradeTaxModelFromJson(json);
  @JsonKey(name: 'buy_tax')
  final String buyTax;

  @JsonKey(name: 'sell_tax')
  final String sellTax;

  Map<String, dynamic> toJson() => _$TradeTaxModelToJson(this);
}
