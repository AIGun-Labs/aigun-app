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

  Function(String price) onPriceUpdate;
  GetCandlestickParams? _lastFetchParams;

  CandlestickCubit({
    required SelectionParamsCubit selectionParamsCubit,
    required HistoryCandlestickCubit historyCubit,
    required LatestCandlestickCubit latestCubit,
    required this.onPriceUpdate,
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

    final newSource = CandleSource.fromString(historyState.source);
    _selectionParamsCubit.updateSource(newSource);
    // if (newSource == CandleSource.cmc) {
    //   final currentTimeframe = _selectionParamsCubit.state.selectedTimeframe;
    //   if (currentTimeframe == Timeframe.m1 ||
    //       currentTimeframe == Timeframe.m5) {
    //     Logger.info(
    //       'Source is cmc, switching timeframe from $currentTimeframe to m15 (display only)',
    //     );
    //     _selectionParamsCubit.updateSelectedTimeframeOnly(Timeframe.m15);
    //   }
    // }

    emit(
      state.copyWith(
        status: historyState.status,
        candles: historyState.candles,
        source: newSource,
        hasMore: historyState.hasMore,
        isLoadingMore: historyState.isLoadingMore,
      ),
    );
  }

  void _onLatestChanged(LatestCandlestickState latestState) {
    Logger.info('onLatestChanged: ${latestState.latest}');
    if (latestState.latest != null) {
      final updatedData = [...state.candles];
      if (updatedData.isNotEmpty) {
        final lastIndex = updatedData.length - 1;
        final lastCandle = updatedData[lastIndex];
        if (lastCandle.time == latestState.latest!.time) {
          updatedData[lastIndex] = latestState.latest!;
        } else {
          updatedData.add(latestState.latest!);
        }
        onPriceUpdate(latestState.latest!.close);
        emit(state.copyWith(candles: updatedData));
      }
    }
  }

  void updateToken({required String network, required String address}) {
    _selectionParamsCubit.updateToken(network: network, address: address);
  }

  void refresh() {
    final params = _selectionParamsCubit.state.toParams();
    _historyCubit.fetch(params);
    _latestCubit.updateParams(params);
  }

  void startPolling() => _latestCubit.startPolling();
  void stopPolling() => _latestCubit.stopPolling();
  Future<void> loadMore() => _historyCubit.loadMore();

  @override
  Future<void> close() async {
    await Future.wait([
      _paramsSub?.cancel() ?? Future.value(),
      _historySub?.cancel() ?? Future.value(),
      _latestSub?.cancel() ?? Future.value(),
    ]);
    return super.close();
  }

  void clearHistoryData() {
    emit(state.copyWith(candles: []));
  }

  void clearLatestData() => _latestCubit.clearData();

  void resetAll() {
    _selectionParamsCubit.reset();
    _historyCubit.reset();
    _latestCubit.clearData();
  }
}
