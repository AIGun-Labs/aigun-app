import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constant/count.dart';
import '../../core/polling/polling_service.dart';
import '../../core/service_locator.dart';
import '../../data/models/index.dart';
import '../../data/models/user/profit/profit.dart';
import '../../data/services/api/index.dart';
import '../../data/services/api/token_detail_api.dart';
import '../../data/services/sentry_service.dart';
import '../../utils/extensions/string.dart';
import '../../utils/logger.dart';
import '../../utils/storage/local/wallet_storage.dart';
import '../../widgets/token/models/token.dart';
import '../candle/candle_cubit.dart';
import 'token_detail_state.dart';

class TokenDetailCubit extends Cubit<TokenDetailState> {
  final CandleCubit _candleCubit;
  PollingService<TokenDetailInfo?>? _infoPollingService;
  PollingService<UserProfit?>? _holdingPollingService;

  double? _latestPriceUsdFromCandle;
  double? _latestPriceUsdFromDetail;
  set latestPriceUsdFromCandle(double? value) {
    if (value == _latestPriceUsdFromCandle) return;
    _latestPriceUsdFromCandle = value;
    _updatePriceUsdIfNeeded();
  }

  set latestPriceUsdFromDetail(double? value) {
    if (value == _latestPriceUsdFromDetail) return;
    _latestPriceUsdFromDetail = value;
    _updatePriceUsdIfNeeded();
  }

  TokenDetailCubit(this._candleCubit) : super(TokenDetailState.initial) {
    initialize();

    // TODO: 添加代币持仓轮询
  }

  void _updatePriceUsdIfNeeded() {
    final double tokenPriceUsd =
        _latestPriceUsdFromCandle ??
        _latestPriceUsdFromDetail ??
        state.tokenDetailInfo?.priceUsd ??
        0;

    if (!tokenPriceUsd.toString().isNotEmptyAndZeroValue) return;

    Logger.info('📊 更新代币价格: $tokenPriceUsd');
    emit(
      state.copyWith(
        tokenDetailInfo: state.tokenDetailInfo?.copyWith(
          priceUsd: tokenPriceUsd,
        ),
      ),
    );
  }

  void _startPollingInfo() {
    _infoPollingService?.stop();

    _infoPollingService = PollingService(
      baseInterval: Duration(seconds: NumericConstants.three),
      fetcher: (cancel) => _fetchTokenDetailInfo(),
      onError: _handleInfoError,
      onData: _handleTokenDetialInfo,
    )..start();
  }

  void startPolling() {
    _startPollingHolding();
    _startPollingInfo();
  }

  void stopPolling() {
    _stopPollingHolding();
    _stopInfoPolling();
  }

  void _handleInfoError(Object error, StackTrace? stackTrace) {
    emit(
      state.copyWith(
        tokenDetailInfoState: const TokenDetailInfoState.error('Unknown error'),
      ),
    );
  }

