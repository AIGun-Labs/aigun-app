import 'package:candlestick/candlestick_widget.dart';
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
    @Default('300') String? bar, // 默认与 Timeframe.m5 (5分钟=300秒) 匹配
    @Default(null) int? limit,
    @Default(null) int? from,
    @Default(null) int? to,
    @Default(Timeframe.m5) Timeframe selectedTimeframe,
    @Default({}) Set<MainState> mainStates,
    @Default({}) Set<SecondaryState> secondaryStates,
    @Default(false) bool volHidden,
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
