import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:k_chart/flutter_k_chart.dart';

part 'candle_state.freezed.dart';

enum CandlestickLoadingState { initial, loading, loaded, error }

@freezed
sealed class CandleState with _$CandleState {
  const CandleState._();
  const factory CandleState({
    @Default([]) List<KLineEntity> candles,
    @Default('') network,
    @Default('') tokenAddress,
    @Default(5 * 60) bar,
    @Default(20) limit,
    @Default(0) from,
    @Default(0) to,
    @Default(false) bool isLoadingLatest,
    @Default(false) bool isLoading,
    @Default(CandlestickLoadingState.initial)
    CandlestickLoadingState loadingState,
  }) = _CandleState;

  static const CandleState initial = CandleState();

  num get calculatedFrom {
    final effectiveTo = to == 0 ? DateTime.now().millisecondsSinceEpoch : to;

    return effectiveTo - (bar * 1000 * limit);
  }

  bool get isEmpty =>
      (candles.isEmpty && loadingState == CandlestickLoadingState.loaded) ||
      loadingState == CandlestickLoadingState.error;

  num get calculatedTo => to == 0 ? DateTime.now().millisecondsSinceEpoch : to;
}
