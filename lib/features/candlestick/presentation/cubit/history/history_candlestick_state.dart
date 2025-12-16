import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/candlestick_entity.dart';

part 'history_candlestick_state.freezed.dart';

@freezed
sealed class HistoryCandlestickStatus with _$HistoryCandlestickStatus {
  const factory HistoryCandlestickStatus.initial() = _HistoryCandlestickInitial;
  const factory HistoryCandlestickStatus.loading() = _HistoryCandlestickLoading;
  const factory HistoryCandlestickStatus.success(
    List<CandlestickEntity> candles,
  ) = _HistoryCandlestickSuccess;
  const factory HistoryCandlestickStatus.error(String message) =
      _HistoryCandlestickError;
}

@freezed
sealed class HistoryCandlestickState with _$HistoryCandlestickState {
  const HistoryCandlestickState._();

  const factory HistoryCandlestickState({
    @Default([]) List<CandlestickEntity> candles,
    @Default('okx') String source,
    @Default(HistoryCandlestickStatus.initial())
    HistoryCandlestickStatus status,
    @Default(true) bool hasMore,
    @Default(false) bool isLoadingMore,
  }) = _HistoryCandlestickState;

  /// 获取最早一根K线的时间戳（用于加载更多历史数据）
  String? get earliestTime => candles.isNotEmpty ? candles.first.time : null;
}
