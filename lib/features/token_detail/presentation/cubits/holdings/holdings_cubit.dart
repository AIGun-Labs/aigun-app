import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/token_profit_entity.dart';
import '../../../domain/usecases/fetch_token_profit.dart';

part 'holdings_cubit.freezed.dart';
part 'holdings_state.dart';

class HoldingsCubit extends Cubit<HoldingsState> {
  final FetchTokenProfit _fetchTokenProfit;
  HoldingsCubit(this._fetchTokenProfit) : super(HoldingsState());

  Timer? _pollingTimer;

  Future<void> _fetch({
    required String address,
    required String network,
    bool isPolling = false,
  }) async {
    if (isClosed) return;

    if (!isPolling) {
      emit(HoldingsState(status: HoldingsStatus.loading));
    }
    final result = await _fetchTokenProfit.call(
      address: address,
      network: network,
    );

    if (isClosed) return;

    if (result.isSuccess) {
      emit(
        HoldingsState(
          status: HoldingsStatus.success,
          tokenProfit: result.value!,
        ),
      );
    } else {
      emit(
        HoldingsState(
          status: HoldingsStatus.error,
          errorMessage: result.errorMessage!,
        ),
      );
    }
  }

  void startPolling({
    required String address,
    required String network,
    Duration interval = const Duration(seconds: 3),
  }) {
    _pollingTimer?.cancel();
    _fetch(address: address, network: network, isPolling: false);
    _pollingTimer = Timer.periodic(interval, (_) {
      _fetch(address: address, network: network, isPolling: true);
    });
  }

  void stopPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  @override
  Future<void> close() {
    // TODO: implement close
    stopPolling();

    return super.close();
  }
}
