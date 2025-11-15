import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constant/count.dart';
import '../../core/polling/polling_service.dart';
import '../../core/service_locator.dart';
import '../../data/models/index.dart';
import '../../data/services/api/index.dart';
import '../../data/services/api/token_detail_api.dart';
import '../../data/services/sentry_service.dart';
import '../../utils/logger.dart';
import '../../utils/storage/local/wallet_storage.dart';
import '../../widgets/token/models/token.dart';
import '../candle/candle_cubit.dart';
import 'token_detail_state.dart';

class TokenDetailCubit extends Cubit<TokenDetailState> {
  final CandleCubit _candleCubit;
  PollingService<TokenDetailInfo?>? _infoPollingService;

  TokenDetailCubit(this._candleCubit) : super(TokenDetailState.initial) {
    init();
  }

  void startPollingInfo() {
    _infoPollingService?.stop();

    _infoPollingService = PollingService(
        baseInterval: const Duration(seconds: FIVE),
        fetcher: (cancel) async {
          emit(state.copyWith(
              tokenDetailInfoState: const TokenDetailInfoState.loading()));
          return getTokenDetailInfo();
        },
        onError: (error, stackTrace) {
          emit(state.copyWith(
              tokenDetailInfoState:
                  const TokenDetailInfoState.error('Unknown error')));
          Logger.error("getTokenDetailInfo error: $error");
        },
        onData: (info) {
          if (info != null) {
            // 排除 priceUsd 字段，通过 K 线来进行更新
            emit(state.copyWith(
              tokenDetailInfo: info.excludePriceUsd(info),
            ));
          }
        })
      ..start();
  }

  void pausePollingInfo() {
    _infoPollingService?.stop();
  }

  Future<void> init() async {
    await loadData();
  }

  void updateTokenPriceUsd(double value) {
    emit(state.copyWith(
        tokenDetailInfo: state.tokenDetailInfo?.copyWith(priceUsd: value)));
  }

  Future<void> resetAll() async {
    _candleCubit.resetAll();
    final currenToken = state.token;

    _candleCubit.resetAll();
    pausePollingInfo();

    emit(TokenDetailState.initial
        .copyWith(token: currenToken, tokenAssociatedIntelsPage: 1));
  }

  void updateType(String type) {
    emit(state.copyWith(tokenType: type));
  }

  Future<void> updateToken(Token token) async {
    if (state.token?.address == token.address &&
        state.token?.network == token.network) {
      return;
    }

    await resetAll();
    emit(state.copyWith(token: token));
    await loadData();
    _candleCubit.emit(_candleCubit.state.copyWith(
      network: token.network ?? '',
      tokenAddress: token.address,
    ));

    await _candleCubit.loadData();
  }

  Future<void> getTokenDetailUrls() async {
    if (state.token?.address == null ||
        state.token?.network == null ||
        state.token?.tokenName == null) {
      return;
    }

    try {
      emit(state.copyWith(
          tokenDetailUrlsState: const TokenDetailUrlsState.loading()));

      final tokenDetailUrls = await getIt<TokenDetailApi>().getTokenDetailUrls(
        state.token?.address ?? '',
        state.token?.network ?? '',
      );

      emit(state.copyWith(
          tokenUrls: tokenDetailUrls,
          tokenDetailUrlsState:
              TokenDetailUrlsState.success(tokenDetailUrls!)));
    } catch (e, s) {
      emit(state.copyWith(
          tokenDetailUrlsState: const TokenDetailUrlsState.error()));

      await SentryService().reportError(e, s, tags: {
        "feature": "getTokenDetailUrls"
      }, extra: {
        "address": state.token?.address,
        "network": state.token?.network,
        "tokenName": state.token?.tokenName
      });
    }
  }

  Future<void> updateFromBalance(Token token) async {
    // emit(state.copyWith(
    //     token: Token(
    //   isNative: token.isNative,
    //   chainId: token.chainId,
    //   chainLogo: token.chainLogo,
    //   tokenAvatar: token.tokenAvatar,
    //   tokenName: token.tokenName,
    //   tokenPrice: token.tokenPrice,
    //   balance: token.balance,
    //   decimals: token.decimals,
    //   symbol: token.symbol,
    //   chainName: token.chainName,
    //   address: token.address,
    //   rawBalance: token.rawBalance,
    // )));
    emit(state.copyWith(token: token));

    await loadData();
  }

