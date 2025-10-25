import "dart:async";

import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:flutter_aigun/config/trade_chain.dart";
import "package:flutter_aigun/core/service_locator.dart";
import "package:flutter_aigun/cubits/index.dart";
import "package:flutter_aigun/data/models/transfer/index.dart";
import "package:flutter_aigun/data/services/api/index.dart";
import "package:flutter_aigun/data/services/sentry_service.dart";
import "package:flutter_aigun/enums/transaction.dart";
import "package:flutter_aigun/l10n/l10n.dart";
import "package:flutter_aigun/utils/extensions/string.dart";
import "package:flutter_aigun/utils/format/currency.dart";
import "package:flutter_aigun/utils/numeric_utils.dart";
import "package:flutter_aigun/utils/storage/local/wallet_storage.dart";
import "package:flutter_aigun/utils/toast.dart";
import "package:flutter_aigun/utils/validators/index.dart";
import "package:flutter_aigun/utils/validators/trade_validator.dart";
import "package:flutter_aigun/widgets/token/models/token.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class QuickTradeCubit extends Cubit<QuickTradeState> {
  late final StreamSubscription<BalanceState> _balanceCubitStream;
  QuickTradeCubit(this.tradeApi, this.tradeSettingCubit, this.walletStorage,
      this.balanceCubit)
      : super(const QuickTradeState()) {
    init();
  }

  Timer? _transactionStatusTimer;
  Timer? _quoteBuyTokenTimer;
  Timer? _quoteSellTokenTimer;

  final TradeApi tradeApi;
  final TradeSettingCubit tradeSettingCubit;
  final WalletStorage walletStorage;

  final BalanceCubit balanceCubit;

  void updateFromToken(Token fromToken) {
    emit(state.copyWith(fromToken: fromToken));

    if (TokenValidator.isNativeToken(fromToken.address)) {
      emit(state.copyWith(isNativeToken: true));
    } else {
      emit(state.copyWith(isNativeToken: false));
    }
  }

  void updateSelectedToken(Token toToken) {
    emit(state.copyWith(selectedToken: toToken));
    _onUpdateSelectedToken(toToken);
  }

  void updateMode(QuickTradeMode mode) {
    emit(state.copyWith(mode: mode));
  }

  void updateBuyAmount(String buyAmount) {
    emit(state.copyWith(buyAmount: buyAmount));
  }

  void updateSellPercent(String sellPercent) {
    emit(state.copyWith(sellPercent: sellPercent));
  }

  void _onUpdateSelectedToken(Token selectedToken) {
    final tokens = getIt<BalanceCubit>().state.balances?.tokens ?? [];
    final token = tokens.any((t) => t.chainId == selectedToken.chainId)
        ? tokens.firstWhere((t) => t.chainId == selectedToken.chainId)
        : null;

    if (token == null) {
      return;
    }

    final fromToken = Token.fromBalance(token);

    updateFromToken(fromToken);
  }

  void init() {
    // 监听 balanceCubit，更新 selectedToken 的 balance 字段
    _balanceCubitStream = balanceCubit.stream.listen((balanceState) {
      // 异步处理，避免在 build 阶段触发状态更新
      Future.microtask(() async {
        final balance =
            await getBalanceByAddress(state.selectedToken?.address ?? "");

        // 只在 selectedToken 不为 null 时更新 balance 字段
        if (state.selectedToken != null) {
          final updatedToken = state.selectedToken!.copyWith(balance: balance);
          emit(state.copyWith(selectedToken: updatedToken));
        }
      });
    });

    _quoteBuyTokenTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (state.mode != QuickTradeMode.buy) return;

      getBuyQuote();
    });

    _quoteSellTokenTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (state.mode != QuickTradeMode.sell) return;
      getSellQuote();
    });
  }

  Future<void> getBuyQuote() async {
    if (state.fromToken == null || state.selectedToken == null) {
      return;
    }

    if (TradeValidator.isChainIdEmpty(state.fromToken!.chainId.toString(),
        state.selectedToken!.chainId.toString())) {
      return;
    }

    if (TradeValidator.equalsAddress(
        state.fromToken?.address ?? "", state.selectedToken!.address)) {
      return;
    }

    if (!state.buyAmount.isNotEmptyAndZeroValue) {
      return;
    }

    try {
      final newAmount = NumericUtils.multiplyByDecimalPower(
        state.buyAmount,
        state.fromToken!.decimals,
      ).toString();

      final quote = await tradeApi.getQuote(
        network: state.fromToken!.network ?? "",
        fromChainId: state.fromToken!.chainId,
        toChainId: state.selectedToken!.chainId,
        inputMint: state.fromToken!.address,
        outputMint: state.selectedToken!.address,
        amount: newAmount,
        // mode: tradeSettingCubit.getTradeMode()
      );
      emit(state.copyWith(quote: quote));
// 更新询价时间戳
    } catch (e, s) {
      // emit(state.copyWith(quote: null));
      await SentryService().reportError(e, s, tags: {"feature": "getBuyQuote"});
    }
  }

  Future<void> getSellQuote() async {
    if (TradeValidator.isChainIdEmpty(state.fromToken!.chainId.toString(),
        state.selectedToken!.chainId.toString())) {
      return;
    }

    if (TradeValidator.equalsAddress(
        state.fromToken?.address ?? "", state.selectedToken!.address)) {
      return;
    }

    if (!state.sellPercent.isNotEmptyAndZeroValue) {
      return;
    }

    try {
      final newAmount = NumericUtils.multiplyByDecimalPower(
        state.sellPercent
            .toPercentage()
            .safeMultiply(state.selectedToken?.balance ?? "0"),
        state.selectedToken!.decimals,
      ).toString();

      final quote = await tradeApi.getQuote(
        network: state.fromToken?.network ?? "",
        fromChainId: state.selectedToken!.chainId,
        toChainId: state.selectedToken!.chainId,
        inputMint: state.selectedToken!.address,
        outputMint: "",
        amount: newAmount,
        // mode: tradeSettingCubit.getTradeMode()
      );
// 更新询价时间戳

      emit(state.copyWith(quote: quote));
    } catch (e, s) {
      await SentryService()
          .reportError(e, s, tags: {"feature": "getSellQuote"});
      // emit(state.copyWith(quote: null));
    }
  }

  Future<void> buyToken(BuildContext context, VoidCallback closeToast,
      VoidCallback showTraingToast) async {
    if (state.buyTokenStatus == const BuyTokenStatus.loading()) {
      return;
    }

    emit(state.copyWith(buyTokenStatus: const BuyTokenStatus.loading()));

    if (state.fromToken == null || state.selectedToken == null) {
      emit(state.copyWith(
          buyTokenStatus:
              const BuyTokenStatus.failure(BuyTokenFailure.unknown)));

      TradeStatusToastUtils.showFailed(context);

      return;
    }

    if (state.fromToken?.address == state.selectedToken?.address) {
      emit(state.copyWith(
          buyTokenStatus:
              const BuyTokenStatus.failure(BuyTokenFailure.unknown)));

      TradeStatusToastUtils.showFailed(context);
      return;
    }

    if (state.fromToken?.chainId == null ||
        state.selectedToken?.chainId == null) {
      emit(state.copyWith(
          buyTokenStatus:
              const BuyTokenStatus.failure(BuyTokenFailure.unknown)));
      return;
    }

    try {
      showTraingToast();

      final settingOptions = tradeSettingCubit.getCurrentTradeCustomSetting();
      final newAmount = NumericUtils.multiplyByDecimalPower(
          state.buyAmount, state.fromToken!.decimals);
      final wallet = await walletStorage.getSelectedWallet();

      final response = await tradeApi.swap(
          network: state.fromToken?.network ?? "",
          fromChainId: state.fromToken!.chainId,
          toChainId: state.selectedToken!.chainId,
          inputMint: state.fromToken!.address,
          outputMint: state.selectedToken!.address,
          amount: newAmount.toString(),
          walletId: wallet?.id ?? "",
          options: settingOptions,
          mode: tradeSettingCubit.getTradeMode(),
          decimals: state.fromToken!.decimals);

      _transactionStatusTimer?.cancel();

// 在交易请求成功之后，轮询获取 交易的状态
      _transactionStatusTimer =
          Timer.periodic(const Duration(seconds: 2), (timer) {
        getTransactionStatus(
            response, state.fromToken!.chainId, state.fromToken!.decimals,
            (result) {
          emit(state.copyWith(buyTokenStatus: BuyTokenStatus.success(result)));

          final divideAmount = state.quote?.outAmount
                  ?.divideByDecimalPower(state.selectedToken!.decimals) ??
              "";

          TradeStatusToastUtils.showSuccessToast(context,
              message: S.of(context).transactionSuccess,
              txHash: result.txHash ?? "",
              amount: CurrencyFormatter.abbreviateTokenPrice(
                  double.tryParse(divideAmount) ?? 0),
              symbol: state.selectedToken?.symbol ?? "",
              txUrl: result.txUrl ?? "");
        }, () async {
          await SentryService().reportError(
              "buy token failure status", StackTrace.fromString(""),
              tags: {"feature": "buyToken"});
          emit(state.copyWith(
              buyTokenStatus:
                  const BuyTokenStatus.failure(BuyTokenFailure.unknown)));
          closeToast();
        });
      });
    } on DioException catch (e, s) {
      await Future.delayed(const Duration(seconds: 2), () async {
        closeToast();

        emit(state.copyWith(
            buyTokenStatus:
                const BuyTokenStatus.failure(BuyTokenFailure.unknown)));

        TradeStatusToastUtils.showFailed(context);
        await SentryService().reportError(e, s, tags: {"feature": "buyToken"});
      });
    } catch (e, s) {
      await Future.delayed(const Duration(seconds: 2), () async {
        closeToast();

        emit(state.copyWith(
            buyTokenStatus:
                const BuyTokenStatus.failure(BuyTokenFailure.unknown)));

        TradeStatusToastUtils.showFailed(context);

        await SentryService().reportError(e, s, tags: {"feature": "buyToken"});
      });
    } finally {
      emit(state.copyWith(buyTokenStatus: const BuyTokenStatus.initial()));
    }
  }

  Future<void> sellToken(BuildContext context, VoidCallback closeToast,
      VoidCallback showTraingToast) async {
    if (state.sellTokenStatus == const SellTokenStatus.loading()) {
      return;
    }

    emit(state.copyWith(sellTokenStatus: const SellTokenStatus.loading()));

    if (state.fromToken == null) {
      emit(state.copyWith(
          sellTokenStatus:
              const SellTokenStatus.failure(SellTokenFailure.unknown)));

      TradeStatusToastUtils.showFailed(context);
      return;
    }

    if (state.fromToken?.chainId == null) {
      emit(state.copyWith(
          sellTokenStatus:
              const SellTokenStatus.failure(SellTokenFailure.unknown)));

      TradeStatusToastUtils.showFailed(context);
      return;
    }

    if (state.fromToken?.address.isEmpty ?? true) {
      emit(state.copyWith(
          sellTokenStatus:
              const SellTokenStatus.failure(SellTokenFailure.unknown)));

      TradeStatusToastUtils.showFailed(context);
      return;
    }

    final sellAmount = NumericUtils.multiplyTwoNumbers(
        state.sellPercent.toPercentage(), state.selectedToken?.balance ?? "0");

    if (state.fromToken?.chainId == null) {
      emit(state.copyWith(
          sellTokenStatus:
              const SellTokenStatus.failure(SellTokenFailure.unknown)));

      TradeStatusToastUtils.showFailed(context);
      return;
    }

    try {
      showTraingToast();

      final wallet = await walletStorage.getSelectedWallet();
      final settingOptions = tradeSettingCubit.getCurrentTradeCustomSetting();

      final newAmount = NumericUtils.multiplyByDecimalPower(
          sellAmount.toString(), state.fromToken!.decimals);

      // 转换为原生代币所以不需要目标代币的地址以及目标代币链 id 需要设置为 fromToken的链 id
      final response = await tradeApi.swap(
          network: state.fromToken?.network ?? "",
          fromChainId: state.selectedToken!.chainId,
          toChainId: state.selectedToken!.chainId,
          inputMint: state.selectedToken!.address,
          outputMint: "", //
          amount: newAmount.toString(),
          walletId: wallet?.id ?? "",
          options: settingOptions,
          mode: tradeSettingCubit.getTradeMode(),
          decimals: state.fromToken!.decimals);

      _transactionStatusTimer?.cancel();

      _transactionStatusTimer =
          Timer.periodic(const Duration(seconds: 2), (timer) {
        getTransactionStatus(
            response, state.fromToken!.chainId, state.fromToken!.decimals,
            (result) {
          emit(
              state.copyWith(sellTokenStatus: SellTokenStatus.success(result)));
          TradeStatusToastUtils.showSuccessToast(context,
              message: S.of(context).transactionSuccess,
              txHash: result.txHash ?? "",
              amount: state.quote?.outUsdValue?.toString() ?? "",
              symbol: state.fromToken?.chainName ?? "",
              txUrl: result.txUrl ?? "");
        }, () async {
          await SentryService().reportError(
              "sell token failure status", StackTrace.fromString(""),
              tags: {"feature": "sellToken"});

          emit(state.copyWith(
              sellTokenStatus:
                  const SellTokenStatus.failure(SellTokenFailure.unknown)));
          closeToast();
        });
      });
    } on DioException catch (e, s) {
      Future.delayed(const Duration(seconds: 2), () async {
        closeToast();

        emit(state.copyWith(
            sellTokenStatus:
                const SellTokenStatus.failure(SellTokenFailure.unknown)));

        TradeStatusToastUtils.showFailed(context);

        await SentryService().reportError(e, s, tags: {"feature": "sellToken"});
      });
    } catch (e, s) {
      await Future.delayed(const Duration(seconds: 2), () async {
        closeToast();
        emit(state.copyWith(
            sellTokenStatus:
                const SellTokenStatus.failure(SellTokenFailure.unknown)));
        TradeStatusToastUtils.showFailed(context);
        await SentryService().reportError(e, s, tags: {"feature": "sellToken"});
      });
    } finally {
      emit(state.copyWith(sellTokenStatus: const SellTokenStatus.initial()));
    }
  }

  Future<void> getTransactionStatus(
    TransferTransaction transaction,
    String chainId,
    int decimals,
    Function(TransferTransaction) success,
    VoidCallback failure,
  ) async {
    try {
      // 获取交易状态 传入交易hash 和链 id 获取交易状态
      final response = await getIt<WalletTransactionApi>().getTrasactionStatus(
          txHash: transaction.txHash ?? "",
          chainId: chainId.toString(),
          network: state.fromToken!.network ?? "");

//  如果交易状态是成功
      if (response.status == TransactionStatusEnum.success.value) {
        success(transaction);
      } else if (response.status == TransactionStatusEnum.failed.value) {
        // 如果交易状态是失败
        failure();
        await SentryService().reportError("trade status is failure", null,
            tags: {"feature": "getTransactionStatus"});
      }

// 取消之前的定时器
      _transactionStatusTimer?.cancel();
    } catch (e, s) {
      // 取消之前的定时器
      _transactionStatusTimer?.cancel();
      failure();
      await SentryService()
          .reportError(e, s, tags: {"feature": "getTransactionStatus"});
    } finally {
      emit(state.copyWith(buyTokenStatus: const BuyTokenStatus.initial()));
      _transactionStatusTimer?.cancel();
    }
  }

  Future<String> getBalanceByAddress(String address) async {
    final balance =
        balanceCubit.getBalance(address, state.fromToken?.chainId ?? "");

    return balance?.balance ?? "";
  }

  @override
  Future<void> close() {
    _balanceCubitStream.cancel();
    _quoteBuyTokenTimer?.cancel();
    _quoteSellTokenTimer?.cancel();
    return super.close();
  }

  void clear() {
    emit(state.copyWith(
        fromToken: null,
        selectedToken: null,
        buyAmount: "",
        sellPercent: "",
        buyTokenStatus: const BuyTokenStatus.initial(),
        sellTokenStatus: const SellTokenStatus.initial()));
  }
}
