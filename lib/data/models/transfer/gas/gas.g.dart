// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gas.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GasImpl _$$GasImplFromJson(Map<String, dynamic> json) => _$GasImpl(
      chainName: json['chain_name'] as String,
      chainType: json['chain_type'] as String,
      gas: json['gas'] as String,
      symbol: json['symbol'] as String,
    );

Map<String, dynamic> _$$GasImplToJson(_$GasImpl instance) => <String, dynamic>{
      'chain_name': instance.chainName,
      'chain_type': instance.chainType,
      'gas': instance.gas,
      'symbol': instance.symbol,
    };