  void _handleTokenDetialInfo(TokenDetailInfo? info) {
    if (info == null) return;
    latestPriceUsdFromDetail = info.priceUsd;

    if (state.tokenDetailInfo == null) {
      emit(
        state.copyWith(
          tokenDetailInfoState: TokenDetailInfoState.success(info),
          tokenDetailInfo: info,
          token: state.token?.copyWith(
            tokenPrice: info.priceUsd.toString(),
            priceChange24h: info.priceChange24h,
            marketCap: info.marketCap,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          tokenDetailInfo: state.tokenDetailInfo?.excludePriceUsd(info),
        ),
      );
    }
  }

  Future<TokenDetailInfo?> _fetchTokenDetailInfo() async {
    Logger.info('_fetchTokenDetailInfo');

    emit(
      state.copyWith(
        tokenDetailInfoState: const TokenDetailInfoState.loading(),
      ),
    );

    return await getIt<TokenDetailApi>().getTokenDetailInfo(
      state.token?.address ?? '',
      state.token?.network ?? '',
      type: state.tokenType,
    );
  }

  void _startPollingHolding() {
    _holdingPollingService?.stop();

    _holdingPollingService = PollingService(
      baseInterval: Duration(seconds: NumericConstants.three),
      fetcher: _fetchUserHolding,
      onError: _handleUserHoldingError,
      onData: _handleUserHolding,
      onFinally: () => emit(
        state.copyWith(tokenProfitState: const TokenProfitState.initial()),
      ),
    )..start();
  }

  void _stopPollingHolding() {
    _holdingPollingService?.stop();
    _holdingPollingService = null;
  }

  /// 获取用户持仓数据
  Future<UserProfit?> _fetchUserHolding(CancelToken cancel) async {
    Logger.info('_fetchUserHolding');

    final wallet = await getIt<WalletStorage>().getSelectedWallet();
    return await getIt<UserApi>().getTokenProfit(
      walletId: wallet?.id ?? '',
      address: state.token?.address ?? '',
      network: state.token?.network ?? '',
    );
  }

  void _handleUserHoldingError(Object e, StackTrace? s) {
    emit(
      state.copyWith(tokenProfitState: TokenProfitState.error(e.toString())),
    );
  }

  /// 处理用户持仓数据
  void _handleUserHolding(UserProfit? result) {
    if (result == null) return;
    emit(
      state.copyWith(
        tokenProfit: result,
        tokenProfitState: TokenProfitState.success(result),
      ),
    );
  }

  void _stopInfoPolling() {
    _infoPollingService?.stop();
    _infoPollingService = null;
  }

  Future<void> initialize() async {
    await loadData();
  }

  Future<void> resetAll() async {
    _candleCubit.resetAll();
    final currenToken = state.token;

    _candleCubit.resetAll();
    stopPolling();

    emit(
      TokenDetailState.initial.copyWith(
        token: currenToken,
        tokenAssociatedIntelsPage: 1,
      ),
    );
    emit(
      TokenDetailState.initial.copyWith(
        token: currenToken,
        tokenAssociatedIntelsPage: 1,
      ),
    );
  }

  void updateType(String type) {
    emit(state.copyWith(tokenType: type));
  }

  /// 标记即将 push 到子页面
  void markPushToSubPage() {
    emit(state.copyWith(isPushedToSubPage: true));
  }

  /// 清除 push 到子页面的标记
  void clearPushToSubPageFlag() {
    emit(state.copyWith(isPushedToSubPage: false));
  }

  Future<void> updateToken(Token token) async {
    if (state.token?.address == token.address &&
        state.token?.network == token.network) {
      return;
    }

    await resetAll();
    emit(state.copyWith(token: token));
    await loadData();
    _candleCubit.emit(
      _candleCubit.state.copyWith(
        network: token.network ?? '',
        tokenAddress: token.address,
      ),
    );

    await _candleCubit.loadData();
  }

  Future<void> getTokenDetailUrls() async {
    if (state.token?.address == null ||
        state.token?.network == null ||
        state.token?.tokenName == null) {
      return;
    }

    try {
      emit(
        state.copyWith(
          tokenDetailUrlsState: const TokenDetailUrlsState.loading(),
        ),
      );

      final tokenDetailUrls = await getIt<TokenDetailApi>().getTokenDetailUrls(
        state.token?.address ?? '',
        state.token?.network ?? '',
      );

      emit(
        state.copyWith(
          tokenUrls: tokenDetailUrls,
          tokenDetailUrlsState: TokenDetailUrlsState.success(tokenDetailUrls!),
        ),
      );
    } catch (e, s) {
      emit(
        state.copyWith(
          tokenDetailUrlsState: const TokenDetailUrlsState.error(),
        ),
      );

      await SentryService().reportError(
        e,
        s,
        tags: {'feature': 'getTokenDetailUrls'},
        extra: {
          'address': state.token?.address,
          'network': state.token?.network,
          'tokenName': state.token?.tokenName,
        },
      );
    }
  }

  Future<void> updateFromBalance(Token token) async {
    emit(state.copyWith(token: token));

    await loadData();
  }

  Future<void> getTokenIntelCount() async {
    if (state.token?.address == null || state.token?.network == null) {
      return;
    }

    try {
      emit(
        state.copyWith(
          tokenIntelCountState: const TokenIntelCountState.loading(),
        ),
      );

      final tokenIntelCount = await getIt<TokenDetailApi>().getTokenIntelCount(
        state.token?.address ?? '',
        state.token?.network ?? '',
      );

      emit(
        state.copyWith(
          tokenIntelCount: tokenIntelCount,
          tokenIntelCountState: TokenIntelCountState.success(tokenIntelCount),
        ),
      );
    } catch (e, s) {
      emit(
        state.copyWith(
          tokenIntelCountState: TokenIntelCountState.error(e.toString()),
        ),
      );

      await SentryService().reportError(
        e,
        s,
        tags: {'feature': 'getTokenIntelCount'},
        extra: {
          'address': state.token?.address,
          'network': state.token?.network,
        },
      );
    }
  }

  Future<void> refreshAssociatedIntels() async {
    emit(
      state.copyWith(
        tokenAssociatedIntelsPage: 1,
        tokenAssociatedIntels: [],
        tokenAssociatedIntelsState: const TokenAssociatedIntelsState.loading(),
      ),
    );
    try {
      final tokenAssociatedIntels = await getIt<TokenDetailApi>()
          .getTokenAssociatedIntels(
            state.token?.address ?? '',
            state.token?.network ?? '',
            1,
            state.tokenAssociatedIntelsPageSize,
          );

      // 如果 token 是空的，则设置为没有更多
      if (tokenAssociatedIntels.isEmpty) {
        emit(state.copyWith(isNotMore: true));
      } else {
        emit(
          state.copyWith(
            tokenAssociatedIntels: tokenAssociatedIntels,
            tokenAssociatedIntelsPage: 2, // 刷新成功后，下次应该请求第2页
          ),
        );
      }

      emit(
        state.copyWith(
          tokenAssociatedIntelsState: TokenAssociatedIntelsState.success(
            tokenAssociatedIntels,
          ),
        ),
      );
    } catch (e, s) {
      await SentryService().reportError(
        e,
        s,
        tags: {'feature': 'getTokenAssociatedIntels'},
      );
    }
  }

  Future<void> loadData() async {
    final candleCubit = getIt<CandleCubit>();

    candleCubit.updateAddress(state.token?.address ?? '');
    candleCubit.updateNetwork(state.token?.network ?? '');
    try {
      startPolling();
      await Future.wait([
        getTokenDetailUrls(),
        getTokenSecurity(),
        getTokenAssociatedIntels(),
        getTokenIntelCount(),
        candleCubit.getCandlesHistory(),
      ], eagerError: false);
    } catch (e) {
      await SentryService().reportError(e, null, tags: {'feature': 'loadData'});
    }
  }

  Future<void> getTokenAssociatedIntels() async {
    if (state.token?.address == null || state.token?.chainName == null) {
      return;
    }
    if (state.tokenAssociatedIntelsState ==
        const TokenAssociatedIntelsState.loading()) {
      return;
    }

    emit(
      state.copyWith(
        tokenAssociatedIntelsState: const TokenAssociatedIntelsState.loading(),
      ),
    );

    try {
      final tokenAssociatedIntels = await getIt<TokenDetailApi>()
          .getTokenAssociatedIntels(
            state.token?.address ?? '',
            state.token?.network ?? '',
            state.tokenAssociatedIntelsPage,
            state.tokenAssociatedIntelsPageSize,
          );

      if (tokenAssociatedIntels.isEmpty) {
        emit(
          state.copyWith(
            isNotMore: true,
            tokenAssociatedIntelsState:
                const TokenAssociatedIntelsState.success([]),
          ),
        );
      } else {
        emit(
          state.copyWith(
            tokenAssociatedIntelsPage: state.tokenAssociatedIntelsPage + 1,
            isNotMore: tokenAssociatedIntels.isEmpty,
            tokenAssociatedIntels: [
              ...state.tokenAssociatedIntels ?? [],
              ...tokenAssociatedIntels,
            ],
            tokenAssociatedIntelsState: TokenAssociatedIntelsState.success(
              tokenAssociatedIntels,
            ),
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          tokenAssociatedIntelsState: TokenAssociatedIntelsState.error(
            e.toString(),
          ),
        ),
      );
      await SentryService().reportError(
        e,
        null,
        tags: {'feature': 'getTokenAssociatedIntels'},
        extra: {
          'address': state.token?.address,
          'network': state.token?.network,
          'page': state.tokenAssociatedIntelsPage,
          'tokenAssociatedIntelsPageSize': state.tokenAssociatedIntelsPageSize,
        },
      );
    }
  }

  Future<void> getTokenSecurity() async {
    if (state.token?.address == null || state.token?.chainName == null) {
      return;
    }

    try {
      emit(
        state.copyWith(
          tokenDetailSecurityState: const TokenDetailSecurityState.loading(),
        ),
      );

      final tokenDetailSecurity = await getIt<TokenDetailApi>()
          .getTokenSecurity(
            state.token?.address ?? '',
            state.token?.network ?? '',
          );

      if (tokenDetailSecurity == null) {
        emit(
          state.copyWith(
            tokenDetailSecurityState: const TokenDetailSecurityState.error(
              'Unknown error',
            ),
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          tokenRiskCount: state.allNotSafeCount,
          securitys: tokenDetailSecurity,
          tokenDetailSecurityState: TokenDetailSecurityState.success(
            tokenDetailSecurity,
          ),
        ),
      );
    } catch (e, s) {
      emit(
        state.copyWith(
          tokenDetailSecurityState: TokenDetailSecurityState.error(
            e.toString(),
          ),
        ),
      );

      await SentryService().reportError(
        e,
        s,
        tags: {'feature': 'getTokenSecurity'},
        extra: {
          'network': state.token?.network,
          'address': state.token?.address,
        },
      );
    }
  }
}
