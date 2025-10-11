// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TokenDetailSecurityImpl _$$TokenDetailSecurityImplFromJson(
        Map<String, dynamic> json) =>
    _$TokenDetailSecurityImpl(
      contractAnaly: (json['contract_analysis'] as List<dynamic>?)
              ?.map((e) => SecurityItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      tradeTax: json['trade_tax'] == null
          ? null
          : TradeTax.fromJson(json['trade_tax'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TokenDetailSecurityImplToJson(
        _$TokenDetailSecurityImpl instance) =>
    <String, dynamic>{
      'contract_analysis': instance.contractAnaly,
      'trade_tax': instance.tradeTax,
    };

_$SecurityItemImpl _$$SecurityItemImplFromJson(Map<String, dynamic> json) =>
    _$SecurityItemImpl(
      title: json['title'] as String,
      description: json['description'] as String,
      isSafe: json['is_safe'] as bool,
      type: json['type'] as String? ?? "risk",
    );

Map<String, dynamic> _$$SecurityItemImplToJson(_$SecurityItemImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'is_safe': instance.isSafe,
      'type': instance.type,
    };

_$TradeTaxImpl _$$TradeTaxImplFromJson(Map<String, dynamic> json) =>
    _$TradeTaxImpl(
      buyTax: json['buy_tax'] as String,
      sellTax: json['sell_tax'] as String,
    );

Map<String, dynamic> _$$TradeTaxImplToJson(_$TradeTaxImpl instance) =>
    <String, dynamic>{
      'buy_tax': instance.buyTax,
      'sell_tax': instance.sellTax,
    };
