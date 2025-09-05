// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_setting_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TradeSettingState _$TradeSettingStateFromJson(Map<String, dynamic> json) =>
    TradeSettingState(
      mode: $enumDecode(_$TradeModeEnumMap, json['mode']),
      customSettings: (json['customSettings'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, TradeCustomSetting.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$TradeSettingStateToJson(TradeSettingState instance) =>
    <String, dynamic>{
      'mode': _$TradeModeEnumMap[instance.mode]!,
      'customSettings': instance.customSettings,
    };

const _$TradeModeEnumMap = {
  TradeMode.lightning: 'lightning',
  TradeMode.normal: 'normal',
};

_$TradeSettingStateImpl _$$TradeSettingStateImplFromJson(
        Map<String, dynamic> json) =>
    _$TradeSettingStateImpl(
      mode: $enumDecodeNullable(_$TradeModeEnumMap, json['mode']) ??
          TradeMode.lightning,
      customSettings: (json['customSettings'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, TradeCustomSetting.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$$TradeSettingStateImplToJson(
        _$TradeSettingStateImpl instance) =>
    <String, dynamic>{
      'mode': _$TradeModeEnumMap[instance.mode]!,
      'customSettings': instance.customSettings,
    };
