import 'package:freezed_annotation/freezed_annotation.dart';

part 'candlestick_entity.freezed.dart';

@freezed
sealed class CandlestickEntity with _$CandlestickEntity {
  const factory CandlestickEntity({
    required String time,
    required String open,
    required String high,
    required String low,
    required String close,
    required String volume,
  }) = _CandlestickEntity;
}
