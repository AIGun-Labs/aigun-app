import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_aigun/core/polling/polling_service.dart';
import 'package:flutter_aigun/cubits/candle/candle_state.dart';
import 'package:flutter_aigun/data/services/api/candle_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_chart/flutter_k_chart.dart';

class CandleCubit extends Cubit<CandleState> {
  final CandleApi candleApi;

  PollingService<KLineEntity?>? _pollingService;

  CandleCubit(this.candleApi) : super(CandleState.initial);

  void startPollingLatest() {
    _pollingService?.stop();

    _pollingService = PollingService<KLineEntity?>(
        baseInterval: const Duration(seconds: 5),
        maxInterval: const Duration(seconds: 1),
        fetcher: (cancel) async {
          final latestCandle = await getLatest(cancel);
          return latestCandle;
        },
        onData: (info) {
          if (info != null) {
            updateLatestCandles(info);
          }
        },
        pauseOnBackground: true)
      ..start();
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
    if (state.isLoading) {
      return;
    }

    try {
      emit(state.copyWith(isLoading: true));

      final candles = await candleApi.getCandlesHistory(
          network: state.network,
          tokenContractAddress: state.tokenAddress,
          bar: state.bar,
          from: state.calculatedFrom,
          to: state.calculatedTo,
          limit: state.limit);
      emit(state.copyWith(candles: candles.reversed.toList()));
    } catch (e) {
      debugPrint("e: $e");
    } finally {
      emit(state.copyWith(isLoading: false));
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

  Future<void> loadMoreLoad() async {
    if (state.isLoading) {
      return;
    }

    try {
      emit(state.copyWith(isLoading: true));
      final currentEarliest =
          DateTime.fromMillisecondsSinceEpoch(state.candles.last.time ?? 0);

      final newFrom = calculatePreviousTimeRange(
          currentFrom: currentEarliest, bar: state.bar, loadCount: 200);

      final candles = await candleApi.getCandlesHistory(
          network: state.network,
          tokenContractAddress: state.tokenAddress,
          bar: state.bar,
          from: newFrom.microsecondsSinceEpoch,
          to: currentEarliest.microsecondsSinceEpoch,
          limit: state.limit);

      final newCandles = candles.reversed.toList();

      emit(state.copyWith(candles: [...state.candles, ...newCandles]));
    } catch (e) {
      debugPrint("e: $e");
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<KLineEntity?> getLatest(CancelToken cancel) async {
    if (state.isLoading) {
      return null;
    }
    late final KLineEntity? latestCandle;

    try {
      emit(state.copyWith(isLoading: true));
      final latests = await candleApi.getCandlesHistory(
          network: state.network,
          tokenContractAddress: state.tokenAddress,
          bar: state.bar,
          isLatest: true,
          limit: state.limit,
          cancel: cancel);
      latestCandle = latests.firstOrNull;
    } catch (e) {
      debugPrint("e: $e");
      return null;
    } finally {
      emit(state.copyWith(isLoading: false));
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
    emit(state.copyWith(bar: bar));
    // reload candles history
    await getCandlesHistory();
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

    // 如果时间相同,更新现有 K 线
    if (latestCandle?.time == (candle.time ?? 0)) {
      newCandles[newCandles.length - 1] = candle;
    }
    // 如果新 K 线时间更晚,添加到最后
    else if ((candle.time ?? 0) > (latestCandle?.time ?? 0)) {
      newCandles.add(candle);
    }

    emit(state.copyWith(candles: newCandles));
  }

  void updateLimit(int limit) {
    emit(state.copyWith(limit: limit));
  }
}
