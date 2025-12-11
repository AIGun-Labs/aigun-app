import 'package:freezed_annotation/freezed_annotation.dart';

part 'candlestick_state.freezed.dart';

@freezed
sealed class CandlestickState with _$CandlestickState {
  const factory CandlestickState({
    @Default(false) bool isInitialized,
  }) = _CandlestickState;
}
