import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/config/trade_chain.dart';
import 'package:flutter_aigun/core/custom_exceptions.dart';
import 'package:flutter_aigun/core/service_locator.dart';
import 'package:flutter_aigun/cubits/index.dart' hide QuoteStatus;
import 'package:flutter_aigun/cubits/trade/trade_state.dart';
import 'package:flutter_aigun/data/models/transfer/transaction/transaction.dart';
import 'package:flutter_aigun/data/services/api/index.dart';
import 'package:flutter_aigun/data/services/api/token_api.dart';
import 'package:flutter_aigun/data/services/sentry_service.dart';
import 'package:flutter_aigun/enums/transaction.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/utils/debouncer.dart';
import 'package:flutter_aigun/utils/decimal.dart';
import 'package:flutter_aigun/utils/extensions/string.dart';
import 'package:flutter_aigun/utils/format/currency.dart';
import 'package:flutter_aigun/utils/logger.dart';
import 'package:flutter_aigun/utils/numeric_utils.dart';
import 'package:flutter_aigun/utils/storage/local/token_swap_storage.dart';
import 'package:flutter_aigun/utils/storage/local/wallet_storage.dart';
import 'package:flutter_aigun/utils/toast.dart';
import 'package:flutter_aigun/utils/validators/trade_validator.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TradeCubit extends Cubit<TradeState> {
  StreamSubscription? _balanceCubitStream;

  final BalanceCubit balanceCubit;
  final TradeSettingCubit tradeSettingCubit;
  Timer? _quoteTimer;
  final TradeApi tradeApi = getIt<TradeApi>();
  final WalletStorage walletStorage = getIt<WalletStorage>();
  final TokenApi tokenApi;
  Timer? _transactionStatusTimer;
  Timer? _balanceTimer;
  TradeCubit(this.balanceCubit, this.tradeSettingCubit, this.tokenApi)
      : super(const TradeState()) {
    init(); //初始化代币列表

    // 监听balanceCubit，更新availableTokens
    _balanceCubitStream = balanceCubit.stream.listen((balanceCubitState) async {
      final availableTokens = balanceCubitState.balances?.tokens
          .map((token) => Token(
              chainId: token.chainId,
              chainLogo: token.chainLogo,
              tokenAvatar: token.tokenAvatar,
              tokenName: token.tokenName,
              tokenPrice: token.tokenPrice,
              rawBalance: token.balance,
              balance: token.balance,
              decimals: token.decimals,
              symbol: token.symbol,
              chainName: token.chainName,
              slug: token.network,
              // tokenPrice: token.tokenPrice,
              address: token.tokenAddress))
          .toList();

      emit(state.copyWith(availableTokens: availableTokens ?? []));

// 更新fromToken
      final tokens = balanceCubit.state.balances?.tokens;

// 虽然默认设置了fromToken，但是这里最好还是从用户钱包里面拿
      if (tokens == null || tokens.isEmpty) {
        // 默认选择 SOL 交易对
        final solToken = tokens
            ?.where((token) =>
                token.tokenAvatar.isNotEmpty &&
                token.symbol.toLowerCase() == "sol")
            .firstOrNull;

// 如果用户钱包里面的 sol 不为空
        if (solToken != null) {
          // 检查 SOL token 的余额是否为 0
          final shouldUseDefault = !(solToken.balance.isNotEmptyAndZeroValue);
          // 从本地中获取 fromToken
          final fromToken = await getIt<TokenSwapStorage>().getFromToken();

          if (shouldUseDefault) {
            // 如果余额为 0，使用默认的 SOL token
            // emit(state.copyWith(fromToken: defaultFormTradeToken));
            if (fromToken != null) {
              emit(state.copyWith(fromToken: TradeToken.fromToken(fromToken)));
            }
          } else {
            // 如果余额不为 0，使用从钱包中获取的 SOL token
            emit(state.copyWith(
                fromToken: TradeToken(
                    chainId: solToken.chainId,
                    chainLogo: solToken.chainLogo,
                    tokenAvatar: solToken.tokenAvatar,
                    tokenName: solToken.symbol,
                    symbol: solToken.symbol,
                    balance: solToken.balance,
                    decimals: solToken.decimals,
                    chainName: solToken.chainName,
                    address: solToken.tokenAddress,
                    tokenPrice: double.tryParse(solToken.tokenPrice) ?? 0)));
          }
        }
      }
    });
  }

  // 询价防抖器
  final Debouncer quoteDebouncer =
      Debouncer(delay: const Duration(milliseconds: 300));

  final Debouncer getFormBalance =
      Debouncer(delay: const Duration(milliseconds: 300));

  void updateFromChainId(String fromChainId) {
    emit(state.copyWith(fromChainId: fromChainId));
    // 获取最新实时平均数据
    tradeSettingCubit.getTradeLiveData();
  }

  void updateToChainId(String toChainId) {
    emit(state.copyWith(toChainId: toChainId));
  }

  void updateFromToken(TradeToken fromToken) {
    emit(state.copyWith(fromChainId: fromToken.chainId, fromToken: fromToken));
    getIt<TokenSwapStorage>()
        .saveFromToken(Token.fromTradeToken(fromToken)); // save to storage 中
    updateTradeSettingChainName(); // 更新一次就获取一次余额
    getBalanceSelectedToken();
    // 获取最新实时平均数据
    tradeSettingCubit.getTradeLiveData();

// 更新 fromToken 后询价
    quoteDebouncer.run(() {
      getQuote();
    });
  }

  void updateTradeSettingChainName() {
    final newChainName = state.fromToken?.chainName.toLowerCase() ?? '';

    if (newChainName == 'ethereum') {
      tradeSettingCubit.updateChainName('eth');
    } else {
      tradeSettingCubit.updateChainName(newChainName);
    }
  }

  void updateToToken(TradeToken toToken) {
    emit(state.copyWith(toChainId: toToken.chainId, toToken: toToken));
    getIt<TokenSwapStorage>()
        .saveToToken(Token.fromTradeToken(toToken)); // save to storage 中

// 更新 token 后询价
    quoteDebouncer.run(() {
      getQuote();
    });
  }

  void updateSlippage(String slippage) {
    emit(state.copyWith(slippage: int.parse(slippage)));
  }

  void updatePriorityFee(String priorityFee) {
    emit(state.copyWith(priorityFee: int.parse(priorityFee)));
  }

  void updateAmount(String amount) {
    if (!amount.isNotEmptyAndZeroValue) {
      emit(state.copyWith(quote: null));
    }

    emit(state.copyWith(amount: amount));

    // 更新 amount 后询价
    quoteDebouncer.run(() {
      getQuote();
    });
  }

  void _startQuoteTimer() {
    _quoteTimer?.cancel();
    if (state.lastQuoteTimestamp != null) {
      // 获取上次询价到现在的间隔时间
      final elapsed = DateTime.now().difference(state.lastQuoteTimestamp!);
      // 使用10秒减去间隔时间，得到剩余时间
      final remainingSeconds =
          const Duration(seconds: 10).inSeconds - elapsed.inSeconds;

// 如果剩余时间大于0
      if (remainingSeconds > 0) {
        // 那么根据剩余实现设置倒计时
        _quoteTimer = Timer(Duration(seconds: remainingSeconds), () {
          getQuote();
          // 剩余时间结束后开始新一轮询价
          _quoteTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
            getQuote();
          });
        });
      } else {
        _quoteTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
          getQuote();
        });
      }
    } else {
      _quoteTimer = Timer(const Duration(seconds: 10), () {
        getQuote();

        _quoteTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
          getQuote();
        });
      });
    }
  }

