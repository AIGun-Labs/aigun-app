import 'package:flutter_aigun/cubits/token_detail/token_detail_state.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:flutter_aigun/data/models/wallet/token/token.dart'
    as BalanceToken;
import 'package:flutter_bloc/flutter_bloc.dart';

class TokenDetailCubit extends Cubit<TokenDetailState> {
  TokenDetailCubit() : super(const TokenDetailState());

  void updateToken(Token token) {
    emit(state.copyWith(token: token));
  }

  void updateFromBalance(BalanceToken.Token token) {
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
  }
}
