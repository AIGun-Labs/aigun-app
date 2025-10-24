// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'candle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CandleImpl _$$CandleImplFromJson(Map<String, dynamic> json) => _$CandleImpl(
      time: json['time'] as String,
      open: json['open'] as String,
      high: json['high'] as String,
      low: json['low'] as String,
      close: json['close'] as String,
      volume: json['volume'] as String,
    );

Map<String, dynamic> _$$CandleImplToJson(_$CandleImpl instance) =>
    <String, dynamic>{
      'time': instance.time,
      'open': instance.open,
      'high': instance.high,
      'low': instance.low,
      'close': instance.close,
      'volume': instance.volume,
    };
