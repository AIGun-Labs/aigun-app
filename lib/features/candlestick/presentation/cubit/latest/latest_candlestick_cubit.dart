import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constant/count.dart';
import '../../../../../core/types/result.dart';
import '../../../../../utils/logger.dart';
import '../../../application/usecases/fetch_latest_candlesticks.dart';
import '../../../domain/entities/get_candlestick_params.dart';
import 'latest_candlestick_state.dart';

class LatestCandlestickCubit extends Cubit<LatestCandlestickState> {
  final FetchLatestCandlesticks _fetchLatestCandlesticks;
  GetCandlestickParams? _params;
  Timer? _pollingTimer;
  bool _isFetching = false;

  CancelToken? _cancelToken;

  LatestCandlestickCubit(this._fetchLatestCandlesticks)
    : super(const LatestCandlestickState());

  void updateParams(GetCandlestickParams params) {
    _params = params;
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
    if (_params == null) return;
    if (_isFetching) return;
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
      _isFetching = false;
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
      _isFetching = false;
      return;
    }

    emit(state.copyWith(status: const FetchLatestCandlestickStatus.loading()));

    Logger.info('fetch latest candlestick: $_params');

    try {
      final result = await _fetchLatestCandlesticks.call(
        network: networkValue,
        tokenContractAddress: ca,
        bar: _params?.bar,
        limit: _params?.limit,
        cancelToken: _cancelToken,
      );

      result.whenOrNull(
        success: (value) {
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
    } finally {
      _isFetching = false;
    }
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
