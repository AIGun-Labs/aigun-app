import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_aigun/cubits/candle/candle_state.dart';
import 'package:flutter_aigun/data/models/index.dart';
import 'package:flutter_aigun/data/services/api/candle_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// 时间周期转换为分钟数
final Map<String, int> periodToBar = {
  '1分钟': 1,
  '5分钟': 5,
  '15分钟': 15,
  '30分钟': 30,
  '1小时': 60,
  '4小时': 240,
  '1日': 1440,
  '1周': 10080,
};

class CandleCubit extends Cubit<CandleState> {
  final CandleApi candleApi;
  String? _previousAddress;
  Timer? _timer;

  CandleCubit(this.candleApi) : super(const CandleState()) {
    // 监听 state 变化，当 address 改变时自动获取数据
    stream.listen((state) {
      if (state.tokenAddress.isNotEmpty &&
          state.tokenAddress != _previousAddress &&
          state.network.isNotEmpty) {
        _previousAddress = state.tokenAddress;
        getCandlesHistory();
      }
    });

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      await getLatest();
    });
  }

  Future<void> getCandlesHistory() async {
    if (state.isLoading) {
      return;
    }

    try {
      emit(state.copyWith(isLoading: true));
      final to = DateTime.now().millisecondsSinceEpoch;
      final from = to - (state.bar * 60 * 1000 * 800);

      final candles = await candleApi.getCandlesHistory(
          network: state.network,
          tokenContractAddress: state.tokenAddress,
          bar: state.bar,
          from: from,
          to: to,
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
      final currentEarliest = DateTime.fromMillisecondsSinceEpoch(
          int.tryParse(state.candles.last.time) ?? 0);

      final newFrom = calculatePreviousTimeRange(
          currentFrom: currentEarliest, bar: state.bar, loadCount: 200);

      final candles = await candleApi.getCandlesHistory(
          network: state.network,
          tokenContractAddress: state.tokenAddress,
          bar: state.bar,
          from: newFrom.microsecondsSinceEpoch,
          to: currentEarliest.microsecondsSinceEpoch,
          limit: state.limit);

      emit(state.copyWith(candles: [...state.candles, ...candles.reversed]));
    } catch (e) {
      debugPrint("e: $e");
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> getLatest() async {
    if (state.isLoading) {
      return;
    }

    try {
      emit(state.copyWith(isLoading: true));
      final latests = await candleApi.getCandlesHistory(
          network: state.network,
          tokenContractAddress: state.tokenAddress,
          bar: state.bar,
          isLatest: true,
          limit: state.limit);
      updateLatestCandles(latests.firstOrNull);
    } catch (e) {
      debugPrint("e: $e");
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void updateNetwork(String network) {
    emit(state.copyWith(network: network));
  }

  void updateAddress(String address) {
    emit(state.copyWith(tokenAddress: address));
  }

  Future<void> updateBar(int bar) async {
    emit(state.copyWith(bar: bar));
    await reset();
  }

  Future<void> reset() async {
    emit(state.copyWith(candles: [], isLoading: false));
    await getCandlesHistory();
  }

  void updateFrom(int from) {
    emit(state.copyWith(from: from));
  }

  void updateTo(int to) {
    emit(state.copyWith(to: to));
  }

  void updateLatestCandles(Candle? candle) {
    if (candle == null || state.candles.isEmpty) {
      return;
    }

    final newCandles = List<Candle>.from(state.candles);
    final latestCandle = newCandles.lastOrNull;

    // 如果时间相同,更新现有 K 线
    if (latestCandle?.time == candle.time) {
      newCandles[newCandles.length - 1] = candle;
    }
    // 如果新 K 线时间更晚,添加到最后
    else if (int.parse(candle.time) > int.parse(latestCandle?.time ?? "0")) {
      newCandles.add(candle);
    }

    emit(state.copyWith(candles: newCandles));
  }

  void updateLimit(int limit) {
    emit(state.copyWith(limit: limit));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  void clear() {
    emit(state.copyWith(candles: [], isLoading: false));
  }
}
