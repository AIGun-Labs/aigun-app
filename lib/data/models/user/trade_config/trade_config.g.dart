// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TradeConfigImpl _$$TradeConfigImplFromJson(Map<String, dynamic> json) =>
    _$TradeConfigImpl(
      chainName: json['network'] as String,
      mode: json['mode'] as String,
      config:
          TradeCustomSetting.fromJson(json['config'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TradeConfigImplToJson(_$TradeConfigImpl instance) =>
    <String, dynamic>{
      'network': instance.chainName,
      'mode': instance.mode,
      'config': instance.config,
    };