//  更新询价的时间戳
  void _updateQuoteTimestamp() {
    emit(state.copyWith(lastQuoteTimestamp: DateTime.now()));
    _startQuoteTimer(); // 重新开始询价定时器
  }

// 更新 amount 为最大值的 99.5%
  void updateAmountToMax() {
    final balance = state.fromBalance.toString();

    if (!(balance.isNotEmptyAndZeroValue)) {
      emit(state.copyWith(amount: "0"));
    }

    final maxAmount = NumericUtils.multiplyTwoNumbers(balance, 0.995);
    // 格式化为四位小数，移除末尾的0
    emit(state.copyWith(amount: maxAmount.toString()));
  }

  bool checkAmount(String amount, String balance) {
    final amountValue = double.tryParse(amount) ?? 0.0;
    final balanceValue = double.tryParse(balance) ?? 0.0;

    if (amountValue <= balanceValue) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> init() async {
    await getNativeTokens(); // init native tokens
    _balanceTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      getBalanceSelectedToken();
    });

    final tokens = await getIt<TokenSwapStorage>().getTokens();
    emit(state.copyWith(
        fromToken: TradeToken.fromToken(tokens[0]!),
        toToken: TradeToken.fromToken(tokens[1]!)));
  }

  Future<void> getNativeTokens() async {
    try {
      final nativeTokens = await tokenApi.getNativeTokens();
      emit(state.copyWith(nativeTokens: nativeTokens));
    } catch (e, s) {
      emit(state.copyWith(
          status: const TradeStatusMessage.failure(TradeStatus.none)));

      await SentryService()
          .reportError(e, s, tags: {"feature": "getNativeTokens"});
    }
  }

  Future<void> searchTokens(String keyword) async {
    try {
      final walletId = getIt<WalletCubit>().state.wallets.first.id;

      final tokens = await tokenApi.searchTokens(keyword, walletId);
      emit(state.copyWith(nativeTokens: tokens));
    } catch (e, s) {
      emit(state.copyWith(
          status: const TradeStatusMessage.failure(TradeStatus.none)));
      await SentryService().reportError(e, s,
          tags: {"feature": "searchTokens"}, extra: {"keyword": keyword});
    }
  }

