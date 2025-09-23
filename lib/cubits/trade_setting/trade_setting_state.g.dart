// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_setting_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TradeSettingStateImpl _$$TradeSettingStateImplFromJson(
        Map<String, dynamic> json) =>
    _$TradeSettingStateImpl(
      mode: $enumDecodeNullable(_$TradeModeEnumMap, json['mode']) ??
          TradeMode.fast,
      chainName: json['chainName'] as String? ?? "solana",
      customSettings: (json['customSettings'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
                k, TradeCustomSetting.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
    );

Map<String, dynamic> _$$TradeSettingStateImplToJson(
        _$TradeSettingStateImpl instance) =>
    <String, dynamic>{
      'mode': _$TradeModeEnumMap[instance.mode]!,
      'chainName': instance.chainName,
      'customSettings': instance.customSettings,
    };

const _$TradeModeEnumMap = {
  TradeMode.fast: 'fast',
  TradeMode.normal: 'normal',
  TradeMode.custom: 'custom',
};
