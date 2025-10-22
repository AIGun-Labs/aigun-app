import 'package:flutter_aigun/cubits/candle/candle_state.dart';
import 'package:flutter_aigun/data/models/index.dart';
import 'package:flutter_aigun/data/services/api/candle_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CandleCubit extends Cubit<CandleState> {
  final CandleApi candleApi;
  CandleCubit(this.candleApi) : super(const CandleState());

  Future<void> getCandlesHistory() async {
    if (state.isLoading) {
      return;
    }

    try {
      final candles = await candleApi.getCandlesHistory(
          network: state.network,
          tokenContractAddress: state.tokenAddress,
          bar: state.bar,
          from: state.from,
          to: state.to,
          limit: state.limit);
      emit(state.copyWith(candles: candles));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> loadMoreLoad() async {
    if (state.isLoading) {
      return;
    }

    try {
      final candles = await candleApi.getCandlesHistory(
          network: state.network,
          tokenContractAddress: state.tokenAddress,
          bar: state.bar,
          from: state.from,
          to: state.to,
          limit: state.limit);
      emit(state.copyWith(candles: candles));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> getLatest() async {
    if (state.isLoading) {
      return;
    }

    try {
      final latests = await candleApi.getCandlesHistory(
          network: state.network,
          tokenContractAddress: state.tokenAddress,
          bar: state.bar,
          isLatest: true,
          limit: state.limit);
      updateLatestCandles(latests.firstOrNull);
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

  void updateBar(double bar) {
    emit(state.copyWith(bar: bar));
  }

  void updateFrom(double from) {
    emit(state.copyWith(from: from));
  }

  void updateTo(double to) {
    emit(state.copyWith(to: to));
  }

  void updateLatestCandles(Candle? candle) {
    if (candle == null) {
      return;
    }

    final candles = [candle, ...state.candles];
    emit(state.copyWith(candles: candles));
  }
}
