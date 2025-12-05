import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/hot_token_entity.dart';
import '../../domain/usecases/fetch_hot_tokens.dart';
import '../../domain/usecases/fetch_networks.dart';

part 'hot_token_cubit.freezed.dart';
part 'hot_token_state.dart';

/// 热门代币 Cubit
class HotTokenCubit extends Cubit<HotTokenState> {
  final FetchHotTokens _fetchHotTokens;
  final FetchNetworks _fetchNetworks;
  // String _selectedNetwork = 'all';
  // Map<String, String> _supportedNetworks = {};

  HotTokenCubit(this._fetchHotTokens, this._fetchNetworks)
    : super(const HotTokenState());

  Timer? _pollTimer;

  /// 获取支持的网络列表
  Future<void> _getSupportedNetworks() async {
    try {
      final networksEntity = await _fetchNetworks.call();

      emit(state.copyWith(supportedNetworks: networksEntity.networks));
    } catch (e) {
      emit(
        state.copyWith(status: HotTokenStatus.failure, message: e.toString()),
      );
    }
  }

  Future<void> _getHotTokens() async {
    try {
      final tokens = await _fetchHotTokens.call(state.selectedNetwork);
      emit(state.copyWith(status: HotTokenStatus.success, tokens: tokens));
    } catch (e) {
      emit(
        state.copyWith(status: HotTokenStatus.failure, message: e.toString()),
      );
    }
  }

  Future<void> init() async {
    if (state.status != HotTokenStatus.initial) return;
    emit(state.copyWith(status: HotTokenStatus.loading));
    await _getSupportedNetworks();
    await _getHotTokens();
  }

  Future<void> refresh() async {
    emit(state.copyWith(status: HotTokenStatus.loading));
    await _getHotTokens();
  }

  Future<void> switchNetwork(String network) async {
    emit(
      state.copyWith(status: HotTokenStatus.loading, selectedNetwork: network),
    );
    await _getHotTokens();
  }

  void startPolling() {
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      print('hot token polling');
      _getHotTokens();
    });
  }

  void stopPolling() {
    print('hot token polling stop');
    _pollTimer?.cancel();
    _pollTimer = null;
  }

  @override
  Future<void> close() {
    stopPolling();
    return super.close();
  }
}
