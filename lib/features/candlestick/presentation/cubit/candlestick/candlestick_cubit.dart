import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/enums/candle_source.dart';
import '../../../../../utils/logger.dart';
import '../../../domain/entities/get_candlestick_params.dart';
import '../history/history_candlestick_cubit.dart';
import '../history/history_candlestick_state.dart';
import '../latest/latest_candlestick_cubit.dart';
import '../latest/latest_candlestick_state.dart';
import '../selection/selection_params_cubit.dart';
import '../selection/selection_params_state.dart';
import 'candlestick_state.dart';

class CandlestickCubit extends Cubit<CandlestickState> {
  final SelectionParamsCubit _selectionParamsCubit;
  final HistoryCandlestickCubit _historyCubit;
  final LatestCandlestickCubit _latestCubit;

  StreamSubscription<SelectionParamsState>? _paramsSub;
  StreamSubscription<HistoryCandlestickState>? _historySub;
  StreamSubscription<LatestCandlestickState>? _latestSub;

  /// 缓存上一次的数据获取参数，用于判断是否需要刷新数据
  GetCandlestickParams? _lastFetchParams;

  CandlestickCubit({
    required SelectionParamsCubit selectionParamsCubit,
    required HistoryCandlestickCubit historyCubit,
    required LatestCandlestickCubit latestCubit,
  }) : _selectionParamsCubit = selectionParamsCubit,
       _historyCubit = historyCubit,
       _latestCubit = latestCubit,
       super(const CandlestickState()) {
    _initialize();
  }

  void _initialize() {
    _paramsSub = _selectionParamsCubit.stream.listen(_onParamsChanged);
    _historySub = _historyCubit.stream.listen(_onHistoryChanged);
    _latestSub = _latestCubit.stream.listen(_onLatestChanged);
    emit(state.copyWith(isInitialized: true));
  }

  void _onParamsChanged(SelectionParamsState paramsState) {
    final params = paramsState.toParams();
    // 只有当影响数据获取的参数变化时才刷新数据
    // MainStates、SecondaryStates、volHidden 变化不触发刷新
    if (_lastFetchParams != params) {
      Logger.info('onParamsChanged (fetching): $params');
      _lastFetchParams = params;
      _historyCubit.fetch(params);
      _latestCubit.updateParams(params);
    } else {
      Logger.info(
        'onParamsChanged (display only): mainStates/secondaryStates/volHidden changed',
      );
    }
  }

  void _onHistoryChanged(HistoryCandlestickState historyState) {
    Logger.info('onHistoryChanged: candles: ${historyState.candles}');
    Logger.info('onHistoryChanged: source: ${historyState.source}');
    emit(
      state.copyWith(
        status: historyState.status,
        candles: historyState.candles,
        source: CandleSource.fromString(historyState.source),
      ),
    );
  }

  void _onLatestChanged(LatestCandlestickState latestState) {
    Logger.info('onLatestChanged: ${latestState.latest}');

    // 将最新的 K 线数据合并到现有数据中
    if (latestState.latest != null) {
      final updatedData = [...state.candles];
      if (updatedData.isNotEmpty) {
        // 替换最后一条或追加新数据
        final lastIndex = updatedData.length - 1;
        final lastCandle = updatedData[lastIndex];
        if (lastCandle.time == latestState.latest!.time) {
          updatedData[lastIndex] = latestState.latest!;
        } else {
          updatedData.add(latestState.latest!);
        }
        emit(state.copyWith(candles: updatedData));
      }
    }
  }

  void updateToken({required String network, required String address}) {
    _selectionParamsCubit.updateToken(network: network, address: address);
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
    _historySub?.cancel();
    _latestSub?.cancel();
    return super.close();
  }

  void clearHistoryData() {
    emit(state.copyWith(candles: []));
  }

  void clearLatestData() => _latestCubit.clearData();
}
