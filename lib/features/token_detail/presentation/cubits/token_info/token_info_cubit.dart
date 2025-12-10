import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../shared/domain/entities/base_token_entity.dart';
import '../../../domain/entities/token_info_entity.dart';
import '../../../domain/entities/urls_entity.dart';
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

  void init({required BaseTokenEntity token, String? type}) {
    _hasPriceFromCandle = false;
    emit(
      TokenInfoState(
        tokenInfo: TokenInfoEntity(
          base: token,
          holders: '0',
          highestIncreaseRate: '',
          isMainstream: false,
          narrative: null,
        ),
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
    emit(
      state.copyWith(
        tokenInfo: tokenInfo.copyWith(
          base: tokenInfo.base.copyWith(tokenPrice: price),
        ),
      ),
    );
  }

  Future<void> _getTokenDetailInfo({
    required String address,
    required String network,
    bool isPolling = false,
    String? type,
  }) async {
    if (isClosed) return;

    if (!isPolling) {
      emit(state.copyWith(status: TokenInfoStatus.loading));
    }
    final result = await _fetchTokenDetailInfo.call(
      address: address,
      network: network,
      type: type,
    );
    if (isClosed) return;
    if (result.isSuccess) {
      final tokenDetailInfo = result.value;
      final currentTokenInfo = state.tokenInfo;
      if (tokenDetailInfo == null || currentTokenInfo == null) return;

      final apiPrice = tokenDetailInfo.base.tokenPrice;
      emit(
        state.copyWith(
          status: TokenInfoStatus.success,
          tokenInfo: currentTokenInfo.copyWith(
            base: currentTokenInfo.base.copyWith(
              liquidity: tokenDetailInfo.base.liquidity,
              priceChange24h: tokenDetailInfo.base.priceChange24h,
              marketCap: tokenDetailInfo.base.marketCap,
              volume24h: tokenDetailInfo.base.volume24h,
              tokenPrice: (!_hasPriceFromCandle && apiPrice.isNotEmpty)
                  ? apiPrice
                  : (currentTokenInfo.base.tokenPrice),
            ),
            holders: tokenDetailInfo.holders,
            highestIncreaseRate: tokenDetailInfo.highestIncreaseRate,
            isMainstream: tokenDetailInfo.isMainstream,
            narrative: tokenDetailInfo.narrative,
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