// transfer
  Future<void> swap(
    BuildContext context, {
    required VoidCallback showToast,
    required VoidCallback closeToast,
  }) async {
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

    if (!(state.fromBalance.toString().isNotEmptyAndZeroValue)) {
      emit(state.copyWith(
          status: const TradeStatusMessage.failure(TradeStatus.paramsInvalid)));
      return;
    }

    if (state.amount.isEmpty) {
      emit(state.copyWith(
          status: const TradeStatusMessage.failure(TradeStatus.paramsInvalid)));
      return;
    }

    final settingOptions = tradeSettingCubit.getCurrentTradeCustomSetting();
    final newAmount = NumericUtils.multiplyByDecimalPower(
      state.amount,
      state.fromToken!.decimals,
    ).toString();

    // get user default wallet
    final wallet = await walletStorage.getSelectedWallet();

    try {
      showToast(); // 显示交易中的提示
      emit(state.copyWith(status: const TradeStatusMessage.loading()));

      if (wallet == null) {
        emit(state.copyWith(
            status: const TradeStatusMessage.failure(TradeStatus.none)));
        return;
      }

      final network = tradeChainPathMap[state.fromToken!.network] ?? "";

      final response = await tradeApi.swap(
        network: network,
        amount: newAmount,
        fromChainId: state.fromChainId,
        toChainId: state.toChainId,
        inputMint: state.fromToken?.address ?? "",
        outputMint: state.toToken?.address ?? "",
        walletId: wallet.id ?? "",
        options: settingOptions,
        mode: tradeSettingCubit.getTradeMode(),
        decimals: state.fromToken!.decimals,
      );

// 先取消之前的定时器
      _transactionStatusTimer?.cancel();

// 设置新的定时器
      _transactionStatusTimer =
          Timer.periodic(const Duration(seconds: 2), (timer) {
        getTransactionStatus(response, state.fromChainId, context, closeToast);
      });
    } catch (e, s) {
      closeToast();
      await Future.delayed(const Duration(milliseconds: 100));

      if (!context.mounted) return;
      TradeStatusToastUtils.showFailed(context);

      emit(state.copyWith(
          status: const TradeStatusMessage.failure(TradeStatus.none)));
      await SentryService().reportError(e, s, tags: {
        "feature": "swap"
      }, extra: {
        "amount": newAmount,
        "fromChainId": state.fromChainId,
        "toChainId": state.toChainId,
        "inputMint": state.fromToken?.address ?? "",
        "outputMint": state.toToken?.address ?? "",
        "walletId": wallet?.id ?? "",
        "options": settingOptions,
        "mode": tradeSettingCubit.getTradeMode(),
        "decimals": state.fromToken!.decimals,
      });
    }
  }

  Future<void> getTransactionStatus(
    TransferTransaction transaction,
    String chainId,
    BuildContext context,
    VoidCallback closeToastCallback,
  ) async {
    try {
      // 获取交易状态 传入交易hash 和链 id 获取交易状态
      final response = await getIt<WalletTransactionApi>().getTrasactionStatus(
          txHash: transaction.txHash ?? "", chainId: chainId);

//  如果交易状态是成功
      if (response.status == TransactionStatusEnum.success.value) {
        emit(state.copyWith(status: TradeStatusMessage.success(transaction)));

        // final newAmount = state.quote?.outAmount
        //     ?.divideByDecimalPower(state.fromToken?.decimals ?? 18);

        final newAmount = NumericUtils.convertFromAtomicUnits(
            state.quote?.outAmount ?? "", state.toToken?.decimals ?? 18);
// 交易成功
        closeToastCallback();
        if (!context.mounted) return;
        TradeStatusToastUtils.showSuccessToast(context,
            message: S.of(context).transactionSuccess,
            txHash: transaction.txHash ?? "",
            symbol: state.toToken?.symbol ?? "",
            amount: CurrencyFormatter.abbreviateTokenPrice(
                double.tryParse(newAmount) ?? 0),
            txUrl: transaction.txUrl);

        getBalanceSelectedToken();

// 关闭
        _transactionStatusTimer?.cancel();
      } else if (response.status == TransactionStatusEnum.failed.value) {
        // 如果交易状态是失败
        emit(state.copyWith(
            status: const TradeStatusMessage.failure(TradeStatus.none)));

        closeToastCallback();
        if (!context.mounted) return;
        TradeStatusToastUtils.showFailed(context);

        _transactionStatusTimer?.cancel();

        await SentryService().reportError(
            "The transaction request was successful, but the status failed",
            StackTrace.fromString(""),
            tags: {"feature": "getTransactionStatus"},
            extra: {"txHash": transaction.txHash, "chainId": chainId});
      }

// 取消之前的定时器
      _transactionStatusTimer?.cancel();
    } catch (e, s) {
      // 取消之前的定时器
      _transactionStatusTimer?.cancel();
      emit(state.copyWith(
          status: const TradeStatusMessage.failure(TradeStatus.none)));
      await SentryService().reportError(e, s,
          tags: {"feature": "getTransactionStatus"},
          extra: {"txHash": transaction.txHash ?? "", "chainId": chainId});
    } finally {
      emit(state.copyWith(status: const TradeStatusMessage.initial()));
    }
  }

  Future<void> swapToken() async {
    final currentFromToken = state.fromToken;
    final currentToToken = state.toToken;
    final currentFromChainId = state.fromChainId;
    final currentToChainId = state.toChainId;
    final currentAmount = state.amount;
    final currentToAmount = state.quote?.outAmount
            .toString()
            .divideByDecimalPower(state.toToken?.decimals ?? 18) ??
        "";
    // 交换代币和链ID
    emit(state.copyWith(
      fromToken: currentToToken,
      toToken: currentFromToken,
      fromChainId: currentToChainId,
      toChainId: currentFromChainId,

      // 清空报价状态，因为交易方向改变了
      fromBalance: null,
      quote: null,
      quoteStatus: const QuoteStatus.initial(),
      amount: currentToAmount,
      // fromBalance: 0,
    ));

    // 如果有有效的代币，重新获取报价
    if (currentFromToken != null) {
      // 短暂延迟确保状态更新完成
      await getBalanceSelectedToken();
      await getQuote();
    }
  }

  Future<void> getBalanceSelectedToken() async {
    final selectedToken = state.fromToken;

    if (selectedToken?.chainId == null || selectedToken?.address == null) {
      return;
    }

    final wallets = getIt<WalletCubit>().state.wallets;
    if (wallets.isEmpty) {
      return;
    }

    final walletId = wallets.first.id;
    try {
      final tokens = getIt<BalanceCubit>().state.balances?.tokens;

      final tokenBalance = tokens
          ?.where((balance) =>
              balance.tokenAddress == selectedToken?.address &&
              balance.chainId == selectedToken?.chainId)
          .firstOrNull;

      final newBalance = double.tryParse(tokenBalance?.balance ?? "0") ?? 0;

      // 只有当余额真正发生变化时才更新状态
      if (state.fromBalance != newBalance) {
        Timer(const Duration(milliseconds: 200), () {
          emit(state.copyWith(
              fromBalance: newBalance,
              fromBalanceStatus:
                  GetTokenBalanceStatus.success(tokenBalance?.balance ?? "")));
        });
      } else {
        // 余额没变，只更新状态
        emit(state.copyWith(
            fromBalanceStatus:
                GetTokenBalanceStatus.success(tokenBalance?.balance ?? '')));
      }
    } catch (e, s) {
      emit(state.copyWith(
          fromBalanceStatus: const GetTokenBalanceStatus.failure()));
      await SentryService().reportError(e, s, tags: {
        "feature": "getBalanceSelectedToken"
      }, extra: {
        "walletId": walletId,
        "address": selectedToken?.address.toString(),
        "chainId": selectedToken?.chainId
      });
    }
  }

  Future<void> getQuote() async {
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

    // if (state.fromToken == null ||
    //     state.fromToken?.balance == null ||
    //     !(state.fromToken!.balance.toString().isNotEmptyAndZeroValue)) {
    //   emit(state.copyWith(paramsStatus: const TradeParamsStatus.failure()));
    //   return;
    // }

    final newAmount = multiplyByDecimalPower(
      state.amount,
      state.fromToken!.decimals,
    ).toString();

    final newSlippage = NumericUtils.multiply(state.slippage, 100);

    if (!(state.amount.isNotEmptyAndZeroValue)) {
      emit(state.copyWith(paramsStatus: const TradeParamsStatus.failure()));
    }
    try {
      emit(state.copyWith(quoteStatus: const QuoteStatus.loading()));
      final network = tradeChainPathMap[state.fromToken!.network] ?? "";

      // get trade quote
      final response = await tradeApi.getQuote(
          network: network,
          fromChainId: state.fromChainId,
          toChainId: state.toChainId,
          inputMint: state.fromToken?.address ?? "",
          outputMint: state.toToken?.address ?? "",
          amount: newAmount,
          slippage: newSlippage,
          mode: tradeSettingCubit.getTradeMode());

      emit(state.copyWith(
          quoteStatus: QuoteStatus.success(response),
          quote: response,
          paramsStatus: const TradeParamsStatus.success()));

// 更新询价时间戳
      _updateQuoteTimestamp();
    } catch (e, s) {
      emit(state.copyWith(
          quoteStatus: const QuoteStatus.failure(),
          paramsStatus: const TradeParamsStatus.failure()));
      await SentryService().reportError(e, s, tags: {
        "feature": "getQuote"
      }, extra: {
        "fromChainId": state.fromChainId,
        "toChainId": state.toChainId,
        "inputMint": state.fromToken?.address ?? "",
        "outputMint": state.toToken?.address ?? "",
        "amount": newAmount,
        "slippage": newSlippage,
        "mode": tradeSettingCubit.getTradeMode()
      });
    }
  }

  void clear() {
    emit(state.copyWith(
      quoteStatus: const QuoteStatus.initial(),
      quote: null,
      amount: "",
    ));
  }

  @override
  Future<void> close() {
    _quoteTimer?.cancel();
    _balanceCubitStream?.cancel();
    state.amountController?.dispose();
    quoteDebouncer.dispose();
    _balanceTimer?.cancel();

    return super.close();
  }
}
