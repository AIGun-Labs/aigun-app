import "package:freezed_annotation/freezed_annotation.dart";
import "package:k_chart/flutter_k_chart.dart";

part 'candle_state.freezed.dart';

@freezed
class CandleState with _$CandleState {
  const factory CandleState(
      {@Default([]) List<KLineEntity> candles,
      @Default("") network,
      @Default('') tokenAddress,
      @Default(5 * 60) bar,
      @Default(800) limit,
      @Default(0) from,
      @Default(0) to,
      @Default(false) bool isLoading}) = _CandleState;
}
