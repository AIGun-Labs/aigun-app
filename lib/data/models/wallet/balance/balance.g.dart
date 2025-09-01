// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BalanceImpl _$$BalanceImplFromJson(Map<String, dynamic> json) =>
    _$BalanceImpl(
      totalBalanceUsd: json['total_balance_usd'] as String,
      tokens: (json['tokens'] as List<dynamic>)
          .map((e) => Token.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$BalanceImplToJson(_$BalanceImpl instance) =>
    <String, dynamic>{
      'total_balance_usd': instance.totalBalanceUsd,
      'tokens': instance.tokens,
    };
