import 'package:flutter_aigun/cubits/candle/candle_cubit.dart';
import 'package:flutter_aigun/cubits/token_detail/token_detail_state.dart';
import 'package:flutter_aigun/data/models/intel/intel.dart';
import 'package:flutter_aigun/data/models/token_detail/index.dart';
import 'package:flutter_aigun/data/services/api/index.dart';
import 'package:flutter_aigun/data/services/api/token_detail_api.dart';
import 'package:flutter_aigun/data/services/sentry_service.dart';
import 'package:flutter_aigun/enums/token_security_type.dart';
import 'package:flutter_aigun/utils/retry_utils.dart';
import 'package:flutter_aigun/utils/storage/local/wallet_storage.dart';
import 'package:flutter_aigun/utils/token_utils.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/service_locator.dart';

class TokenDetailCubit extends Cubit<TokenDetailState> {
  final CandleCubit candleCubit;

  TokenDetailCubit(this.candleCubit) : super(const TokenDetailState()) {
    init();
  }

  num get riskAmount =>
      state.securitys?.contractAnaly
          .where((element) =>
              element.isSafe == false &&
              element.type == TokenSecurityType.risk.type)
          .length ??
      0;

  num get warningAmount =>
      state.securitys?.contractAnaly
          .where((element) =>
              element.isSafe == false &&
              element.type == TokenSecurityType.attention.type)
          .length ??
      0;

  int getAllNotSafeCount() =>
      state.securitys?.contractAnaly
          .where((element) => element.isSafe == false)
          .length ??
      0;

  List<SecurityItem> get tokenDetailSecuritys =>
      state.securitys?.contractAnaly
          .where((element) =>
              element.isSafe == false &&
              element.type == TokenSecurityType.risk.name)
          .toList() ??
      [];

  int getNotSecurityCount() {
    return state.securitys?.contractAnaly
            .where((element) => element.isSafe == false)
            .length ??
        0;
  }

  Future<void> init() async {
    await loadData();
  }

  Future<void> updateToken(Token token) async {
    reset();
    emit(state.copyWith(token: token));

    // update k line params
    // candleCubit.updateNetwork(token.slug ?? token.network ?? '');
    // candleCubit.updateAddress(token.address);
    candleCubit.emit(candleCubit.state.copyWith(
      network: token.network ?? '',
      tokenAddress: token.address,
    ));

    await candleCubit.getCandlesHistory();

    await loadData();
  }

  void reset() {
    emit(state.copyWith(
        tokenIntelCount: 0,
        tokenRiskCount: 0,
        tokenAssociatedIntels: [],
        isNotMore: false,
        tokenAssociatedIntelsState: const TokenAssociatedIntelsState.initial(),
        tokenAssociatedIntelsPage: 1));

    candleCubit.clear();
  }

