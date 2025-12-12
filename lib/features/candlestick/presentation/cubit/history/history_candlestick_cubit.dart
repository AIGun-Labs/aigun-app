import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/types/result.dart';
import '../../../../../utils/logger.dart';
import '../../../application/usecases/fetch_history_candlesticks.dart';
import '../../../domain/entities/get_candlestick_params.dart';
import 'history_candlestick_state.dart';

class HistoryCandlestickCubit extends Cubit<HistoryCandlestickState> {
  final FetchHistoryCandlesticks _fetchHistoryCandlesticks;

  HistoryCandlestickCubit(this._fetchHistoryCandlesticks)
    : super(const HistoryCandlestickState());

  Future<void> fetch(GetCandlestickParams params) async {
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

    emit(state.copyWith(status: const HistoryCandlestickStatus.loading()));
    Logger.info('fetch history candlestick: $params');

    final result = await _fetchHistoryCandlesticks.call(
      network: networkValue,
      tokenContractAddress: contractAddress,
      bar: params.bar,
      limit: params.limit,
      from: params.from,
      to: params.to ?? DateTime.now().millisecondsSinceEpoch ~/ 1000,
    );

    result.whenOrNull(
      success: (source) => emit(
        state.copyWith(
          status: HistoryCandlestickStatus.success(
            source.candles.reversed.toList(),
          ),
          candles: source.candles.reversed.toList(),
          source: source.source,
        ),
      ),
      failure: (msg) =>
          emit(state.copyWith(status: HistoryCandlestickStatus.error(msg))),
      be: (reason) => emit(
        state.copyWith(status: HistoryCandlestickStatus.error(reason.msg)),
      ),
    );
  }
}
