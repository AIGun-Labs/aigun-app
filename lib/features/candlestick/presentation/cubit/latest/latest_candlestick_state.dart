import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/candlestick_entity.dart';

part 'latest_candlestick_state.freezed.dart';

@freezed
sealed class FetchLatestCandlestickStatus with _$FetchLatestCandlestickStatus {
  const factory FetchLatestCandlestickStatus.initial() = _Initial;
  const factory FetchLatestCandlestickStatus.loading() = _Loading;
  const factory FetchLatestCandlestickStatus.error(String message) = _Error;
  const factory FetchLatestCandlestickStatus.success(
    CandlestickEntity candlestick,
  ) = _Success;
}

@freezed
sealed class LatestCandlestickState with _$LatestCandlestickState {
  const factory LatestCandlestickState({
    @Default(null) CandlestickEntity? latest,

    @Default(FetchLatestCandlestickStatus.initial())
    FetchLatestCandlestickStatus status,
  }) = _LatestCandlestickState;
}
