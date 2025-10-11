import 'package:flutter_aigun/core/cubit_locator.dart';
import 'package:flutter_aigun/cubits/token_detail/token_detail_state.dart';
import 'package:flutter_aigun/data/models/intel/intel.dart';
import 'package:flutter_aigun/data/models/token_detail/index.dart';
import 'package:flutter_aigun/data/services/api/index.dart';
import 'package:flutter_aigun/data/services/api/token_detail_api.dart';
import 'package:flutter_aigun/data/services/sentry_service.dart';
import 'package:flutter_aigun/enums/token_security_type.dart';
import 'package:flutter_aigun/utils/logger.dart';
import 'package:flutter_aigun/utils/retry_utils.dart';
import 'package:flutter_aigun/utils/storage/local/wallet_storage.dart';
import 'package:flutter_aigun/utils/token_utils.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TokenDetailCubit extends Cubit<TokenDetailState> {
  TokenDetailCubit() : super(const TokenDetailState()) {
    init();
  }

  num get riskAmount =>
      state.securitys?.contractAnaly
          .where((element) =>
              element.isSafe == false &&
              element.type == TokenSecurityType.risk.name)
          .length ??
      0;

  num get warningAmount =>
      state.securitys?.contractAnaly
          .where((element) =>
              element.isSafe == false &&
              element.type == TokenSecurityType.warning.name)
          .length ??
      0;

  List<SecurityItem> get tokenDetailSecuritys =>
      state.securitys?.contractAnaly
          .where((element) =>
              element.isSafe == false &&
              element.type == TokenSecurityType.risk.name)
          .toList() ??
      [];

  Future<void> init() async {
    await loadData();
  }

  Future<void> updateToken(Token token) async {
    emit(state.copyWith(token: token));
    reset();
    await loadData();
  }

  void reset() {
    emit(state.copyWith(tokenIntelCount: 0, tokenRiskCount: 0));
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

  // Future<void> getUserTokenHoldings() async {
  //   emit(state.copyWith(
  //     tokenHoldingsState: const TokenHoldingsState.loading(),
  //   ));
  //   try {
  //     final tokenHoldings = await getIt<UserApi>()
  //         .getUserTokenHoldingsByAddress(
  //             address: state.token?.address ?? '',
  //             chainName: state.token?.chainName ?? '');

  //     emit(state.copyWith(
  //       tokenHoldings: tokenHoldings,
  //       tokenHoldingsState: TokenHoldingsState.success(tokenHoldings),
  //     ));
  //   } catch (e) {
  //     emit(state.copyWith(
  //       tokenHoldings: [],
  //       tokenHoldingsState: TokenHoldingsState.error(e.toString()),
  //     ));
  //   }
  // }

  Future<void> getTokenIntelCount() async {
    if (state.token?.address == null || state.token?.slug == null) {
      return;
    }
    final newSlug = (state.token?.slug?.isEmpty ?? true)
        ? TokenUtils.getTokenSlugByValue(state.token?.chainName ?? "")
        : state.token!.slug;
    try {
      emit(state.copyWith(
          tokenIntelCountState: const TokenIntelCountState.loading()));

      final tokenIntelCount = await getIt<TokenDetailApi>()
          .getTokenIntelCount(state.token?.address ?? '', newSlug);

      emit(state.copyWith(
          tokenIntelCount: tokenIntelCount,
          tokenIntelCountState: TokenIntelCountState.success(tokenIntelCount)));
    } catch (e, s) {
      emit(state.copyWith(
          tokenIntelCountState: TokenIntelCountState.error(e.toString())));

      await SentryService().reportError(e, s,
          tags: {"feature": "getTokenIntelCount"},
          extra: {"address": state.token?.address, "slug": newSlug});
    }
  }

  Future<void> refreshAssociatedIntels() async {
    emit(state.copyWith(
      tokenAssociatedIntelsPage: 1,
      tokenAssociatedIntels: [],
      tokenAssociatedIntelsState: const TokenAssociatedIntelsState.loading(),
    ));
    try {
      final newSlug = (state.token?.slug?.isEmpty ?? true)
          ? TokenUtils.getTokenSlugByValue(state.token?.chainName ?? "")
          : state.token!.slug;

      final tokenAssociatedIntels = await getIt<TokenDetailApi>()
          .getTokenAssociatedIntels(state.token?.address ?? '', newSlug, 1,
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

    emit(state.copyWith(
        tokenAssociatedIntelsState:
            const TokenAssociatedIntelsState.loading()));
    final currentIntelLength = state.tokenAssociatedIntels?.length ?? 0;
    final newSlug = (state.token?.slug?.isEmpty ?? true)
        ? TokenUtils.getTokenSlugByValue(state.token?.chainName ?? "")
        : state.token!.slug;
    final page = currentIntelLength ~/ state.tokenAssociatedIntelsPageSize + 1;

    try {
      final tokenAssociatedIntels = await getIt<TokenDetailApi>()
          .getTokenAssociatedIntels(state.token?.address ?? '', newSlug, page,
              state.tokenAssociatedIntelsPageSize);

      if (tokenAssociatedIntels.isEmpty) {
        emit(state.copyWith(isNotMore: true));
      } else {
        emit(state.copyWith(isNotMore: false));
      }

// 合并 tokenAssociatedIntels
      final List<Intel> newTokenAssociatedIntels = [
        ...state.tokenAssociatedIntels ?? [],
        ...tokenAssociatedIntels,
      ];

      emit(state.copyWith(
          tokenAssociatedIntels: newTokenAssociatedIntels,
          tokenAssociatedIntelsState:
              TokenAssociatedIntelsState.success(newTokenAssociatedIntels)));
    } catch (e) {
      emit(state.copyWith(
          tokenAssociatedIntelsState:
              TokenAssociatedIntelsState.error(e.toString())));
      await SentryService().reportError(e, null, tags: {
        "feature": "getTokenAssociatedIntels"
      }, extra: {
        "address": state.token?.address,
        "slug": newSlug,
        "page": page,
        "tokenAssociatedIntelsPageSize": state.tokenAssociatedIntelsPageSize
      });
    }
  }

  Future<void> getTokenSecurity() async {
    if (state.token?.address == null || state.token?.chainName == null) {
      return;
    }

    final newSlug = (state.token?.slug?.isEmpty ?? true)
        ? TokenUtils.getTokenSlugByValue(state.token?.chainName ?? "")
        : state.token!.slug;
    try {
      emit(state.copyWith(
          tokenDetailSecurityState: const TokenDetailSecurityState.loading()));

      await RetryUtils.executeWithRetryAndCallback(
        operation: () => getIt<TokenDetailApi>()
            .getTokenSecurity(state.token?.address ?? '', newSlug),
        onSuccess: (tokenDetailSecurity) {
          // 成功
          if (tokenDetailSecurity == null) {
            emit(state.copyWith(
                tokenRiskCount: 0,
                securitys: null,
                tokenDetailSecurityState:
                    const TokenDetailSecurityState.error('Unknown error')));
          } else {
            emit(state.copyWith(
                // 获取代币风险项数量
                tokenRiskCount: tokenDetailSecurity.contractAnaly
                    .where(
                      (element) => element.type == TokenSecurityType.risk.name,
                    )
                    .length,
                securitys: tokenDetailSecurity,
                tokenDetailSecurityState:
                    TokenDetailSecurityState.success(tokenDetailSecurity)));
          }
        },
        onError: (error) async {
          emit(state.copyWith(
              tokenDetailSecurityState:
                  TokenDetailSecurityState.error(error ?? 'Unknown error')));

          await SentryService().reportError(error, null,
              tags: {"feature": "getTokenSecurity"},
              extra: {"address": state.token?.address, "slug": newSlug});
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

      await SentryService().reportError(e, s,
          tags: {"feature": "getTokenSecurity"},
          extra: {"slug": newSlug, "address": state.token?.address});
    }
  }

  Future<void> getTokenDetailInfo() async {
    if (state.token?.address == null || state.token?.symbol == null) {
      return;
    }

    emit(state.copyWith(
        tokenDetailInfoState: const TokenDetailInfoState.loading()));
    final newSlug = (state.token?.slug?.isEmpty ?? true)
        ? TokenUtils.getTokenSlugByValue(state.token?.chainName ?? "")
        : state.token!.slug;
    try {
      final tokenDetailInfo = await getIt<TokenDetailApi>()
          .getTokenDetailInfo(state.token?.address ?? '', newSlug);

// 如果获取的 tokenDetailInfo 为空，则设置为错误状态
      if (tokenDetailInfo == null) {
        emit(state.copyWith(
            tokenDetailInfoState:
                const TokenDetailInfoState.error('Unknown error')));
        return;
      }

      // 如果获取的 tokenDetailInfo 不为空，则设置为成功状态
      emit(state.copyWith(
          tokenDetailInfo: tokenDetailInfo,
          tokenDetailInfoState: TokenDetailInfoState.success(tokenDetailInfo)));
    } catch (e, s) {
      emit(
        state.copyWith(
          tokenDetailInfoState: TokenDetailInfoState.error(e.toString())));
      await SentryService().reportError(e, s,
          tags: {"feature": "getTokenDetailInfo"},
          extra: {"slug": newSlug, "address": state.token?.address});
    }
  }

// 获取代币持仓情况
  Future<void> getTokenProfit() async {
    final newSlug = (state.token?.slug?.isEmpty ?? true)
        ? TokenUtils.getTokenSlugByValue(state.token?.chainName ?? "")
        : state.token!.slug;
    final wallet = await getIt<WalletStorage>().getSelectedWallet();

    try {
      final tokenProfit = await getIt<UserApi>().getTokenProfit(
          walletId: wallet?.id ?? '',
          address: state.token?.address ?? '',
          chainId: state.token?.chainId.toString() ?? '',
          network: newSlug ?? '');

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
        "network": newSlug
      });
    }
  }
}
