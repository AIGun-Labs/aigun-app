import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/candlestick_entity.dart';

part 'candlestick_model.freezed.dart';
part 'candlestick_model.g.dart';

@freezed
sealed class CandlestickModel with _$CandlestickModel {
  const CandlestickModel._();
  const factory CandlestickModel({
    required String time,
    required String open,
    required String high,
    required String low,
    required String close,
    required String volume,
  }) = _CandlestickModel;

  factory CandlestickModel.fromJson(Map<String, dynamic> json) =>
      _$CandlestickModelFromJson(json);

  CandlestickEntity toEntity() => CandlestickEntity(
    time: time,
    open: open,
    high: high,
    low: low,
    close: close,
    volume: volume,
  );
}
