import 'package:flutter_aigun/core/cubit_locator.dart';
import 'package:flutter_aigun/cubits/token_detail/token_detail_state.dart';
import 'package:flutter_aigun/data/models/intel/intel.dart';
import 'package:flutter_aigun/data/services/api/token_detail_api.dart';
import 'package:flutter_aigun/utils/logger.dart';
import 'package:flutter_aigun/utils/retry_utils.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:flutter_aigun/data/models/wallet/token/token.dart'
    as BalanceToken;
import 'package:flutter_bloc/flutter_bloc.dart';

class TokenDetailCubit extends Cubit<TokenDetailState> {
  TokenDetailCubit() : super(const TokenDetailState()) {
    init();
  }

  Future<void> init() async {
    await loadData();
  }

  Future<void> updateToken(Token token) async {
    emit(state.copyWith(token: token));
    await loadData();
  }

  Future<void> updateFromBalance(BalanceToken.Token token) async {
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
      address: token.tokenAddress,
      rawBalance: token.balance,
    )));

    await loadData();
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
              state.token?.chainName ?? '',
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
    } catch (e) {
      Logger.error("refreshAssociatedIntels error: $e");
    }
  }

  Future<void> loadData() async {
    getTokenSecurity();
    getTokenDetailInfo();
    getTokenAssociatedIntels();
  }

  Future<void> getTokenAssociatedIntels() async {
    if (state.token?.address == null || state.token?.chainName == null) {
      return;
    }

    emit(state.copyWith(
        tokenAssociatedIntelsState:
            const TokenAssociatedIntelsState.loading()));

    try {
      final currentIntelLength = state.tokenAssociatedIntels?.length ?? 0;

      final page =
          currentIntelLength ~/ state.tokenAssociatedIntelsPageSize + 1;

      final tokenAssociatedIntels = await getIt<TokenDetailApi>()
          .getTokenAssociatedIntels(
              state.token?.address ?? '',
              state.token?.chainName.toLowerCase() ?? '',
              page,
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
            state.token?.address ?? '', state.token?.chainName ?? ''),
        onSuccess: (tokenDetailSecurity) {
          // 成功
          if (tokenDetailSecurity == null) {
            emit(state.copyWith(
                tokenDetailSecurityState:
                    const TokenDetailSecurityState.error('Unknown error')));
          } else {
            emit(state.copyWith(
                securitys: tokenDetailSecurity,
                tokenDetailSecurityState:
                    TokenDetailSecurityState.success(tokenDetailSecurity)));
          }
        },
        onError: (error) {
          emit(state.copyWith(
              tokenDetailSecurityState:
                  TokenDetailSecurityState.error(error ?? 'Unknown error')));
        },
        // 如果tokenDetailSecurity为空，则重试
        shouldRetry: (tokenDetailSecurity) {
          return tokenDetailSecurity == null;
        },
        maxRetries: 3,
        retryDelay: const Duration(seconds: 1),
      );
    } catch (e) {
      emit(state.copyWith(
          tokenDetailSecurityState:
              TokenDetailSecurityState.error(e.toString())));
    }
  }

  Future<void> getTokenDetailInfo() async {
    if (state.token?.address == null || state.token?.chainName == null) {
      return;
    }

    emit(state.copyWith(
        tokenDetailInfoState: const TokenDetailInfoState.loading()));

    try {
      final tokenDetailInfo = await getIt<TokenDetailApi>().getTokenDetailInfo(
          state.token?.address ?? '', state.token?.chainName ?? '');

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
    } catch (e) {
      emit(state.copyWith(
          tokenDetailInfoState: TokenDetailInfoState.error(e.toString())));
    }
  }
}
