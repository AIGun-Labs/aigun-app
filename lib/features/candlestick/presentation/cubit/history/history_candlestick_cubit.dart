import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/types/result.dart';
import '../../../../../utils/logger.dart';
import '../../../application/usecases/fetch_history_candlesticks.dart';
import '../../../domain/entities/get_candlestick_params.dart';
import '../selection/selection_params_cubit.dart';
import 'history_candlestick_state.dart';

class HistoryCandlestickCubit extends Cubit<HistoryCandlestickState> {
  HistoryCandlestickCubit(
    this._fetchHistoryCandlesticks,
    this._selectionParamsCubit,
  ) : super(const HistoryCandlestickState());
  final FetchHistoryCandlesticks _fetchHistoryCandlesticks;
  final SelectionParamsCubit _selectionParamsCubit;
  CancelToken? _cancelToken;
  GetCandlestickParams? _currentParams;

  Future<void> fetch(GetCandlestickParams params) async {
    _cancelToken?.cancel('fetch history candlestick');
    _cancelToken = CancelToken();

    final networkValue = params.network?.value;
    final contractAddress = params.tokenContractAddress;
    if (networkValue == null) {
      Logger.error('fetch history candlestick failed, network is null');
      emit(
        state.copyWith(
          status: HistoryCandlestickStatus.error('network is null'),
        ),
      );
      return;
    }

    if (contractAddress == null) {
      Logger.error(
        'fetch history candlestick failed, contract address is null',
      );
      emit(
        state.copyWith(
          status: HistoryCandlestickStatus.error('contract address is null'),
        ),
      );
      return;
    }
    _currentParams = params;

    emit(state.copyWith(status: const HistoryCandlestickStatus.loading()));
    Logger.info('fetch history candlestick: $params');

    final to = params.to ?? (DateTime.now().millisecondsSinceEpoch).toString();
    Logger.info('fetch history candlestick to: $to');
    final result = await _fetchHistoryCandlesticks.call(
      network: networkValue,
      tokenContractAddress: contractAddress,
      bar: params.bar,
      limit: params.limit,
      from: params.from,
      to: to,
      cancelToken: _cancelToken,
    );

    result.whenOrNull(
      success: (source) {
        if (source.candles.isEmpty) {
          return emit(
            state.copyWith(status: HistoryCandlestickStatus.error('')),
          );
        }
        emit(state.copyWith(candles: []));
        final newCandles = [
          ...source.candles.reversed,
          ...state.candles,
        ].toList();

        Logger.info('last time: ${newCandles.last.time}');

        // _selectionParamsCubit.updateTo(newCandles.last.time);

        emit(
          state.copyWith(
            status: HistoryCandlestickStatus.success(newCandles),
            candles: newCandles,
            source: source.source,
            hasMore: source.candles.isNotEmpty,
          ),
        );
      },
      failure: (msg) =>
          emit(state.copyWith(status: HistoryCandlestickStatus.error(msg))),
      be: (reason) => emit(
        state.copyWith(status: HistoryCandlestickStatus.error(reason.message)),
      ),
    );
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) {
      Logger.info(
        'loadMore skipped: isLoadingMore=${state.isLoadingMore}, hasMore=${state.hasMore}',
      );
      return;
    }
    if (_currentParams == null || state.earliestTime == null) {
      Logger.error('loadMore failed: no params or no candles');
      return;
    }

    final networkValue = _currentParams!.network?.value;
    final contractAddress = _currentParams!.tokenContractAddress;
    if (networkValue == null || contractAddress == null) {
      Logger.error('loadMore failed: network or contract address is null');
      return;
    }

    _cancelToken?.cancel('load more history candlestick');
    _cancelToken = CancelToken();

    emit(state.copyWith(isLoadingMore: true));
    Logger.info('loadMore: to=${state.earliestTime}');

    final result = await _fetchHistoryCandlesticks.call(
      network: networkValue,
      tokenContractAddress: contractAddress,
      bar: _currentParams!.bar,
      limit: _currentParams!.limit,
      from: null,
      to: state.earliestTime,
      cancelToken: _cancelToken,
    );

    result.whenOrNull(
      success: (source) {
        final hasMore = source.candles.isNotEmpty;
        final newCandles = [
          ...source.candles.reversed, //
          ...state.candles,
        ].toList();

        Logger.info(
          'loadMore success: added ${source.candles.length} candles, hasMore=$hasMore',
        );

        emit(
          state.copyWith(
            candles: newCandles,
            hasMore: hasMore,
            isLoadingMore: false,
          ),
        );
      },
      failure: (msg) {
        Logger.error('loadMore failed: $msg');
        emit(state.copyWith(isLoadingMore: false));
      },
      be: (reason) {
        Logger.error('loadMore BE error: ${reason.message}');
        emit(state.copyWith(isLoadingMore: false));
      },
    );
  }

  void reset() {
    _cancelToken?.cancel('reset');
    _cancelToken = null;
    _currentParams = null;
    emit(state.copyWith(candles: [], hasMore: true, isLoadingMore: false));
  }

  @override
  Future<void> close() {
    _cancelToken?.cancel('cubit closed');
    _cancelToken = null;
    return super.close();
  }
}
