import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../shared/domain/entities/intel_v2_entity.dart';
import '../../../domain/usecases/fetch_latest_intel_v2.dart';

part 'latest_intel_cubit.freezed.dart';
part 'latest_intel_state.dart';

class LatestIntelCubit extends Cubit<LatestIntelState> {
  final FetchLatestIntelV2 _fetchLatestIntel;

  Timer? _pollingTimer;

  LatestIntelCubit(this._fetchLatestIntel) : super(LatestIntelState.initial());

  Future<void> _fetch({
    required String address,
    required String network,
    bool isPolling = false,
  }) async {
    if (!isPolling) {
      emit(const LatestIntelState.loading());
    }
    final result = await _fetchLatestIntel.call(
      address: address,
      network: network,
    );
    if (result.isSuccess) {
      emit(LatestIntelState.success(result.value!));
    } else {
      emit(LatestIntelState.error(result.errorMessage!));
    }
  }

  void startPolling({
    required String address,
    required String network,
    Duration interval = const Duration(seconds: 10),
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
    _pollingTimer?.cancel();
    return super.close();
  }
}
