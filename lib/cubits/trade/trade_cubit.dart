import 'dart:async';

import 'package:flutter_aigun/core/service_locator.dart';
import 'package:flutter_aigun/cubits/index.dart' hide QuoteStatus;
import 'package:flutter_aigun/data/models/trade/setting/trade_custom_setting.dart';
import 'package:flutter_aigun/data/services/api/trade_api.dart';
import 'package:flutter_aigun/enums/trade_mode.dart';
import 'package:flutter_aigun/utils/decimal.dart';
import 'package:flutter_aigun/utils/numeric_utils.dart';
import 'package:flutter_aigun/utils/storage/local/wallet_storage.dart';
import 'package:flutter_aigun/utils/validators/trade_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/trade/trade_state.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';

class TradeCubit extends Cubit<TradeState> {
  TradeCubit(this.balanceCubit, this.tradeSettingCubit) : super(TradeState()) {
    _quoteTimer = Timer.periodic(const Duration(milliseconds: 3000), (timer) {
      getQuote();
    });

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
              symbol: token.symbol,
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
              symbol: fromToken.symbol,
              balance: fromToken.balance,
              decimals: fromToken.decimals,
              address: fromToken.tokenAddress)));
    }
  }

  StreamSubscription? _balanceCubitStream;

  final BalanceCubit balanceCubit;
  final TradeSettingCubit tradeSettingCubit;
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
    emit(state.copyWith(amount: amount));
    // state.amountController?.text = amount;
  }

// transfer
  Future<void> swap() async {
    emit(state.copyWith(status: const TradeStatusMessage.loading()));

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

    if (state.amount.isEmpty) {
      emit(state.copyWith(
          status: const TradeStatusMessage.failure(TradeStatus.paramsInvalid)));
      return;
    }

    try {
      final settingOptions = getTradeSettingByChainId(state.fromChainId);
      final newAmount = NumericUtils.multiplyByDecimalPower(
        state.amount,
        state.fromToken!.decimals,
      ).toString();

      // get user default wallet
      final wallet = await walletStorage.getSelectedWallet();
      if (wallet == null) {
        emit(state.copyWith(
            status: const TradeStatusMessage.failure(TradeStatus.none)));
        return;
      }

      final response = await tradeApi.swap(
        amount: newAmount,
        fromChainId: state.fromChainId,
        toChainId: state.toChainId,
        inputMint: state.fromToken?.address ?? "",
        outputMint: state.toToken?.address ?? "",
        // slippage: state.slippage,
        // priorityFee: state.priorityFee.toString(),
        walletId: wallet.id ?? "",
        options: settingOptions,
        mode: getTradeMode(),

        decimals: state.fromToken!.decimals,
      );

      emit(state.copyWith(status: TradeStatusMessage.success(response)));
    } catch (e) {
      emit(state.copyWith(
          status: const TradeStatusMessage.failure(TradeStatus.none)));
    } finally {
      emit(state.copyWith(status: const TradeStatusMessage.initial()));
    }
  }

  Future<void> swapToken() async {
    final currentFromToken = state.fromToken;
    final currentToToken = state.toToken;
    final currentFromChainId = state.fromChainId;
    final currentToChainId = state.toChainId;

    // 交换代币和链ID
    emit(state.copyWith(
      fromToken: currentToToken,
      toToken: currentFromToken,
      fromChainId: currentToChainId,
      toChainId: currentFromChainId,

      // 清空报价状态，因为交易方向改变了
      quote: null,
      quoteStatus: QuoteStatus.initial(),
      // amount: "",
    ));

    // 如果有有效的代币，重新获取报价
    if (currentToToken != null && currentFromToken != null) {
      // 短暂延迟确保状态更新完成
      await Future.delayed(const Duration(milliseconds: 100));
      getQuote();
    }
  }

  Future<void> getQuote() async {
    emit(state.copyWith(quoteStatus: const QuoteStatus.loading()));

    if (TradeValidator.isChainIdEmpty(
        state.fromChainId.toString(), state.toChainId.toString())) {
      return;
    }

    if (TradeValidator.equalsAddress(
        state.fromToken?.address ?? "", state.toToken?.address ?? "")) {
      return;
    }

    if (state.amount.isEmpty) {
      return;
    }

    try {
      final newAmount = multiplyByDecimalPower(
        state.amount,
        state.fromToken!.decimals,
      ).toString();

      final newSlippage = NumericUtils.multiply(state.slippage, 100);
      // get trade quote
      final response = await tradeApi.getQuote(
          fromChainId: state.fromChainId,
          toChainId: state.toChainId,
          inputMint: state.fromToken?.address ?? "",
          outputMint: state.toToken?.address ?? "",
          amount: newAmount,
          slippage: newSlippage);

      emit(state.copyWith(
          quoteStatus: QuoteStatus.success(response), quote: response));
    } catch (e) {
      emit(state.copyWith(quoteStatus: const QuoteStatus.failure()));
    }
  }

  TradeCustomSetting getTradeSettingByChainId(int chainId) {
    final tradeSetting = tradeSettingCubit.state;
    final customSetting = tradeSetting.customSettings[chainId];
    return customSetting ?? TradeCustomSetting();
  }

  TradeMode getTradeMode() {
    final tradeSetting = tradeSettingCubit.state;
    return tradeSetting.mode ?? TradeMode.normal;
  }

  @override
  Future<void> close() {
    _quoteTimer?.cancel();
    _balanceCubitStream?.cancel();
    state.amountController?.dispose();
    return super.close();
  }
}
