import "package:flutter_aigun/cubits/index.dart";
import "package:flutter_aigun/data/models/index.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part 'candle_state.freezed.dart';

@freezed
class CandleState with _$CandleState {
  const factory CandleState(
      {@Default([]) List<Candle> candles,
      @Default("") network,
      @Default('') tokenAddress,
      @Default(0)  bar,
      @Default(0)  limit,
      @Default(0)  from,
      @Default(0)  to,
      @Default(false) bool isLoading}) = _CandleState;
}
