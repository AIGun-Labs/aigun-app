import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../history/history_candlestick_cubit.dart';
import '../latest/latest_candlestick_cubit.dart';
import '../selection/selection_params_cubit.dart';
import '../selection/selection_params_state.dart';
import 'candlestick_state.dart';

class CandlestickCubit extends Cubit<CandlestickState> {
  final SelectionParamsCubit _selectionParamsCubit;
  final HistoryCandlestickCubit _historyCubit;
  final LatestCandlestickCubit _latestCubit;

  StreamSubscription<SelectionParamsState>? _paramsSub;

  CandlestickCubit({
    required SelectionParamsCubit selectionParamsCubit,
    required HistoryCandlestickCubit historyCubit,
    required LatestCandlestickCubit latestCubit,
  })  : _selectionParamsCubit = selectionParamsCubit,
        _historyCubit = historyCubit,
        _latestCubit = latestCubit,
        super(const CandlestickState()) {
    _initialize();
  }

  void _initialize() {
    _paramsSub = _selectionParamsCubit.stream.listen(_onParamsChanged);
    emit(state.copyWith(isInitialized: true));
  }

  void _onParamsChanged(SelectionParamsState paramsState) {
    final params = paramsState.toParams();
    _historyCubit.fetch(params);
    _latestCubit.updateParams(params);
  }

  /// 手动触发数据刷新
  void refresh() {
    final params = _selectionParamsCubit.state.toParams();
    _historyCubit.fetch(params);
    _latestCubit.updateParams(params);
  }

  /// 启动最新 K 线轮询
  void startPolling() => _latestCubit.startPolling();

  /// 停止最新 K 线轮询
  void stopPolling() => _latestCubit.stopPolling();

  @override
  Future<void> close() {
    _paramsSub?.cancel();
    return super.close();
  }
}