  Future<void> getTokenIntelCount() async {
    if (state.token?.address == null || state.token?.network == null) {
      return;
    }

    try {
      emit(state.copyWith(
          tokenIntelCountState: const TokenIntelCountState.loading()));

      final tokenIntelCount = await getIt<TokenDetailApi>().getTokenIntelCount(
          state.token?.address ?? '', state.token?.network ?? '');

      emit(state.copyWith(
          tokenIntelCount: tokenIntelCount,
          tokenIntelCountState: TokenIntelCountState.success(tokenIntelCount)));
    } catch (e, s) {
      emit(state.copyWith(
          tokenIntelCountState: TokenIntelCountState.error(e.toString())));

      await SentryService().reportError(e, s, tags: {
        "feature": "getTokenIntelCount"
      }, extra: {
        "address": state.token?.address,
        "network": state.token?.network
      });
    }
  }

  Future<void> refreshAssociatedIntels() async {
    emit(state.copyWith(
      tokenAssociatedIntelsPage: 1,
      tokenAssociatedIntels: [],
      tokenAssociatedIntelsState: const TokenAssociatedIntelsState.loading(),
    ));
    try {
      final tokenAssociatedIntels = await getIt<TokenDetailApi>()
          .getTokenAssociatedIntels(
              state.token?.address ?? '',
              state.token?.network ?? '',
              1,
              state.tokenAssociatedIntelsPageSize);

// 如果 token 是空的，则设置为没有更多
      if (tokenAssociatedIntels.isEmpty) {
        emit(state.copyWith(
          isNotMore: true,
        ));
      } else {
        emit(state.copyWith(
          tokenAssociatedIntels: tokenAssociatedIntels,
        ));
      }

      emit(state.copyWith(
        tokenAssociatedIntelsState:
            TokenAssociatedIntelsState.success(tokenAssociatedIntels),
      ));
    } catch (e, s) {
      await SentryService()
          .reportError(e, s, tags: {"feature": "getTokenAssociatedIntels"});
    }
  }

