import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/enums/timeframe.dart';
import '../../../../../shared/domain/value_object/network.dart';
import '../../../domain/entities/get_candlestick_params.dart';

part 'selection_params_state.freezed.dart';

@freezed
sealed class SelectionParamsState with _$SelectionParamsState {
  const SelectionParamsState._();

  const factory SelectionParamsState({
    @Default(null) ChainNetwork? network,
    @Default(null) String? tokenContractAddress,
    @Default(null) String? bar,
    @Default(null) int? limit,
    @Default(null) int? from,
    @Default(null) int? to,
    @Default(Timeframe.m5) Timeframe selectedTimeframe,
  }) = _SelectionParamsState;

  GetCandlestickParams toParams() => GetCandlestickParams(
    network: network,
    tokenContractAddress: tokenContractAddress,
    bar: bar,
    limit: limit,
    from: from,
    to: to,
  );
}
