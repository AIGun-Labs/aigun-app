import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../data/models/intel/intel.dart';
import '../../../../../shared/domain/entities/intel_v2_entity.dart';
import '../../../domain/usecases/fetch_intel_count.dart';
import '../../../domain/usecases/fetch_latest_intel_v2.dart';
import '../../../domain/usecases/fetch_token_associated_intels.dart';

part 'intels_cubit.freezed.dart';
part 'intels_state.dart';

class IntelsCubit extends Cubit<IntelsState> {
  final FetchIntelCount _fetchIntelCount;
  final FetchTokenAssociatedIntels _fetchTokenAssociatedIntels;
  final FetchLatestIntelV2 _fetchLatestIntel;

  IntelsCubit(
    this._fetchIntelCount,
    this._fetchTokenAssociatedIntels,
    this._fetchLatestIntel,
  ) : super(const IntelsState());

  Timer? _pollingTimer;

  void init({required String address, required String network}) {
    emit(state.copyWith(network: network, address: address));

    getIntelCount();

    getIntels();

    startPolling();
  }

  Future<void> getIntelCount() async {
    final result = await _fetchIntelCount.call(
      address: state.address,
      network: state.network,
    );
    emit(state.copyWith(count: result.value));
  }

  Future<void> getIntels() async {
    if (state.address.isEmpty || state.network.isEmpty) {
      return;
    }
    if (state.status == IntelsStatus.loading) {
      return;
    }
    emit(state.copyWith(status: IntelsStatus.loading));

    try {
      final tokenAssociatedIntels = await _fetchTokenAssociatedIntels.call(
        address: state.address,
        network: state.network,
        page: state.intelsPage,
        pageSize: state.intelsPageSize,
      );

      if (tokenAssociatedIntels.isEmpty) {
        emit(state.copyWith(isNotMore: true, status: IntelsStatus.success));
      } else {
        emit(
          state.copyWith(
            intelsPage: state.intelsPage + 1,
            isNotMore: tokenAssociatedIntels.isEmpty,
            intels: [...state.intels, ...tokenAssociatedIntels],
            status: IntelsStatus.success,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(status: IntelsStatus.error, errorMessage: e.toString()),
      );
    }
  }

  Future<void> refreshIntels() async {
    emit(
      state.copyWith(intelsPage: 1, intels: [], status: IntelsStatus.loading),
    );
    try {
      final tokenAssociatedIntels = await _fetchTokenAssociatedIntels.call(
        address: state.address,
        network: state.network,
        page: 1,
        pageSize: state.intelsPageSize,
      );
      if (tokenAssociatedIntels.isEmpty) {
        emit(state.copyWith(isNotMore: true, status: IntelsStatus.success));
      } else {
        emit(
          state.copyWith(
            intelsPage: 2,
            intels: tokenAssociatedIntels,
            status: IntelsStatus.success,
          ),
        );
      }

      emit(state.copyWith(status: IntelsStatus.success));
    } catch (e, s) {
      emit(
        state.copyWith(status: IntelsStatus.error, errorMessage: e.toString()),
      );
    }
  }

  Future<void> _getLatestIntel() async {
    final result = await _fetchLatestIntel.call(
      address: state.address,
      network: state.network,
    );
    if (result.isSuccess) {
      emit(state.copyWith(latestIntel: result.value!));
    }
  }

  void startPolling({Duration interval = const Duration(seconds: 10)}) {
    _pollingTimer?.cancel();
    _getLatestIntel();
    _pollingTimer = Timer.periodic(interval, (_) {
      _getLatestIntel();
    });
  }

  void stopPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  @override
  Future<void> close() {
    stopPolling();
    return super.close();
  }
}
