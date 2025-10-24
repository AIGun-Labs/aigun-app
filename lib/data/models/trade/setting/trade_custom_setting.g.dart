// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_custom_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TradeCustomSettingImpl _$$TradeCustomSettingImplFromJson(
        Map<String, dynamic> json) =>
    _$TradeCustomSettingImpl(
      slippage:
          json['slippage'] == null ? 0 : _slippageFromJson(json['slippage']),
      mevProtect: json['mev_protect'] as bool? ?? false,
      priorityFee: json['priority_fee'] as String? ?? '',
      tipFee: json['tip_fee'] as String? ?? '',
      gasPrice: json['gas_price'] as String? ?? '',
    );

Map<String, dynamic> _$$TradeCustomSettingImplToJson(
        _$TradeCustomSettingImpl instance) =>
    <String, dynamic>{
      'slippage': instance.slippage,
      'mev_protect': instance.mevProtect,
      'priority_fee': instance.priorityFee,
      'tip_fee': instance.tipFee,
      'gas_price': instance.gasPrice,
    };
