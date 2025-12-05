import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_chart/flutter_k_chart.dart';

import '../../core/constant/count.dart';
import '../../core/polling/polling_service.dart';
import '../../core/service_locator.dart';
import '../../data/services/api/candle_api.dart';
import '../../utils/logger.dart';
import '../token_detail/token_detail_cubit.dart';
import 'candle_state.dart';

class CandleCubit extends Cubit<CandleState> {
  final CandleApi candleApi;

  PollingService<KLineEntity?>? _pollingService;

  CandleCubit(this.candleApi) : super(CandleState.initial);

  void startPollingLatest() {
    _pollingService?.stop();

    _pollingService = PollingService<KLineEntity?>(
      baseInterval: const Duration(seconds: FIVE),
      maxInterval: const Duration(seconds: ONE),
      fetcher: (cancel) async {
        final latestCandle = await getLatest(cancel);
        return latestCandle;
      },
      onData: (info) {
        if (info != null) {
          updateLatestCandles(info);
        }
      },
      onError: (error, stackTrace) {
        Logger.error('❌ K: $error');
      },
      pauseOnBackground: true,
    )..start();
  }

  void pausePollingLatest() {
    _pollingService?.stop();
  }

  Future<void> loadData() async {
    await getCandlesHistory();
    startPollingLatest();
  }

  void resetAll() {
    pausePollingLatest();
    emit(CandleState.initial);
  }

  Future<void> getCandlesHistory() async {
    if (state.loadingState == CandlestickLoadingState.loading) {
      return;
    }

    try {
      emit(state.copyWith(loadingState: CandlestickLoadingState.loading));

      Logger.info('📊 K: bar=${state.bar}s, limit=${state.limit}');
      Logger.info(
        '📊 : from=${DateTime.fromMillisecondsSinceEpoch(state.calculatedFrom.toInt())} to=${DateTime.fromMillisecondsSinceEpoch(state.calculatedTo.toInt())}',
      );

      final candles = await candleApi.getCandlesHistory(
        network: state.network,
        tokenContractAddress: state.tokenAddress,
        bar: state.bar,
        from: state.calculatedFrom,
        to: state.calculatedTo,
        limit: state.limit,
      );

      if (candles.isEmpty) {
        emit(state.copyWith(loadingState: CandlestickLoadingState.error));
        return;
      } else {
        Logger.info('📊  ${candles.length} K');
        emit(
          state.copyWith(
            candles: candles.reversed.toList(),
            loadingState: CandlestickLoadingState.loaded,
          ),
        );
      }
    } catch (e) {
      Logger.error('❌ K: $e');
      emit(state.copyWith(loadingState: CandlestickLoadingState.error));
    }
  }

  DateTime calculatePreviousTimeRange({
    required DateTime currentFrom,
    required int bar,
    required int loadCount,
  }) {
    final offsetMinutes = bar * loadCount;
    return currentFrom.subtract(Duration(minutes: offsetMinutes));
  }

  Future<KLineEntity?> getLatest(CancelToken cancel) async {
    if (state.isLoadingLatest) {
      return null;
    }
    late final KLineEntity? latestCandle;

    try {
      emit(state.copyWith(isLoadingLatest: true));
      final latests = await candleApi.getCandlesHistory(
        network: state.network,
        tokenContractAddress: state.tokenAddress,
        bar: state.bar,
        isLatest: true,
        limit: state.limit,
        cancel: cancel,
      );
      latestCandle = latests.firstOrNull;

      getIt<TokenDetailCubit>().updateTokenPriceUsd(latestCandle?.close ?? 0);
    } catch (e) {
      debugPrint('e: $e');
      return null;
    } finally {
      emit(state.copyWith(isLoadingLatest: false));
    }
    return latestCandle;
  }

  void updateNetwork(String network) {
    emit(state.copyWith(network: network));
  }

  void updateAddress(String address) {
    emit(state.copyWith(tokenAddress: address));
  }

  Future<void> updateBar(int bar) async {
    pausePollingLatest();

    final limit = _calculateOptimalLimit(bar);
    emit(state.copyWith(bar: bar, candles: [], from: 0, to: 0, limit: limit));

    // reload candles history
    await getCandlesHistory();

    startPollingLatest();
  }

  int _calculateOptimalLimit(int bar) {
    if (bar <= 60) {
      return 480;
    } else if (bar <= 5 * 60) {
      return 288;
    } else if (bar <= 15 * 60) {
      return 288;
    } else if (bar <= 60 * 60) {
      return 360;
    } else if (bar <= 4 * 60 * 60) {
      return 360;
    } else {
      return 500;
    }
  }

  void updateFrom(int from) {
    emit(state.copyWith(from: from));
  }

  void updateTo(int to) {
    emit(state.copyWith(to: to));
  }

  void updateLatestCandles(KLineEntity? candle) {
    if (candle == null || state.candles.isEmpty) {
      return;
    }

    final newCandles = List<KLineEntity>.from(state.candles);
    final latestCandle = newCandles.lastOrNull;

    if (latestCandle?.time == (candle.time ?? 0)) {
      newCandles[newCandles.length - 1] = candle;
    } else if ((candle.time ?? 0) > (latestCandle?.time ?? 0)) {
      newCandles.add(candle);
    }

    emit(state.copyWith(candles: newCandles));
  }

  void updateLimit(int limit) {
    emit(state.copyWith(limit: limit));
  }
}
