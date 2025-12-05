// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TokenDetailSecurity _$TokenDetailSecurityFromJson(Map<String, dynamic> json) =>
    _TokenDetailSecurity(
      contractAnaly:
          (json['contract_analysis'] as List<dynamic>?)
              ?.map((e) => SecurityItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      tradeTax: json['trade_tax'] == null
          ? null
          : TradeTax.fromJson(json['trade_tax'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TokenDetailSecurityToJson(
  _TokenDetailSecurity instance,
) => <String, dynamic>{
  'contract_analysis': instance.contractAnaly,
  'trade_tax': instance.tradeTax,
};

_SecurityItem _$SecurityItemFromJson(Map<String, dynamic> json) =>
    _SecurityItem(
      title: json['title'] == null
          ? null
          : Multilingual.fromJson(json['title'] as Map<String, dynamic>),
      description: json['description'] == null
          ? null
          : Multilingual.fromJson(json['description'] as Map<String, dynamic>),
      isSafe: json['is_safe'] as bool? ?? false,
      type: json['type'] as String? ?? 'risk',
    );

Map<String, dynamic> _$SecurityItemToJson(_SecurityItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'is_safe': instance.isSafe,
      'type': instance.type,
    };

_TradeTax _$TradeTaxFromJson(Map<String, dynamic> json) => _TradeTax(
  buyTax: json['buy_tax'] as String,
  sellTax: json['sell_tax'] as String,
);

Map<String, dynamic> _$TradeTaxToJson(_TradeTax instance) => <String, dynamic>{
  'buy_tax': instance.buyTax,
  'sell_tax': instance.sellTax,
};
