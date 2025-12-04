import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../shared/domain/entities/token_entity.dart';
import '../../../../../shared/domain/mappers/token_mapper.dart';
import '../../../domain/entity/token_info_entity.dart';
import '../../../domain/usecases/fetch_token_detail_info.dart';

part 'token_info_cubit.freezed.dart';
part 'token_info_state.dart';

class TokenInfoCubit extends Cubit<TokenInfoState> {
  final FetchTokenDetailInfo _fetchTokenDetailInfo;

  TokenInfoCubit(this._fetchTokenDetailInfo) : super(const TokenInfoState());

  Timer? _pollingTimer;

  Future<void> setToken(TokenEntity token) async {
    emit(state.copyWith(tokenInfo: token.toTokenInfo()));
  }

  Future<void> _fetch({
    required String address,
    required String network,
    bool isPolling = false,
  }) async {
    if (!isPolling) {
      emit(state.copyWith(status: TokenInfoStatus.loading));
    }
    final result = await _fetchTokenDetailInfo.call(
      address: address,
      network: network,
    );
    if (result.isSuccess) {
      emit(
        state.copyWith(
          status: TokenInfoStatus.success,
          tokenInfo: state.tokenInfo?.copyWith(
            liquidity: result.value?.liquidity ?? '',
            holders: result.value?.holders ?? '0',
            highestIncreaseRate: result.value?.highestIncreaseRate ?? '',
            isMainstream: result.value?.isMainstream ?? false,
            narrative: result.value?.narrative,
            priceChange24h: result.value?.priceChange24h ?? '',
            marketCap: result.value?.marketCap ?? '',
            volume24h: result.value?.volume24h ?? '',
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: TokenInfoStatus.error,
          errorMessage: result.errorMessage!,
        ),
      );
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
