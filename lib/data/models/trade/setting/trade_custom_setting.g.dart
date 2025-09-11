// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_custom_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TradeCustomSettingImpl _$$TradeCustomSettingImplFromJson(
        Map<String, dynamic> json) =>
    _$TradeCustomSettingImpl(
      slippage: (json['slippage'] as num?)?.toInt() ?? 0,
      mevProtect: json['mevProtect'] as bool? ?? false,
      priorityFee: json['priorityFee'] as String? ?? '',
      tipFee: json['tipFee'] as String? ?? '',
      gasPrice: json['gasPrice'] as String? ?? '',
    );

Map<String, dynamic> _$$TradeCustomSettingImplToJson(
        _$TradeCustomSettingImpl instance) =>
    <String, dynamic>{
      'slippage': instance.slippage,
      'mevProtect': instance.mevProtect,
      'priorityFee': instance.priorityFee,
      'tipFee': instance.tipFee,
      'gasPrice': instance.gasPrice,
    };