  Future<void> loadData() async {
    final candleCubit = getIt<CandleCubit>();

    candleCubit.updateAddress(state.token?.address ?? '');
    candleCubit.updateNetwork(state.token?.network ?? '');
    try {
      startPollingInfo();
      await Future.wait([
        getTokenDetailInfo(),
        getTokenProfit(),
        getTokenDetailUrls(),
        getTokenSecurity(),
        getTokenAssociatedIntels(),
        getTokenIntelCount(),
        candleCubit.getCandlesHistory(),
      ], eagerError: false);
    } catch (e) {
      await SentryService().reportError(e, null, tags: {"feature": "loadData"});
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

    emit(state.copyWith(
        tokenAssociatedIntelsState:
            const TokenAssociatedIntelsState.loading()));

    try {
      // Logger.error();

      final tokenAssociatedIntels = await getIt<TokenDetailApi>()
          .getTokenAssociatedIntels(
              state.token?.address ?? '',
              state.token?.network ?? '',
              state.tokenAssociatedIntelsPage,
              state.tokenAssociatedIntelsPageSize);

      if (tokenAssociatedIntels.isEmpty) {
        emit(state.copyWith(
          isNotMore: true,
          tokenAssociatedIntelsState: const TokenAssociatedIntelsState.success([]),
        ));
      } else {
        emit(state.copyWith(
            tokenAssociatedIntelsPage: state.tokenAssociatedIntelsPage + 1,
            isNotMore: tokenAssociatedIntels.isEmpty,
            tokenAssociatedIntels: [
              ...state.tokenAssociatedIntels ?? [],
              ...tokenAssociatedIntels
            ],
            tokenAssociatedIntelsState:
                TokenAssociatedIntelsState.success(tokenAssociatedIntels)));
      }
    } catch (e) {
      emit(state.copyWith(
          tokenAssociatedIntelsState:
              TokenAssociatedIntelsState.error(e.toString())));
      await SentryService().reportError(e, null, tags: {
        "feature": "getTokenAssociatedIntels"
      }, extra: {
        "address": state.token?.address,
        "network": state.token?.network,
        "page": state.tokenAssociatedIntelsPage,
        "tokenAssociatedIntelsPageSize": state.tokenAssociatedIntelsPageSize
      });
    }
  }

  Future<void> getTokenSecurity() async {
    if (state.token?.address == null || state.token?.chainName == null) {
      return;
    }

    try {
      emit(state.copyWith(
          tokenDetailSecurityState: const TokenDetailSecurityState.loading()));

      final tokenDetailSecurity = await getIt<TokenDetailApi>()
          .getTokenSecurity(
              state.token?.address ?? '', state.token?.network ?? '');

      if (tokenDetailSecurity == null) {
        emit(state.copyWith(
            tokenDetailSecurityState:
                const TokenDetailSecurityState.error('Unknown error')));
        return;
      }

      emit(state.copyWith(
          tokenRiskCount: state.allNotSafeCount,
          securitys: tokenDetailSecurity,
          tokenDetailSecurityState:
              TokenDetailSecurityState.success(tokenDetailSecurity)));
    } catch (e, s) {
      emit(state.copyWith(
          tokenDetailSecurityState:
              TokenDetailSecurityState.error(e.toString())));

      await SentryService().reportError(e, s, tags: {
        "feature": "getTokenSecurity"
      }, extra: {
        "network": state.token?.network,
        "address": state.token?.address
      });
    }
  }

  Future<TokenDetailInfo?> getTokenDetailInfo() async {
    // if (state.token?.address == null || state.token?.symbol == null) {
    //   return;
    // }

    // emit(state.copyWith(
    //     tokenDetailInfoState: const TokenDetailInfoState.loading()));

    // try {
    //   final tokenDetailInfo = await getIt<TokenDetailApi>().getTokenDetailInfo(
    //     state.token?.address ?? '',
    //     state.token?.network ?? '',
    //     type: state.tokenType,
    //   );

    //   if (tokenDetailInfo == null) {
    //     emit(state.copyWith(
    //         tokenDetailInfoState:
    //             const TokenDetailInfoState.error('Unknown error')));
    //     return;
    //   }

    //   emit(state.copyWith(
    //       tokenDetailInfo: tokenDetailInfo,
    //       tokenDetailInfoState: TokenDetailInfoState.success(tokenDetailInfo)));
    // } catch (e, s) {
    //   Logger.error("e: $e");
    //   emit(state.copyWith(
    //       tokenDetailInfoState: TokenDetailInfoState.error(e.toString())));
    //   await SentryService().reportError(e, s, tags: {
    //     "feature": "getTokenDetailInfo"
    //   }, extra: {
    //     "network": state.token?.network,
    //     "address": state.token?.address
    //   });
    // } finally {
    //   emit(state.copyWith(
    //       tokenDetailInfoState: const TokenDetailInfoState.initial()));
    // }

    return getIt<TokenDetailApi>().getTokenDetailInfo(
      state.token?.address ?? '',
      state.token?.network ?? '',
      type: state.tokenType,
    );
  }

// 获取代币持仓情况
  Future<void> getTokenProfit() async {
    emit(state.copyWith(tokenProfitState: const TokenProfitState.loading()));
    final wallet = await getIt<WalletStorage>().getSelectedWallet();

    try {
      final tokenProfit = await getIt<UserApi>().getTokenProfit(
          walletId: wallet?.id ?? '',
          address: state.token?.address ?? '',
          network: state.token?.network ?? '');

      emit(state.copyWith(
          tokenProfit: tokenProfit,
          tokenProfitState: TokenProfitState.success(tokenProfit)));
    } catch (e, s) {
      emit(state.copyWith(
          tokenProfitState: TokenProfitState.error(e.toString())));
      await SentryService().reportError(e, s, tags: {
        "feature": "getTokenProfit"
      }, extra: {
        "walletId": wallet?.id,
        "address": state.token?.address,
        "chainId": state.token?.chainId,
        "network": state.token?.network
      });
    } finally {
      emit(state.copyWith(tokenProfitState: const TokenProfitState.initial()));
    }
  }
}
