import 'package:candlestick/entity/k_line_entity.dart';
import 'package:candlestick/utils/data_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/enums/candle_source.dart';
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
    @Default(CandleSource.okx) CandleSource source,
    @Default(true) bool hasMore,
    @Default(false) bool isLoadingMore,
  }) = _CandlestickState;

  List<KLineEntity> get kLineEntities {
    final entities = candles.map((e) => e.toKLineEntity()).toList();
    if (entities.isNotEmpty) {
      DataUtil.calculate(entities);
    }
    return entities;
  }
}
