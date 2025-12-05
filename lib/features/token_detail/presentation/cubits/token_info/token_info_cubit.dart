import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../shared/domain/entities/token_entity.dart';
import '../../../../../shared/domain/mappers/token_entity_mapper.dart';
import '../../../domain/entity/token_info_entity.dart';
import '../../../domain/entity/urls_entity.dart';
import '../../../domain/usecases/fetch_token_detail_info.dart';
import '../../../domain/usecases/fetch_urls.dart';

part 'token_info_cubit.freezed.dart';
part 'token_info_state.dart';

class TokenInfoCubit extends Cubit<TokenInfoState> {
  final FetchTokenDetailInfo _fetchTokenDetailInfo;
  final FetchUrls _fetchUrls;

  TokenInfoCubit(this._fetchTokenDetailInfo, this._fetchUrls)
    : super(const TokenInfoState());

  Timer? _pollingTimer;

  bool _hasPriceFromCandle = false;

  void init({required TokenEntity token, String? type}) {
    _hasPriceFromCandle = false;
    emit(
      state.copyWith(
        tokenInfo: token.toTokenInfo(),
        tokenType: type,
        address: token.address,
        network: token.network,
      ),
    );

    startPolling();
    _getUrls();
  }

  void updateTokenPrice(String price) {
    final tokenInfo = state.tokenInfo;

    if (tokenInfo == null) return;

    _hasPriceFromCandle = true;
    emit(state.copyWith(tokenInfo: tokenInfo.copyWith(tokenPrice: price)));
  }

  Future<void> _getTokenDetailInfo({
    required String address,
    required String network,
    bool isPolling = false,
    String? type,
  }) async {
    if (!isPolling) {
      emit(state.copyWith(status: TokenInfoStatus.loading));
    }
    final result = await _fetchTokenDetailInfo.call(
      address: address,
      network: network,
      type: type,
    );
    if (result.isSuccess) {
      final apiPrice = result.value?.tokenPrice;
      final currentTokenInfo = state.tokenInfo;
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
            tokenPrice:
                (!_hasPriceFromCandle &&
                    apiPrice != null &&
                    apiPrice.isNotEmpty)
                ? apiPrice
                : (currentTokenInfo?.tokenPrice ?? ''),
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

  void startPolling({Duration interval = const Duration(seconds: 3)}) {
    _pollingTimer?.cancel();
    _getTokenDetailInfo(
      address: state.address,
      network: state.network,
      isPolling: false,
      type: state.tokenType,
    );
    _pollingTimer = Timer.periodic(interval, (_) {
      _getTokenDetailInfo(
        address: state.address,
        network: state.network,
        isPolling: true,
        type: state.tokenType,
      );
    });
  }

  void stopPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  Future<void> _getUrls() async {
    final result = await _fetchUrls.call(
      address: state.address,
      network: state.network,
    );
    if (result.isSuccess) {
      emit(state.copyWith(urls: result.value!));
    }
  }

  @override
  Future<void> close() {
    stopPolling();
    return super.close();
  }
}
