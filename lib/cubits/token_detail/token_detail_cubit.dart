import 'package:flutter_aigun/core/cubit_locator.dart';
import 'package:flutter_aigun/cubits/token_detail/token_detail_state.dart';
import 'package:flutter_aigun/data/services/api/token_detail_api.dart';
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

  Future<void> loadData() async {
    getTokenSecurity();
    // await Future.wait([
    //   getTokenSecurity(),
    // ]);
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
}
