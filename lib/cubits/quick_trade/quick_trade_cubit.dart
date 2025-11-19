import "dart:async";

import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../core/polling/polling_service.dart";
import "../../core/service_locator.dart";
import "../../data/models/transfer/index.dart";
import "../../data/services/api/index.dart";
import "../../data/services/sentry_service.dart";
import "../../enums/transaction.dart";
import "../../shared/utils/get_output_mint.dart";
import "../../utils/debouncer.dart";
import "../../utils/error_handler_utils.dart";
import "../../utils/extensions/string.dart";
import "../../utils/logger.dart";
import "../../utils/numeric_utils.dart";
import "../../utils/storage/local/wallet_storage.dart";
import "../../utils/toast/trade_status_toast.dart";
import "../../utils/validators/index.dart";
import "../../utils/validators/trade_validator.dart";
import "../../widgets/token/models/token.dart";
import "../index.dart";

class QuickTradeCubit extends Cubit<QuickTradeState> {
  late final StreamSubscription<BalanceState> _balanceCubitStream;
  QuickTradeCubit(
    this.tradeApi,
    this.tradeSettingCubit,
    this.walletStorage,
    this.balanceCubit,
  ) : super(const QuickTradeState()) {
    init();
  }

  Timer? _transactionStatusTimer;

  final TradeApi tradeApi;
  final TradeSettingCubit tradeSettingCubit;
  final WalletStorage walletStorage;

  final BalanceCubit balanceCubit;
  final Debouncer _buyQuoteDebouncer =
      Debouncer(delay: const Duration(milliseconds: 300));
  final Debouncer _sellQuoteDebouncer =
      Debouncer(delay: const Duration(milliseconds: 300));
  PollingService<TransferQuote?>? _buyQuotePollingService;
  PollingService<TransferQuote?>? _sellQuotePollingService;

  void updateFromToken(Token fromToken) {
    emit(state.copyWith(fromToken: fromToken));

    if (TokenValidator.isNativeToken(
      fromToken.address,
      network: fromToken.network ?? "",
    )) {
      emit(state.copyWith(isNativeToken: true));
    } else {
      emit(state.copyWith(isNativeToken: false));
    }
  }

  void startPollingQuote() {
    _buyQuotePollingService?.stop();
    _sellQuotePollingService?.stop();

    _buyQuotePollingService = PollingService<TransferQuote>(
      baseInterval: const Duration(seconds: 10),
      fetcher: (cancel) async {
        final quote = await getBuyQuote();
        if (quote == null) {
          throw Exception('Unable to fetch buy quote - invalid parameters');
        }
        return quote;
      },
      onError: (error, stack) async {
        emit(state.copyWith(
          buyQuote: null,
          buyQuoteStatus: QuickTradeQuoteStatus.initial,
        ));
        await SentryService().reportError(
          error,
          stack,
          tags: {"feature": "getBuyQuote"},
        );
      },
      onData: (quote) {
        Logger.error("getBuyQuote success: ${quote.toJson()}");
        emit(state.copyWith(
            buyQuote: quote, buyQuoteStatus: QuickTradeQuoteStatus.success));
      },
      onFinally: () {
        emit(state.copyWith(buyQuoteStatus: QuickTradeQuoteStatus.initial));
      },
    );

    _sellQuotePollingService = PollingService<TransferQuote>(
      baseInterval: const Duration(seconds: 10),
      fetcher: (cancel) async {
        final quote = await getSellQuote();
        if (quote == null) {
          throw Exception('Unable to fetch sell quote - invalid parameters');
        }
        return quote;
      },
      onError: (error, stack) async {
        emit(state.copyWith(
          sellQuote: null,
          sellQuoteStatus: QuickTradeQuoteStatus.initial,
        ));
        await SentryService().reportError(
          error,
          stack,
          tags: {"feature": "getSellQuote"},
        );
      },
      onData: (quote) {
        emit(
          state.copyWith(
              sellQuote: quote, sellQuoteStatus: QuickTradeQuoteStatus.success),
        );
      },
      onFinally: () {
        emit(state.copyWith(sellQuoteStatus: QuickTradeQuoteStatus.initial));
      },
    );

    _buyQuotePollingService?.start();
    _sellQuotePollingService?.start();
  }

