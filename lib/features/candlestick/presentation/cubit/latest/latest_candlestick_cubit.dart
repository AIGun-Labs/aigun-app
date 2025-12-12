import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constant/count.dart';
import '../../../../../core/enums/candle_source.dart';
import '../../../../../core/types/result.dart';
import '../../../../../utils/logger.dart';
import '../../../application/usecases/fetch_latest_candlesticks.dart';
import '../../../domain/entities/get_candlestick_params.dart';
import 'latest_candlestick_state.dart';

class LatestCandlestickCubit extends Cubit<LatestCandlestickState> {
  final FetchLatestCandlesticks _fetchLatestCandlesticks;
  GetCandlestickParams? _params;
  // 代表已经初始化过一次了
  bool _isInitialized = false;
  Timer? _pollingTimer;
  CancelToken? _cancelToken;
  bool _isFetching = false; // 添加标志位

  LatestCandlestickCubit(this._fetchLatestCandlesticks)
    : super(const LatestCandlestickState());

  void updateParams(GetCandlestickParams params) {
    _params = params;
    // 如果更新的参数 地址和网络都变化了，则将初始化标志位设置为 false 则是第一次
    if (params.tokenContractAddress != _params?.tokenContractAddress ||
        params.network != _params?.network) {
      _isInitialized = false;
    }
    _cancelToken?.cancel('update params');
    _cancelToken = CancelToken();
    // 先暂停在进行轮询
    stopPolling();
    startPolling();
  }

  void startPolling() {
    Logger.info('start latest candle polling');
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(
      Duration(seconds: NumericConstants.three),
      (_) => _fetch(),
    );
  }

  void stopPolling() {
    Logger.info('stop latest candle polling');
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  Future<void> _fetch() async {
    if (_isFetching) {
      Logger.info('skip fetch: previous request still in progress');
    }
    if (_params == null) return;

    _isFetching = true;
    final networkValue = _params?.network?.value;
    final ca = _params?.tokenContractAddress;

    _cancelToken ??= CancelToken();

    if (networkValue == null) {
      Logger.error('fetch latest candlestick failed, network is null');
      emit(
        state.copyWith(
          status: FetchLatestCandlestickStatus.error('network is null'),
        ),
      );
      return;
    }

    if (ca == null) {
      Logger.error('fetch latest candlestick failed, contract address is null');
      emit(
        state.copyWith(
          status: FetchLatestCandlestickStatus.error(
            'contract address is null',
          ),
        ),
      );
      return;
    }

    emit(state.copyWith(status: const FetchLatestCandlestickStatus.loading()));

    Logger.info('fetch latest candlestick: $_params');

    // state.source == CandleSource.okx
    final isInitial = state.source == CandleSource.okx
        ? (_isInitialized ? false : true)
        : null;

    final result = await _fetchLatestCandlesticks.call(
      network: networkValue,
      tokenContractAddress: ca,
      bar: _params?.bar,
      limit: _params?.limit,
      cancelToken: _cancelToken,
      // 第一次请求 isInitial 应为 true
      // isInitial: isInitial,
    );

    _isFetching = false; // 请求结束

    result.whenOrNull(
      success: (value) {
        // 如果请求成功之后则将设置为 false
        _isInitialized = true;

        if (value.isNotEmpty && ca == _params?.tokenContractAddress) {
          final latest = value.first;
          Logger.info('fetch latest candlestick success: $latest');
          emit(
            state.copyWith(
              status: FetchLatestCandlestickStatus.success(latest),
              latest: latest,
            ),
          );
        }
      },
      failure: (error) => emit(
        state.copyWith(status: FetchLatestCandlestickStatus.error(error)),
      ),
      be: (reason) => emit(
        state.copyWith(status: FetchLatestCandlestickStatus.error(reason.msg)),
      ),
    );
  }

  @override
  Future<void> close() {
    _pollingTimer?.cancel();
    return super.close();
  }

  void clearData() {
    emit(const LatestCandlestickState());
    _cancelToken?.cancel('clear data');
  }
}
