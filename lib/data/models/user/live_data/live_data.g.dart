// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TradeLiveDataImpl _$$TradeLiveDataImplFromJson(Map<String, dynamic> json) =>
    _$TradeLiveDataImpl(
      priorityFee: json['priority_fee'] as String?,
      tipFee: json['tip_fee'] as String?,
      gasPrice: json['gas_price'] as String?,
    );

Map<String, dynamic> _$$TradeLiveDataImplToJson(_$TradeLiveDataImpl instance) =>
    <String, dynamic>{
      'priority_fee': instance.priorityFee,
      'tip_fee': instance.tipFee,
      'gas_price': instance.gasPrice,
    };
