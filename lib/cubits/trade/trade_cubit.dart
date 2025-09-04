import 'dart:async';

import 'package:flutter_aigun/core/service_locator.dart';
import 'package:flutter_aigun/cubits/balance/balance_cubit.dart';
import 'package:flutter_aigun/data/services/api/trade_api.dart';
import 'package:flutter_aigun/utils/storage/local/wallet_storage.dart';
import 'package:flutter_aigun/utils/validators/trade_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/trade/trade_state.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';

class TradeCubit extends Cubit<TradeState> {
  TradeCubit(this.balanceCubit) : super(const TradeState()) {
    // _quoteTimer = Timer.periodic(const Duration(milliseconds: 3000), (timer) {
    //   getQuote();
    // });

    // 监听balanceCubit，更新availableTokens
    _balanceCubitStream = balanceCubit.stream.listen((balanceCubitState) {
      final availableTokens = balanceCubitState.balances?.tokens
          .map((token) => Token(
              chainId: token.chainId,
              chainLogo: token.chainLogo,
              tokenAvatar: token.symbol,
              tokenName: token.symbol,
              tokenPrice: token.tokenPrice,
              rawBalance: token.balance,
              balance: token.balance,
              decimals: token.decimals,
              // tokenPrice: token.tokenPrice,
              address: token.tokenAddress))
          .toList();

      emit(state.copyWith(availableTokens: availableTokens ?? []));
    });

    final fromToken = balanceCubit.state.balances?.tokens.first;
    if (fromToken != null) {
      emit(state.copyWith(
          fromToken: TradeToken(
              chainId: fromToken.chainId,
              chainLogo: fromToken.chainLogo,
              tokenAvatar: fromToken.symbol,
              tokenName: fromToken.symbol,
              address: fromToken.tokenAddress)));
    }
  }

  StreamSubscription? _balanceCubitStream;

  final BalanceCubit balanceCubit;
  Timer? _quoteTimer;
  final TradeApi tradeApi = getIt<TradeApi>();
  final WalletStorage walletStorage = getIt<WalletStorage>();

  void updateFromChainId(int fromChainId) {
    emit(state.copyWith(fromChainId: fromChainId));
  }

  void updateToChainId(int toChainId) {
    emit(state.copyWith(toChainId: toChainId));
  }

  void updateFromToken(TradeToken fromToken) {
    // update fromToken with  fromChainId
    emit(state.copyWith(fromChainId: fromToken.chainId, fromToken: fromToken));
  }

  void updateToToken(TradeToken toToken) {
    emit(state.copyWith(toChainId: toToken.chainId, toToken: toToken));
  }

  void updateSlippage(String slippage) {
    emit(state.copyWith(slippage: int.parse(slippage)));
  }

  void updatePriorityFee(String priorityFee) {
    emit(state.copyWith(priorityFee: int.parse(priorityFee)));
  }

  void updateAmount(String amount) {
    final newAmount = double.parse(amount);

    emit(state.copyWith(amount: newAmount));
  }

// transfer
  Future<void> swap() async {
    emit(state.copyWith(status: TradeStatusMessage.loading()));

    if (TradeValidator.isChainIdEmpty(
        state.fromChainId.toString(), state.toChainId.toString())) {
      emit(state.copyWith(
          status: const TradeStatusMessage.failure(TradeStatus.paramsInvalid)));
      return;
    }
    if (TradeValidator.equalsAddress(
        state.fromToken?.address ?? "", state.toToken?.address ?? "")) {
      emit(state.copyWith(
          status: const TradeStatusMessage.failure(TradeStatus.paramsInvalid)));
      return;
    }

    if (state.amount.isNaN) {
      emit(state.copyWith(
          status: const TradeStatusMessage.failure(TradeStatus.paramsInvalid)));
      return;
    }

    try {
      // get user default wallet
      final walletId = await walletStorage.getSelectedWallet();
      final response = await tradeApi.swap(
        amount: state.amount,
        fromChainId: state.fromChainId,
        toChainId: state.toChainId,
        inputMint: state.fromToken?.address ?? "",
        outputMint: state.toToken?.address ?? "",
        slippage: state.slippage.toString(),
        priorityFee: state.priorityFee.toString(),
        walletId: walletId ?? "",
      );

      emit(state.copyWith(status: TradeStatusMessage.success(response)));
    } catch (e) {
      emit(
          state.copyWith(status: TradeStatusMessage.failure(TradeStatus.none)));
    } finally {
      emit(state.copyWith(status: TradeStatusMessage.initial()));
    }
  }

  Future<void> getQuote() async {
    emit(state.copyWith(status: TradeStatusMessage.loading()));

    if (TradeValidator.isChainIdEmpty(
        state.fromChainId.toString(), state.toChainId.toString())) {
      return;
    }

    if (TradeValidator.equalsAddress(
        state.fromToken?.address ?? "", state.toToken?.address ?? "")) {
      return;
    }

    if (state.amount.isNaN && state.amount == 0) {
      return;
    }

    try {
      // get trade quote
      final response = await tradeApi.getQuote(
          fromChainId: state.fromChainId,
          toChainId: state.toChainId,
          inputMint: state.fromToken?.address ?? "",
          outputMint: state.toToken?.address ?? "",
          amount: state.amount,
          slippage: state.slippage * 100);

      emit(state.copyWith(
          quoteStatus: QuoteStatus.success(response), quote: response));
    } catch (e) {
      emit(
          state.copyWith(status: TradeStatusMessage.failure(TradeStatus.none)));
    } finally {
      emit(state.copyWith(status: TradeStatusMessage.initial()));
    }
  }

  @override
  Future<void> close() {
    _quoteTimer?.cancel();
    _balanceCubitStream?.cancel();
    return super.close();
  }
}