  Future<void> getTokenDetailUrls() async {
    if (state.token?.address == null ||
        state.token?.slug == null ||
        state.token?.tokenName == null) {
      return;
    }

    final newSlug = (state.token?.slug?.isEmpty ?? true)
        ? TokenUtils.getTokenSlugByValue(state.token?.chainName ?? "")
        : state.token!.slug;
    try {
      emit(state.copyWith(
          tokenDetailUrlsState: const TokenDetailUrlsState.loading()));

      final tokenDetailUrls = await getIt<TokenDetailApi>().getTokenDetailUrls(
          state.token?.address ?? '',
          newSlug ?? '',
          state.token?.tokenName ?? '');

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
        "slug": state.token?.slug,
        "tokenName": state.token?.tokenName
      });
    }
  }

  Future<void> updateFromBalance(Token token) async {
    emit(state.copyWith(
        token: Token(
      chainId: token.chainId,
      chainLogo: token.chainLogo,
      tokenAvatar: token.tokenAvatar,
      tokenName: token.tokenName,
      tokenPrice: token.tokenPrice,
      balance: token.balance,
      decimals: token.decimals,
      symbol: token.symbol,
      chainName: token.chainName,
      address: token.address,
      rawBalance: token.balance,
    )));

    await loadData();
  }

  Future<void> getTokenIntelCount() async {
    if (state.token?.address == null || state.token?.slug == null) {
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
    getTokenSecurity();
    getTokenDetailInfo();
    getTokenAssociatedIntels();
    getTokenDetailUrls();
    getTokenIntelCount();
    getTokenProfit();
    // getUserTokenHoldings();
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
      final tokenAssociatedIntels = await getIt<TokenDetailApi>()
          .getTokenAssociatedIntels(
              state.token?.address ?? '',
              state.token?.network ?? '',
              state.tokenAssociatedIntelsPage,
              state.tokenAssociatedIntelsPageSize);

      if (tokenAssociatedIntels.isEmpty) {
        emit(state.copyWith(
          isNotMore: true,
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

      await RetryUtils.executeWithRetryAndCallback(
        operation: () => getIt<TokenDetailApi>().getTokenSecurity(
            state.token?.address ?? '', state.token?.network ?? ''),
        onSuccess: (tokenDetailSecurity) async {
          // 成功
          if (tokenDetailSecurity == null) {
            emit(state.copyWith(
                tokenRiskCount: 0,
                securitys: null,
                tokenDetailSecurityState:
                    const TokenDetailSecurityState.error('Unknown error')));

            await SentryService().reportError(
                "get token security failure", null, tags: {
              "feature": "getTokenSecurity"
            }, extra: {
              "address": state.token?.address,
              "network": state.token?.network
            });
          } else {
            final allNotSafeCount = getAllNotSafeCount();
            emit(state.copyWith(
                tokenRiskCount: allNotSafeCount,
                securitys: tokenDetailSecurity,
                tokenDetailSecurityState:
                    TokenDetailSecurityState.success(tokenDetailSecurity)));
          }
        },
        onError: (error) async {
          emit(state.copyWith(
              tokenRiskCount: 0,
              tokenDetailSecurityState:
                  TokenDetailSecurityState.error(error ?? 'Unknown error')));

          await SentryService().reportError(error, null, tags: {
            "feature": "getTokenSecurity"
          }, extra: {
            "address": state.token?.address,
            "network": state.token?.network
          });
        },
        // 如果tokenDetailSecurity为空，则重试
        shouldRetry: (tokenDetailSecurity) {
          return tokenDetailSecurity == null;
        },
        maxRetries: 3,
        retryDelay: const Duration(seconds: 1),
      );
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

  Future<void> getTokenDetailInfo() async {
    if (state.token?.address == null || state.token?.symbol == null) {
      return;
    }

    emit(state.copyWith(
        tokenDetailInfoState: const TokenDetailInfoState.loading()));

    try {
      final tokenDetailInfo = await getIt<TokenDetailApi>().getTokenDetailInfo(
        state.token?.address ?? '',
        state.token?.network ?? '',
        type: state.tokenType,
      );

      if (tokenDetailInfo == null) {
        emit(state.copyWith(
            tokenDetailInfoState:
                const TokenDetailInfoState.error('Unknown error')));
        return;
      }

      emit(state.copyWith(
          tokenDetailInfo: tokenDetailInfo,
          tokenDetailInfoState: TokenDetailInfoState.success(tokenDetailInfo)));
    } catch (e, s) {
      emit(state.copyWith(
          tokenDetailInfoState: TokenDetailInfoState.error(e.toString())));
      await SentryService().reportError(e, s, tags: {
        "feature": "getTokenDetailInfo"
      }, extra: {
        "network": state.token?.network,
        "address": state.token?.address
      });
    }
  }

// 获取代币持仓情况
  Future<void> getTokenProfit() async {
    final wallet = await getIt<WalletStorage>().getSelectedWallet();

    try {
      final tokenProfit = await getIt<UserApi>().getTokenProfit(
          walletId: wallet?.id ?? '',
          address: state.token?.address ?? '',
          // chainId: state.token?.chainId ?? '',
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
    }
  }
}
