import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:k_chart_plus/entity/k_line_entity.dart' show KLineEntity;

part 'candlestick_entity.freezed.dart';

@freezed
sealed class CandlestickEntity with _$CandlestickEntity {
  const CandlestickEntity._();
  const factory CandlestickEntity({
    required String time,
    required String open,
    required String high,
    required String low,
    required String close,
    required String volume,
  }) = _CandlestickEntity;

  KLineEntity toKLineEntity() => KLineEntity.fromCustom(
    time: int.parse(time),
    open: double.parse(open),
    high: double.parse(high),
    low: double.parse(low),
    close: double.parse(close),
    vol: double.parse(volume),
  );
}
