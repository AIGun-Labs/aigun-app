import "package:freezed_annotation/freezed_annotation.dart";
import "package:k_chart/flutter_k_chart.dart";

part 'candle_state.freezed.dart';

@freezed
class CandleState with _$CandleState {
  const CandleState._();
  const factory CandleState(
      {@Default([]) List<KLineEntity> candles,
      @Default("") network,
      @Default('') tokenAddress,
      @Default(5 * 60) bar,
      @Default(800) limit,
      @Default(0) from,
      @Default(0) to,
      @Default(false) bool isLoading}) = _CandleState;

  static const CandleState initial = CandleState();

  num get calculatedFrom => to - (bar * 60 * 1000 * 800);

  num get calculatedTo => DateTime.now().millisecondsSinceEpoch;
}
