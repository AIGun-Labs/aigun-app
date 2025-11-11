import "dart:async";

import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:flutter_aigun/core/service_locator.dart";
import "package:flutter_aigun/cubits/index.dart";
import "package:flutter_aigun/data/models/transfer/index.dart";
import "package:flutter_aigun/data/services/api/index.dart";
import "package:flutter_aigun/data/services/sentry_service.dart";
import "package:flutter_aigun/enums/transaction.dart";
import "package:flutter_aigun/shared/utils/get_output_mint.dart";
import "package:flutter_aigun/utils/extensions/string.dart";
import "package:flutter_aigun/utils/logger.dart";
import "package:flutter_aigun/utils/numeric_utils.dart";
import "package:flutter_aigun/utils/storage/local/wallet_storage.dart";
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

    if (TokenValidator.isNativeToken(fromToken.address,
        network: fromToken.network ?? "")) {
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

    final matches = tokens.where((t) =>
        t.network.toString().toLowerCase() ==
            (selectedToken.network ?? "").toLowerCase() &&
        TokenValidator.isNativeToken(t.tokenAddress, network: t.network));

    if (matches.isEmpty) {
      return;
    }

    final fromToken = Token.fromBalance(matches.first);
    updateFromToken(fromToken);
  }

  void init() {
    // 监听 balanceCubit，更新 selectedToken 的 balance 字段
    _balanceCubitStream = balanceCubit.stream.listen((balanceState) {
      // 异步处理，避免在 build 阶段触发状态更新
      Future.microtask(() async {
        final balance = await getBalanceByAddress(
            state.selectedToken?.address ?? "",
            state.selectedToken?.network ?? "");

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

    if (TradeValidator.equalsToken(
        state.fromToken?.unique ?? "",
        state.selectedToken?.unique ?? "",
        state.fromToken?.address ?? "",
        state.selectedToken?.address ?? '')) {
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
        fromChainId: state.fromToken!.unique,
        toChainId: state.selectedToken!.unique,
        inputMint: state.fromToken!.address,
        outputMint: state.selectedToken!.address,
        amount: newAmount,
      );
      emit(state.copyWith(quote: quote));
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
        outputMint: getOutputMint(state.fromToken?.network ?? ""),
        amount: newAmount,
      );
// 更新询价时间戳

      emit(state.copyWith(quote: quote));
    } catch (e, s) {
      await SentryService()
          .reportError(e, s, tags: {"feature": "getSellQuote"});
    }
  }

  Future<void> buyToken(BuildContext context) async {
    if (state.buyTokenStatus == const BuyTokenStatus.loading()) {
      emit(state.copyWith(
          buyTokenStatus:
              const BuyTokenStatus.failure(BuyTokenFailure.unknown)));
      return;
    }

    emit(state.copyWith(buyTokenStatus: const BuyTokenStatus.loading()));

    if (state.fromToken == null || state.selectedToken == null) {
      emit(state.copyWith(
          buyTokenStatus:
              const BuyTokenStatus.failure(BuyTokenFailure.unknown)));

      return;
    }

    if (state.fromToken?.address == state.selectedToken?.address) {
      emit(state.copyWith(
          buyTokenStatus:
              const BuyTokenStatus.failure(BuyTokenFailure.unknown)));

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
      final settingOptions = tradeSettingCubit.getCurrentTradeCustomSetting();
      final newAmount = NumericUtils.multiplyByDecimalPower(
          state.buyAmount, state.fromToken!.decimals);

      final wallet = await walletStorage.getSelectedWallet();

      final response = await tradeApi.swap(
          network: state.fromToken?.network ?? "",
          fromChainId: state.fromToken?.unique ?? '',
          toChainId: state.selectedToken?.unique ?? '',
          inputMint: state.fromToken!.address,
          outputMint: state.selectedToken!.address,
          amount: newAmount.toString(),
          walletId: wallet?.id ?? "",
          options: settingOptions,
          mode: tradeSettingCubit.getTradeMode(),
          decimals: state.fromToken!.decimals);
      Logger.error("buyToken hash: ${response.txHash}");

      _transactionStatusTimer?.cancel();

      _transactionStatusTimer =
          Timer.periodic(const Duration(seconds: 2), (timer) {
        getTransactionStatus(
            response, state.fromToken!.chainId, state.fromToken!.decimals,
            (result) {
          _handleTradeSuccess(result, context, QuickTradeMode.buy);
        }, () async {
          _handleTradeFailure(QuickTradeMode.buy);
        });
      });
    } on DioException catch (_) {
      _handleTradeFailure(QuickTradeMode.buy);
    } catch (_) {
      _handleTradeFailure(QuickTradeMode.buy);
    }
  }

  Future<void> sellToken(BuildContext context) async {
    if (state.sellTokenStatus == const SellTokenStatus.loading()) {
      return;
    }
    emit(state.copyWith(sellTokenStatus: const SellTokenStatus.loading()));

    if (state.fromToken == null) {
      Logger.error("sellToken fromToken is null");

      emit(state.copyWith(
          sellTokenStatus:
              const SellTokenStatus.failure(SellTokenFailure.unknown)));
      return;
    }

    if (state.fromToken?.chainId == null) {
      Logger.error("sellToken chainId is null");
      emit(state.copyWith(
          sellTokenStatus:
              const SellTokenStatus.failure(SellTokenFailure.unknown)));

      return;
    }

    if (state.fromToken?.address.isEmpty ?? true) {
      Logger.error("sellToken address is empty");
      emit(state.copyWith(
          sellTokenStatus:
              const SellTokenStatus.failure(SellTokenFailure.unknown)));

      return;
    }

    if (state.fromToken?.chainId == null) {
      Logger.error("sellToken chainId is null");
      emit(state.copyWith(
          sellTokenStatus:
              const SellTokenStatus.failure(SellTokenFailure.unknown)));

      return;
    }

    try {
      final sellAmount = NumericUtils.multiplyTwoNumbers(
          state.sellPercent.toPercentage(),
          state.selectedToken?.balance ?? "0");
      final wallet = await walletStorage.getSelectedWallet();
      final settingOptions = tradeSettingCubit.getCurrentTradeCustomSetting();
      final newAmount = NumericUtils.multiplyByDecimalPower(
          sellAmount.toString(), state.selectedToken!.decimals);

      final response = await tradeApi.swap(
          network: state.fromToken?.network ?? "",
          fromChainId: state.selectedToken?.unique ?? '',
          toChainId: state.selectedToken?.unique ?? '',
          inputMint: state.selectedToken!.address,
          outputMint: getOutputMint(state.fromToken!.network ?? ""), //
          amount: newAmount.toString(),
          walletId: wallet?.id ?? "",
          options: settingOptions,
          mode: tradeSettingCubit.getTradeMode(),
          decimals: state.selectedToken!.decimals);

      Logger.error("sellToken hash: ${response.txHash}");

      _transactionStatusTimer?.cancel();

      _transactionStatusTimer =
          Timer.periodic(const Duration(seconds: 2), (timer) {
        getTransactionStatus(
            response, state.fromToken!.chainId, state.fromToken!.decimals,
            (result) {
          _handleTradeSuccess(result, context, QuickTradeMode.sell);
        }, () async {
          _handleTradeFailure(QuickTradeMode.sell);
        });
      });
    } on DioException catch (_) {
      Logger.error("sellToken DioException");
      _handleTradeFailure(QuickTradeMode.sell);
    } catch (_) {
      Logger.error("sellToken catch");
      _handleTradeFailure(QuickTradeMode.sell);
    }
  }

  void _handleTradeSuccess(
      TransferTransaction result, BuildContext context, QuickTradeMode mode) {
    // 不需要在这里更新 balance 因为在进入钱包页面的时候会自动刷新
    Logger.info(
        "handleTradeSuccess sell: ${result.txHash} ${mode.name} ${mode.name == QuickTradeMode.sell.name}");
    if (mode.name == QuickTradeMode.sell.name) {
      emit(state.copyWith(
        sellTokenStatus: SellTokenStatus.success(result),
      ));
    } else {
      emit(state.copyWith(buyTokenStatus: BuyTokenStatus.success(result)));
    }
  }

  void _handleTradeFailure(QuickTradeMode mode) async {
    Logger.error(
        "handleTradeFailure: ${mode.name} ${mode.name == QuickTradeMode.sell.name}");
    if (mode.name == QuickTradeMode.sell.name) {
      emit(state.copyWith(
          sellTokenStatus:
              const SellTokenStatus.failure(SellTokenFailure.unknown)));
    } else {
      emit(state.copyWith(
          buyTokenStatus:
              const BuyTokenStatus.failure(BuyTokenFailure.unknown)));
    }

    await SentryService().reportError(
        "${mode.name} token failure status", StackTrace.fromString(""),
        tags: {"feature": "${mode.name}Token"});
  }

  Future<void> getTransactionStatus(
    TransferTransaction transaction,
    String chainId,
    int decimals,
    Function(TransferTransaction) success,
    VoidCallback failure,
  ) async {
    try {
      final response = await getIt<WalletTransactionApi>().getTrasactionStatus(
          txHash: transaction.txHash ?? "",
          chainId: chainId.toString(),
          network: state.fromToken!.network ?? "");

      Logger.error(
          "getTrasactionStatus: ${response.status} ${response.status == TransactionStatusEnum.success.value}");
//  如果交易状态是成功
      if (response.status == TransactionStatusEnum.success.value) {
        success(transaction.copyWith(txHash: response.status));
        _transactionStatusTimer?.cancel();
      } else if (response.status == TransactionStatusEnum.failed.value) {
        failure();
        _transactionStatusTimer?.cancel();
      }
    } catch (e, s) {
      _transactionStatusTimer?.cancel();
      failure();
      await SentryService()
          .reportError(e, s, tags: {"feature": "getTransactionStatus"});
    }
  }

  Future<String> getBalanceByAddress(String address, String network) async {
    final balances = balanceCubit.state.balances?.tokens ?? [];
    final normalizedAddress = address.toLowerCase();
    final normalizedNetwork = network.toLowerCase();

    final matches = balances.where((token) =>
        token.tokenAddress.toLowerCase() == normalizedAddress &&
        token.network.toLowerCase() == normalizedNetwork);

    if (matches.isEmpty) {
      return "0";
    }

    // 直接返回原始字符串，避免 double 转换导致的精度丢失
    return matches.first.balance;
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
