import 'dart:async';

import 'package:dio/dio.dart';
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
  final CandleApi _candleApi;

  PollingService<KLineEntity?>? _pollingService;

  CandleCubit(this._candleApi) : super(CandleState.initial);

  void startPollingLatest() {
    _pollingService?.stop();

    _pollingService = PollingService<KLineEntity?>(
      baseInterval: Duration(seconds: NumericConstants.five),
      maxInterval: Duration(seconds: NumericConstants.one),
      fetcher: (cancel) async {
        final latestCandle = await _getLatest(cancel);
        return latestCandle;
      },
      onData: (info) {
        if (info != null) {
          Logger.info('📊 收到最新K线数据: ${info.toJson()}');
          updateLatestCandles(info);
          //更新token价格
          getIt<TokenDetailCubit>().latestPriceUsdFromCandle = info.close;
        }
      },
      onError: (error, stackTrace) {
        Logger.error('❌ 获取最新K线数据失败: $error');
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

      Logger.info('📊 请求K线数据: bar=${state.bar}s, limit=${state.limit}');
      Logger.info(
        '📊 时间范围: from=${DateTime.fromMillisecondsSinceEpoch(state.calculatedFrom.toInt())} to=${DateTime.fromMillisecondsSinceEpoch(state.calculatedTo.toInt())}',
      );

      final candles = await _candleApi.getCandlesHistory(
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
        Logger.info('📊 收到 ${candles.length} 条K线数据');
        emit(
          state.copyWith(
            candles: candles.reversed.toList(),
            loadingState: CandlestickLoadingState.loaded,
          ),
        );
      }
    } catch (e) {
      Logger.error('❌ 获取K线数据失败: $e');
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

  Future<KLineEntity?> _getLatest(CancelToken cancel) async {
    late final KLineEntity? latestCandle;

    try {
      final latests = await _candleApi.getCandlesHistory(
        network: state.network,
        tokenContractAddress: state.tokenAddress,
        bar: state.bar,
        isLatest: true,
        limit: state.limit,
        cancel: cancel,
      );
      latestCandle = latests.firstOrNull;
    } catch (e) {
      Logger.error('getLatest: $e');
      return null;
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
    // 暂停轮询以避免与历史数据加载冲突
    pausePollingLatest();

    // 根据时间周期动态调整数据量，确保小周期有足够密集的数据
    final limit = _calculateOptimalLimit(bar);
    emit(state.copyWith(bar: bar, candles: [], from: 0, to: 0, limit: limit));

    // reload candles history
    await getCandlesHistory();

    // 重新启动轮询
    startPollingLatest();
  }

  /// 根据 bar（秒）计算最优的数据条数
  /// 目标：小周期显示最近几小时，大周期显示更长时间
  int _calculateOptimalLimit(int bar) {
    if (bar <= 60) {
      // 1分钟：显示最近8小时 = 480条
      return 480;
    } else if (bar <= 5 * 60) {
      // 5分钟：显示最近24小时 = 288条
      return 288;
    } else if (bar <= 15 * 60) {
      // 15分钟：显示最近3天 = 288条
      return 288;
    } else if (bar <= 60 * 60) {
      // 1小时：显示最近15天 = 360条
      return 360;
    } else if (bar <= 4 * 60 * 60) {
      // 4小时：显示最近2个月 = 360条
      return 360;
    } else {
      // 1天及以上：显示最近1-2年 = 500条
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

    // 如果时间相同,更新现有 K 线
    if (latestCandle?.time == (candle.time ?? 0)) {
      newCandles[newCandles.length - 1] = candle;
    }
    // 如果新 K 线时间更晚,添加到最后
    else if ((candle.time ?? 0) > (latestCandle?.time ?? 0)) {
      newCandles.add(candle);
    }

    // 更新本地状态
    // _priceUpdateController.add(candle.close);

    emit(state.copyWith(candles: newCandles));
  }

  void updateLimit(int limit) {
    emit(state.copyWith(limit: limit));
  }
}
