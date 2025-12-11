import 'dart:async';

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

  LatestCandlestickCubit(this._fetchLatestCandlesticks)
    : super(const LatestCandlestickState());

  void updateParams(GetCandlestickParams params) {
    _params = params;
    _fetch();
  }

  void startPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(
      Duration(seconds: NumericConstants.five),
      (_) => _fetch(),
    );
  }

  void stopPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  Future<void> _fetch() async {
    if (_params == null) return;

    final networkValue = _params?.network?.value;
    final contractAddress = _params?.tokenContractAddress;

    if (networkValue == null) {
      Logger.error('fetch latest candlestick failed, network is null');
      emit(
        state.copyWith(
          status: FetchLatestCandlestickStatus.error('network is null'),
        ),
      );
      return;
    }

    if (contractAddress == null) {
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

    final result = await _fetchLatestCandlesticks.call(
      network: networkValue,
      tokenContractAddress: contractAddress,
    );

    result.whenOrNull(
      success: (value) {
        if (value.isNotEmpty) {
          final latest = value.first;
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
}