  void stopPollingQuote() {
    _buyQuotePollingService?.stop();
    _sellQuotePollingService?.stop();
  }

  void updateSelectedToken(Token toToken) {
    emit(state.copyWith(selectedToken: toToken));
    _onUpdateSelectedToken(toToken);
  }

  void updateMode(QuickTradeMode mode) {
    emit(state.copyWith(mode: mode));
  }

  void updateBuyAmount(String buyAmount) async {
    emit(state.copyWith(buyAmount: buyAmount));

    _buyQuoteDebouncer.run(() {
      getBuyQuote();
    });
  }

  void updateSellPercent(String sellPercent) async {
    emit(state.copyWith(sellPercent: sellPercent));
    _sellQuoteDebouncer.run(() {
      getSellQuote();
    });
  }

  void _onUpdateSelectedToken(Token selectedToken) {
    final tokens = getIt<BalanceCubit>().state.balances?.tokens ?? [];

    final matches = tokens.where(
      (t) =>
          t.network.toString().toLowerCase() ==
              (selectedToken.network ?? "").toLowerCase() &&
          TokenValidator.isNativeToken(t.tokenAddress, network: t.network),
    );

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
          state.selectedToken?.network ?? "",
        );

        // 只在 selectedToken 不为 null 时更新 balance 字段
        if (state.selectedToken != null) {
          final updatedToken = state.selectedToken!.copyWith(balance: balance);
          emit(state.copyWith(selectedToken: updatedToken));
        }
      });
    });
  }

  Future<TransferQuote?> getBuyQuote() async {
    if (state.fromToken == null || state.selectedToken == null) {
      emit(state.copyWith(buyQuoteStatus: QuickTradeQuoteStatus.initial));
      return null;
    }

    if (TradeValidator.isChainIdEmpty(
      state.fromToken!.chainId.toString(),
      state.selectedToken!.chainId.toString(),
    )) {
      emit(state.copyWith(buyQuoteStatus: QuickTradeQuoteStatus.initial));
      return null;
    }

    if (TradeValidator.equalsToken(
      state.fromToken?.unique ?? "",
      state.selectedToken?.unique ?? "",
      state.fromToken?.address ?? "",
      state.selectedToken?.address ?? '',
    )) {
      emit(state.copyWith(buyQuoteStatus: QuickTradeQuoteStatus.initial));
      return null;
    }

    if (!state.buyAmount.isNotEmptyAndZeroValue) {
      emit(state.copyWith(buyQuoteStatus: QuickTradeQuoteStatus.initial));
      return null;
    }

    emit(state.copyWith(buyQuoteStatus: QuickTradeQuoteStatus.loading));

    // try {
    final newAmount = NumericUtils.multiplyByDecimalPower(
      state.buyAmount,
      state.fromToken!.decimals,
    ).toString();

    final settingOptions = tradeSettingCubit.getCurrentTradeCustomSetting();
    final settingMode = tradeSettingCubit.getTradeMode();

    final quote = await tradeApi.getQuote(
      network: state.fromToken!.network ?? "",
      fromChainId: state.fromToken!.unique,
      toChainId: state.selectedToken!.unique,
      inputMint: state.fromToken!.address,
      outputMint: state.selectedToken!.address,
      amount: newAmount,
      mode: settingMode,
      options: settingOptions,
      decimals: state.fromToken!.decimals,
    );
    return quote;
    //   emit(state.copyWith(buyQuote: quote));
    // } catch (e, s) {
    //   // emit(state.copyWith(quote: null));
    //   await SentryService().reportError(e, s, tags: {"feature": "getBuyQuote"});
    // }
  }

  Future<TransferQuote?> getSellQuote() async {
    // 添加 null 检查，与 getBuyQuote 保持一致
    if (state.fromToken == null || state.selectedToken == null) {
      emit(state.copyWith(sellQuoteStatus: QuickTradeQuoteStatus.initial));
      return null;
    }

    if (TradeValidator.isChainIdEmpty(
      state.fromToken!.chainId.toString(),
      state.selectedToken!.chainId.toString(),
    )) {
      emit(state.copyWith(sellQuoteStatus: QuickTradeQuoteStatus.initial));
      return null;
    }

    if (!state.sellPercent.isNotEmptyAndZeroValue) {
      emit(state.copyWith(sellQuoteStatus: QuickTradeQuoteStatus.initial));
      return null;
    }

    // try {
    final newAmount = NumericUtils.multiplyByDecimalPower(
      state.sellPercent.toPercentage().safeMultiply(
            state.selectedToken?.balance ?? "0",
          ),
      state.selectedToken!.decimals,
    ).toString();

    emit(state.copyWith(sellQuoteStatus: QuickTradeQuoteStatus.loading));

    final settingOptions = tradeSettingCubit.getCurrentTradeCustomSetting();
    final settingMode = tradeSettingCubit.getTradeMode();

    final quote = await tradeApi.getQuote(
      network: state.fromToken?.network ?? "",
      fromChainId: state.selectedToken!.chainId,
      toChainId: state.selectedToken!.chainId,
      inputMint: state.selectedToken!.address,
      outputMint: getOutputMint(state.fromToken?.network ?? ""),
      amount: newAmount,
      mode: settingMode,
      options: settingOptions,
      decimals: state.fromToken!.decimals,
    );

    return quote;
    // 更新询价时间戳

    //   emit(state.copyWith(sellQuote: quote));
    // } catch (e, s) {
    //   await SentryService()
    //       .reportError(e, s, tags: {"feature": "getSellQuote"});
    // }
  }

  // ignore: use_build_context_synchronously
  Future<void> buyToken(BuildContext context) async {
    // 如果正在交易中，直接返回，防止重复提交
    if (state.buyTokenStatus == const BuyTokenStatus.loading()) {
      return;
    }

    if (state.fromToken == null || state.selectedToken == null) {
      emit(
        state.copyWith(
          buyTokenStatus: const BuyTokenStatus.failure(BuyTokenFailure.unknown),
        ),
      );

      return;
    }

    if (state.fromToken?.address == state.selectedToken?.address) {
      emit(
        state.copyWith(
          buyTokenStatus: const BuyTokenStatus.failure(BuyTokenFailure.unknown),
        ),
      );

      return;
    }

    if (state.fromToken?.chainId == null ||
        state.selectedToken?.chainId == null) {
      emit(
        state.copyWith(
          buyTokenStatus: const BuyTokenStatus.failure(BuyTokenFailure.unknown),
        ),
      );
      return;
    }

    if (!state.buyAmount.isNotEmptyAndZeroValue) {
      return;
    }

    if (!buyAmountIsEnoughFee()) {
      return;
    }

    emit(state.copyWith(buyTokenStatus: const BuyTokenStatus.loading()));
    try {
      final settingOptions = tradeSettingCubit.getCurrentTradeCustomSetting();
      final newAmount = NumericUtils.multiplyByDecimalPower(
        state.buyAmount,
        state.fromToken!.decimals,
      );

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
        decimals: state.fromToken!.decimals,
      );
      Logger.error("buyToken hash: ${response.txHash}");

      _transactionStatusTimer?.cancel();

      _transactionStatusTimer = Timer.periodic(const Duration(seconds: 2), (
        timer,
      ) {
        getTransactionStatus(
          response,
          state.fromToken!.chainId,
          state.fromToken!.decimals,
          (result) {
            _handleTradeSuccess(result, context, QuickTradeMode.buy);
          },
          () async {
            _handleTradeFailure(QuickTradeMode.buy);
          },
        );
      });
    } on DioException catch (e) {
      final errorMessage = ErrorHandlerUtils.getErrorMessageFromException(
        e,
        context,
      );
      _handleTradeFailure(QuickTradeMode.buy, errorMessage: errorMessage);
    } catch (e) {
      final errorMessage = ErrorHandlerUtils.getErrorMessageFromException(
        e,
        context,
      );
      _handleTradeFailure(QuickTradeMode.buy, errorMessage: errorMessage);
    }
  }

  Future<void> sellToken(BuildContext context) async {
    // 如果正在交易中，直接返回，防止重复提交
    if (state.sellTokenStatus == const SellTokenStatus.loading()) {
      return;
    }

    if (state.fromToken == null) {
      Logger.error("sellToken fromToken is null");

      emit(
        state.copyWith(
          sellTokenStatus: const SellTokenStatus.failure(
            SellTokenFailure.unknown,
          ),
        ),
      );
      return;
    }

    if (state.fromToken?.chainId == null) {
      Logger.error("sellToken chainId is null");
      emit(
        state.copyWith(
          sellTokenStatus: const SellTokenStatus.failure(
            SellTokenFailure.unknown,
          ),
        ),
      );

      return;
    }

    if (state.fromToken?.address.isEmpty ?? true) {
      Logger.error("sellToken address is empty");
      emit(
        state.copyWith(
          sellTokenStatus: const SellTokenStatus.failure(
            SellTokenFailure.unknown,
          ),
        ),
      );

      return;
    }

    if (state.fromToken?.chainId == null) {
      Logger.error("sellToken chainId is null");
      emit(
        state.copyWith(
          sellTokenStatus: const SellTokenStatus.failure(
            SellTokenFailure.unknown,
          ),
        ),
      );

      return;
    }

    if (!state.sellPercent.isNotEmptyAndZeroValue) {
      return;
    }

    if (!sellAmountIsEnoughFee()) {
      return;
    }

    emit(state.copyWith(sellTokenStatus: const SellTokenStatus.loading()));
    try {
      final sellAmount = await _computedAmounPercentage(
        state.sellPercent,
        state.selectedToken?.balance ?? "0",
      );

      final wallet = await walletStorage.getSelectedWallet();
      final settingOptions = tradeSettingCubit.getCurrentTradeCustomSetting();
      final newAmount = NumericUtils.multiplyByDecimalPower(
        sellAmount.toString(),
        state.selectedToken!.decimals,
      );

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
        decimals: state.selectedToken!.decimals,
      );

      Logger.error("sellToken hash: ${response.txHash}");

      _transactionStatusTimer?.cancel();

      _transactionStatusTimer = Timer.periodic(const Duration(seconds: 2), (
        timer,
      ) {
        getTransactionStatus(
          response,
          state.fromToken!.chainId,
          state.fromToken!.decimals,
          (result) {
            _handleTradeSuccess(result, context, QuickTradeMode.sell);
          },
          () async {
            _handleTradeFailure(QuickTradeMode.sell);
          },
        );
      });
    } on DioException catch (e) {
      final errorMessage = ErrorHandlerUtils.getErrorMessageFromException(
        e,
        context,
      );
      Future.delayed(const Duration(seconds: 2), () {
        _handleTradeFailure(QuickTradeMode.sell, errorMessage: errorMessage);
      });
    } catch (e) {
      final errorMessage = ErrorHandlerUtils.getErrorMessageFromException(
        e,
        context,
      );
      Future.delayed(const Duration(seconds: 2), () {
        _handleTradeFailure(QuickTradeMode.sell, errorMessage: errorMessage);
      });
    }
  }

  Future<num?> _computedAmounPercentage(
    String percentage,
    String balance,
  ) async {
    if (percentage == "100") {
      return double.tryParse(balance) ?? 0;
    }

    final amount = NumericUtils.multiplyTwoNumbers(percentage, balance);
    return double.tryParse(amount.toString()) ?? 0;
  }

  void _handleTradeSuccess(
    TransferTransaction result,
    BuildContext context,
    QuickTradeMode mode,
  ) {
    // 不需要在这里更新 balance 因为在进入钱包页面的时候会自动刷新
    Logger.info(
      "handleTradeSuccess sell: ${result.txHash} ${mode.name} ${mode.name == QuickTradeMode.sell.name}",
    );
    if (mode.name == QuickTradeMode.sell.name) {
      emit(state.copyWith(sellTokenStatus: SellTokenStatus.success(result)));
    } else {
      emit(state.copyWith(buyTokenStatus: BuyTokenStatus.success(result)));
    }
  }

  void _handleTradeFailure(QuickTradeMode mode, {String? errorMessage}) async {
    Logger.error(
      "handleTradeFailure: ${mode.name} ${mode.name == QuickTradeMode.sell.name}",
    );

    // 显示错误提示 - 如果有具体错误消息就显示，否则显示默认消息
    if (errorMessage != null) {
      TradeStatusToastUtils.showFailedToast(message: errorMessage);
    }

    if (mode.name == QuickTradeMode.sell.name) {
      emit(
        state.copyWith(
          sellTokenStatus: const SellTokenStatus.failure(
            SellTokenFailure.unknown,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          buyTokenStatus: const BuyTokenStatus.failure(BuyTokenFailure.unknown),
        ),
      );
    }

    await SentryService().reportError(
      "${mode.name} token failure status",
      StackTrace.fromString(""),
      tags: {"feature": "${mode.name}Token"},
    );
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
        network: state.fromToken!.network ?? "",
      );

      Logger.error(
        "getTrasactionStatus: ${response.status} ${response.status == TransactionStatusEnum.success.value}",
      );
      if (response.status == TransactionStatusEnum.success.value) {
        success(transaction.copyWith(txHash: transaction.txHash));
        _transactionStatusTimer?.cancel();
      } else if (response.status == TransactionStatusEnum.failed.value) {
        failure();
        _transactionStatusTimer?.cancel();
      }
    } catch (e, s) {
      _transactionStatusTimer?.cancel();
      failure();
      await SentryService().reportError(
        e,
        s,
        tags: {"feature": "getTransactionStatus"},
      );
    }
  }

  Future<String> getBalanceByAddress(String address, String network) async {
    final balances = balanceCubit.state.balances?.tokens ?? [];
    final normalizedAddress = address.toLowerCase();
    final normalizedNetwork = network.toLowerCase();

    final matches = balances.where(
      (token) =>
          token.tokenAddress.toLowerCase() == normalizedAddress &&
          token.network.toLowerCase() == normalizedNetwork,
    );

    if (matches.isEmpty) {
      return "0";
    }

    // 直接返回原始字符串，避免 double 转换导致的精度丢失
    return matches.first.balance;
  }

  @override
  Future<void> close() {
    _balanceCubitStream.cancel();
    _transactionStatusTimer?.cancel();
    stopPollingQuote();
    return super.close();
  }

  void clear() {
    emit(
      state.copyWith(
        fromToken: null,
        selectedToken: null,
        buyAmount: "",
        sellPercent: "",
        buyTokenStatus: const BuyTokenStatus.initial(),
        sellTokenStatus: const SellTokenStatus.initial(),
        buyQuote: null,
        sellQuote: null,
      ),
    );
  }

  bool buyAmountIsEnoughFee() {
    final fee = state.buyQuote?.fee?.toDouble() ?? 0.0;

    final balance = NumericUtils.multiplyByDecimalPower(
      state.fromToken?.balance ?? "0",
      state.fromToken!.decimals,
    ).toString();

    final remainingBalance = balance.toDouble() - fee;

    return remainingBalance >= 0;
  }

  bool sellAmountIsEnoughFee() {
    final fee = state.sellQuote?.fee?.toDouble() ?? 0.0;

    final balance = NumericUtils.multiplyByDecimalPower(
      state.selectedToken?.balance ?? "0",
      state.selectedToken!.decimals,
    );

    final remainingBalance = balance.toDouble() - fee;

    return remainingBalance >= 0;
  }
}
