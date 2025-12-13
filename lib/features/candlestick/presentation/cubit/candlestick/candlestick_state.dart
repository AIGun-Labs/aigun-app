import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:k_chart_plus/entity/k_line_entity.dart';

import '../../../domain/entities/candlestick_entity.dart';
import '../history/history_candlestick_state.dart';

part 'candlestick_state.freezed.dart';

@freezed
sealed class CandlestickState with _$CandlestickState {
  const CandlestickState._();
  const factory CandlestickState({
    @Default(false) bool isInitialized,
    @Default(HistoryCandlestickStatus.initial())
    HistoryCandlestickStatus status,
    @Default([]) List<CandlestickEntity> candles,
  }) = _CandlestickState;

  List<KLineEntity> get kLineEntities =>
      candles.map((e) => e.toKLineEntity()).toList();
}
