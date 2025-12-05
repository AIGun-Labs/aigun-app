// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'candle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Candle _$CandleFromJson(Map<String, dynamic> json) => _Candle(
  time: json['time'] as String,
  open: json['open'] as String,
  high: json['high'] as String,
  low: json['low'] as String,
  close: json['close'] as String,
  volume: json['volume'] as String,
);

Map<String, dynamic> _$CandleToJson(_Candle instance) => <String, dynamic>{
  'time': instance.time,
  'open': instance.open,
  'high': instance.high,
  'low': instance.low,
  'close': instance.close,
  'volume': instance.volume,
};
