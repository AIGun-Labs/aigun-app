import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_aigun/core/custom_exceptions.dart';
import 'package:flutter_aigun/core/service_locator.dart';
import 'package:flutter_aigun/cubits/index.dart' hide QuoteStatus;
import 'package:flutter_aigun/data/services/api/token_api.dart';
import 'package:flutter_aigun/data/services/api/trade_api.dart';
import 'package:flutter_aigun/utils/decimal.dart';
import 'package:flutter_aigun/utils/numeric_utils.dart';
import 'package:flutter_aigun/utils/storage/local/wallet_storage.dart';
import 'package:flutter_aigun/utils/validators/trade_validator.dart';
import 'package:flutter_aigun/widgets/toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/trade/trade_state.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';

class TradeCubit extends Cubit<TradeState> {
  TradeCubit(this.balanceCubit, this.tradeSettingCubit, this.tokenApi)
      : super(const TradeState()) {
    init(); //初始化代币列表
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
              chainName: token.chainName,
              // tokenPrice: token.tokenPrice,
              address: token.tokenAddress))
          .toList();

      emit(state.copyWith(availableTokens: availableTokens ?? []));
    });

    final tokens = balanceCubit.state.balances?.tokens;
    if (tokens != null && tokens.isNotEmpty) {
      final fromToken = tokens.first;
      emit(state.copyWith(
          fromToken: TradeToken(
              chainId: fromToken.chainId,
              chainLogo: fromToken.chainLogo,
              tokenAvatar: fromToken.symbol,
              tokenName: fromToken.symbol,
              symbol: fromToken.symbol,
              balance: fromToken.balance,
              decimals: fromToken.decimals,
              chainName: fromToken.chainName,
              address: fromToken.tokenAddress)));
    }
  }

  StreamSubscription? _balanceCubitStream;

  final BalanceCubit balanceCubit;
  final TradeSettingCubit tradeSettingCubit;
  Timer? _quoteTimer;
  final TradeApi tradeApi = getIt<TradeApi>();
  final WalletStorage walletStorage = getIt<WalletStorage>();
  final TokenApi tokenApi;
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

  Future<void> init() async {
    await getNativeTokens(); // init native tokens
  }

  Future<void> getNativeTokens() async {
    try {
      final nativeTokens = await tokenApi.getNativeTokens();
      // emit(state.copyWith(nativeTokens: state.nativeTokens + nativeTokens));
      emit(state.copyWith(nativeTokens: nativeTokens));
    } catch (e) {
      emit(state.copyWith(
          status: const TradeStatusMessage.failure(TradeStatus.none)));
    }
  }

  Future<void> searchTokens(String keyword) async {
    try {
      final tokens = await tokenApi.searchTokens(keyword);
      emit(state.copyWith(nativeTokens: tokens));
    } catch (e) {
      emit(state.copyWith(
          status: const TradeStatusMessage.failure(TradeStatus.none)));
    }
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
      final settingOptions =
          tradeSettingCubit.getTradeCustomSettingByChainId(state.fromChainId);
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
        mode: tradeSettingCubit.getTradeMode(),

        decimals: state.fromToken!.decimals,
      );

      emit(state.copyWith(status: TradeStatusMessage.success(response)));
      showSimpleToast("交易成功");
    } catch (e) {
      if (e is DioException) {
        if (e.error is BusinessException) {
          showSimpleToast("交易失败：${(e.error as BusinessException).msg}");
        } else {
          showSimpleToast("交易失败：${e.toString()}");
        }
      }

      emit(state.copyWith(
          status: const TradeStatusMessage.failure(TradeStatus.none)));
      // emit(state.copyWith(
      //     status: const TradeStatusMessage.success(TransferTransaction(
      //   txHash: "",
      //   txUrl: "",
      //   type: "",
      //   status: "",
      //   captcha: null,
      //   sms: null,
      // ))));
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
      quoteStatus: const QuoteStatus.initial(),
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

    if (state.fromToken?.chainId == null || state.toToken?.chainId == null) {
      emit(state.copyWith(paramsStatus: const TradeParamsStatus.failure()));
      return;
    }

    if (TradeValidator.isChainIdEmpty(
        state.fromChainId.toString(), state.toChainId.toString())) {
      emit(state.copyWith(paramsStatus: const TradeParamsStatus.failure()));
      return;
    }

    if (TradeValidator.equalsAddress(
        state.fromToken?.address ?? "", state.toToken?.address ?? "")) {
      emit(state.copyWith(paramsStatus: const TradeParamsStatus.failure()));
      return;
    }

    if (state.amount.isEmpty) {
      emit(state.copyWith(paramsStatus: const TradeParamsStatus.failure()));
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
          slippage: newSlippage,
          mode: tradeSettingCubit.getTradeMode());

      emit(state.copyWith(
          quoteStatus: QuoteStatus.success(response), quote: response));
    } catch (e) {
      emit(state.copyWith(quoteStatus: const QuoteStatus.failure()));
    }
  }

  @override
  Future<void> close() {
    _quoteTimer?.cancel();
    _balanceCubitStream?.cancel();
    state.amountController?.dispose();
    return super.close();
  }
}
