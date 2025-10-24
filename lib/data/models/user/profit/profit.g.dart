// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfitImpl _$$UserProfitImplFromJson(Map<String, dynamic> json) =>
    _$UserProfitImpl(
      balance: json['balance'] as String,
      value: json['value'] as String,
      profit: json['profit'] as String,
      riseFall: json['rise_fall'] as String,
    );

Map<String, dynamic> _$$UserProfitImplToJson(_$UserProfitImpl instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'value': instance.value,
      'profit': instance.profit,
      'rise_fall': instance.riseFall,
    };
