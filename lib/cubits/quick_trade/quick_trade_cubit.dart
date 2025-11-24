import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/polling/polling_service.dart';
import '../../core/service_locator.dart';
import '../../data/models/transfer/index.dart';
import '../../data/services/api/index.dart';
import '../../data/services/sentry_service.dart';
import '../../enums/transaction.dart';
import '../../shared/utils/get_output_mint.dart';
import '../../utils/debouncer.dart';
import '../../utils/error_handler_utils.dart';
import '../../utils/extensions/string.dart';
import '../../utils/logger.dart';
import '../../utils/numeric_utils.dart';
import '../../utils/storage/local/wallet_storage.dart';
import '../../utils/toast/trade_status_toast.dart';
import '../../utils/validators/index.dart';
import '../../utils/validators/trade_validator.dart';
import '../../widgets/token/models/token.dart';
import '../index.dart';

class QuickTradeCubit extends Cubit<QuickTradeState> {
  late final StreamSubscription<BalanceState> _balanceCubitStream;
  QuickTradeCubit(
    this.tradeApi,
    this.tradeSettingCubit,
    this.walletStorage,
    this.balanceCubit,
  ) : super(const QuickTradeState());

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
  bool _isPollingTransaction = false;

  // 添加请求版本控制，防止过期的请求更新状态
  int _buyQuoteRequestVersion = 0;
  int _sellQuoteRequestVersion = 0;

  // 添加轮询活动状态标记
  bool _isPollingActive = false;

  void updateFromToken(Token fromToken) {
    emit(state.copyWith(fromToken: fromToken));

    if (TokenValidator.isNativeToken(
      fromToken.address,
      network: fromToken.network ?? '',
    )) {
      emit(state.copyWith(isNativeToken: true));
    } else {
      emit(state.copyWith(isNativeToken: false));
    }
  }

  void startPollingQuote() {
    // 先停止现有的轮询服务
    _buyQuotePollingService?.stop();
    _sellQuotePollingService?.stop();

    // 标记轮询为活动状态
    _isPollingActive = true;

    // 添加小延迟确保清理完成，防止轮询服务重叠
    Future.delayed(const Duration(milliseconds: 100), () {
      // 如果轮询已被停止，则不继续
      if (!_isPollingActive) return;

      if (state.mode.name == QuickTradeMode.buy.name) {
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
              tags: {'feature': 'getBuyQuote'},
            );
          },
          onData: (quote) {
            Logger.error('getBuyQuote success: ${quote.toJson()}');
            emit(state.copyWith(
                buyQuote: quote,
                buyQuoteStatus: QuickTradeQuoteStatus.success));
          },
        );
        _buyQuotePollingService?.start();
      } else {
        _sellQuotePollingService = PollingService<TransferQuote>(
          baseInterval: const Duration(seconds: 10),
          fetcher: (cancel) async {
            final quote = await getSellQuote();
            if (quote == null) {
              throw Exception(
                  'Unable to fetch sell quote - invalid parameters');
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
              tags: {'feature': 'getSellQuote'},
            );
          },
          onData: (quote) {
            Logger.info('getSellQuote success gasFee: ${quote.gasFee}');
            emit(
              state.copyWith(
                  sellQuote: quote,
                  sellQuoteStatus: QuickTradeQuoteStatus.success),
            );
          },
        );
        _sellQuotePollingService?.start();
      }
    });
  }

  void stopPollingQuote() {
    // 标记轮询为非活动状态
    _isPollingActive = false;

    _buyQuotePollingService?.stop();
    _sellQuotePollingService?.stop();

    // 停止轮询时不清除询价状态，保留最后有效的询价
    // 这样可以在快速开关面板时保持询价显示
  }

  void updateSelectedToken(Token toToken) {
    emit(state.copyWith(selectedToken: toToken));
    _onUpdateSelectedToken(toToken);
  }

  void updateMode(QuickTradeMode mode) {
    emit(state.copyWith(mode: mode));
    stopPollingQuote();
    startPollingQuote();
  }

  void updateBuyAmount(String buyAmount) async {
    // 取消任何待处理的防抖调用
    _buyQuoteDebouncer.cancel();

    emit(state.copyWith(buyAmount: buyAmount));

    // 只在有效金额时才防抖
    if (buyAmount.isNotEmpty && buyAmount != '0') {
      _buyQuoteDebouncer.run(() {
        getBuyQuote();
      });
    }
  }

  void updateSellPercent(String sellPercent) async {
    // 取消任何待处理的防抖调用
    _sellQuoteDebouncer.cancel();

    emit(state.copyWith(sellPercent: sellPercent));

    // 只在有效百分比时才防抖
    if (sellPercent.isNotEmpty && sellPercent != '0') {
      _sellQuoteDebouncer.run(() {
        getSellQuote();
      });
    }
  }

  void _onUpdateSelectedToken(Token selectedToken) {
    final tokens = getIt<BalanceCubit>().state.balances?.tokens ?? [];

    final matches = tokens.where(
      (t) =>
          t.network.toString().toLowerCase() ==
              (selectedToken.network ?? '').toLowerCase() &&
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
          state.selectedToken?.address ?? '',
          state.selectedToken?.network ?? '',
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
    // 增加请求版本号
    final currentVersion = ++_buyQuoteRequestVersion;

    // 如果已经在加载中，不重复设置加载状态
    if (state.buyQuoteStatus == QuickTradeQuoteStatus.loading) {
      return null;
    }

    if (state.fromToken == null || state.selectedToken == null) {
      emit(state.copyWith(buyQuoteStatus: QuickTradeQuoteStatus.initial));
      return null;
    }

    if (TradeValidator.isChainIdEmpty(
      state.fromToken!.unique.toString(),
      state.selectedToken!.unique.toString(),
    )) {
      emit(state.copyWith(buyQuoteStatus: QuickTradeQuoteStatus.initial));
      return null;
    }

    if (TradeValidator.equalsToken(
      state.fromToken?.unique ?? '',
      state.selectedToken?.unique ?? '',
      state.fromToken?.address ?? '',
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

    try {
      final newAmount = NumericUtils.multiplyByDecimalPower(
        state.buyAmount,
        state.fromToken!.decimals,
      ).toString();

      final settingOptions = tradeSettingCubit.getCurrentTradeCustomSetting();
      final settingMode = tradeSettingCubit.getTradeMode();

      final quote = await tradeApi.getQuote(
        network: state.fromToken!.network ?? '',
        fromChainId: state.fromToken!.unique,
        toChainId: state.selectedToken!.unique,
        inputMint: state.fromToken!.address,
        outputMint: state.selectedToken!.address,
        amount: newAmount,
        mode: settingMode,
        options: settingOptions,
        decimals: state.fromToken!.decimals,
      );

      // 只有当这仍是最新请求时才更新状态
      if (currentVersion == _buyQuoteRequestVersion) {
        emit(state.copyWith(
          buyQuote: quote,
          buyQuoteStatus: QuickTradeQuoteStatus.success,
        ));
      }

      return quote;
    } catch (e, s) {
      // 只有当这仍是最新请求时才更新错误状态
      if (currentVersion == _buyQuoteRequestVersion) {
        emit(state.copyWith(
          buyQuote: null,
          buyQuoteStatus: QuickTradeQuoteStatus.initial,
        ));
      }
      await SentryService().reportError(e, s, tags: {'feature': 'getBuyQuote'});
      return null;
    }
  }

  Future<TransferQuote?> getSellQuote() async {
    // 增加请求版本号
    final currentVersion = ++_sellQuoteRequestVersion;

    // 如果已经在加载中，不重复设置加载状态
    if (state.sellQuoteStatus == QuickTradeQuoteStatus.loading) {
      return null;
    }

    // 添加 null 检查，与 getBuyQuote 保持一致
    if (state.fromToken == null || state.selectedToken == null) {
      emit(state.copyWith(sellQuoteStatus: QuickTradeQuoteStatus.initial));
      return null;
    }

    if (TradeValidator.isChainIdEmpty(
      state.fromToken!.unique.toString(),
      state.selectedToken!.unique.toString(),
    )) {
      emit(state.copyWith(sellQuoteStatus: QuickTradeQuoteStatus.initial));
      return null;
    }

    if (!state.sellPercent.isNotEmptyAndZeroValue) {
      emit(state.copyWith(sellQuoteStatus: QuickTradeQuoteStatus.initial));
      return null;
    }

    try {
      final newAmount = NumericUtils.multiplyByDecimalPower(
        state.sellPercent.toPercentage().safeMultiply(
              state.selectedToken?.balance ?? '0',
            ),
        state.selectedToken!.decimals,
      ).toString();

      if (!newAmount.isNotEmptyAndZeroValue) {
        return null;
      }

      emit(state.copyWith(sellQuoteStatus: QuickTradeQuoteStatus.loading));

      final settingOptions = tradeSettingCubit.getCurrentTradeCustomSetting();
      final settingMode = tradeSettingCubit.getTradeMode();

      final quote = await tradeApi.getQuote(
        network: state.fromToken?.network ?? '',
        fromChainId: state.selectedToken!.unique,
        toChainId: state.selectedToken!.unique,
        inputMint: state.selectedToken!.address,
        outputMint: getOutputMint(state.fromToken?.network ?? ''),
        amount: newAmount,
        mode: settingMode,
        options: settingOptions,
        decimals: state.fromToken!.decimals,
      );

      // 只有当这仍是最新请求时才更新状态
      if (currentVersion == _sellQuoteRequestVersion) {
        emit(state.copyWith(
          sellQuote: quote,
          sellQuoteStatus: QuickTradeQuoteStatus.success,
        ));
      }

      return quote;
    } catch (e, s) {
      // 只有当这仍是最新请求时才更新错误状态
      if (currentVersion == _sellQuoteRequestVersion) {
        emit(state.copyWith(
          sellQuote: null,
          sellQuoteStatus: QuickTradeQuoteStatus.initial,
        ));
      }
      await SentryService()
          .reportError(e, s, tags: {'feature': 'getSellQuote'});
      return null;
    }
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

    if (state.fromToken?.unique == null ||
        state.selectedToken?.unique == null) {
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

    emit(state.copyWith(
      buyTokenStatus: const BuyTokenStatus.loading(),
      sellTokenStatus: const SellTokenStatus.initial(),
    ));
    try {
      final settingOptions = tradeSettingCubit.getCurrentTradeCustomSetting();
      final newAmount = NumericUtils.multiplyByDecimalPower(
        state.buyAmount,
        state.fromToken!.decimals,
      );

      final wallet = await walletStorage.getSelectedWallet();

      final response = await tradeApi.swap(
        network: state.fromToken?.network ?? '',
        fromChainId: state.fromToken?.unique ?? '',
        toChainId: state.selectedToken?.unique ?? '',
        inputMint: state.fromToken!.address,
        outputMint: state.selectedToken!.address,
        amount: newAmount.toString(),
        walletId: wallet?.id ?? '',
        options: settingOptions,
        mode: tradeSettingCubit.getTradeMode(),
        decimals: state.fromToken!.decimals,
      );

      _transactionStatusTimer?.cancel();

      _transactionStatusTimer = Timer.periodic(const Duration(seconds: 2), (
        timer,
      ) async {
        if (_isPollingTransaction) return;
        _isPollingTransaction = true;

        try {
          await getTransactionStatus(
            response,
            state.fromToken!.unique,
            state.fromToken!.decimals,
            (result) {
              _handleTradeSuccess(result, context, QuickTradeMode.buy);
            },
            () async {
              _handleTradeFailure(QuickTradeMode.buy);
            },
          );
        } finally {
          _isPollingTransaction = false;
        }
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
      Logger.error('sellToken fromToken is null');

      emit(
        state.copyWith(
          sellTokenStatus: const SellTokenStatus.failure(
            SellTokenFailure.unknown,
          ),
        ),
      );
      return;
    }

    if (state.fromToken?.unique == null) {
      Logger.error('sellToken chainId is null');
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
      Logger.error('sellToken address is empty');
      emit(
        state.copyWith(
          sellTokenStatus: const SellTokenStatus.failure(
            SellTokenFailure.unknown,
          ),
        ),
      );

      return;
    }

    if (state.fromToken?.unique == null) {
      Logger.error('sellToken chainId is null');
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

    emit(state.copyWith(
      sellTokenStatus: const SellTokenStatus.loading(),
      buyTokenStatus: const BuyTokenStatus.initial(),
    ));
    try {
      final sellAmount = await _computedAmounPercentage(
        state.sellPercent,
        state.selectedToken?.balance ?? '0',
      );

      final wallet = await walletStorage.getSelectedWallet();
      final settingOptions = tradeSettingCubit.getCurrentTradeCustomSetting();

      Logger.error(
          'state.selectedToken!.decimals: ${state.selectedToken!.decimals}');
      final newAmount = NumericUtils.multiplyByDecimalPower(
        sellAmount.toString(),
        state.selectedToken!.decimals,
      );
      Logger.error('newAmount: $newAmount');

      final response = await tradeApi.swap(
        network: state.fromToken?.network ?? '',
        fromChainId: state.selectedToken?.unique ?? '',
        toChainId: state.selectedToken?.unique ?? '',
        inputMint: state.selectedToken!.address,
        outputMint: getOutputMint(state.fromToken!.network ?? ''), //
        amount: newAmount.toString(),
        walletId: wallet?.id ?? '',
        options: settingOptions,
        mode: tradeSettingCubit.getTradeMode(),
        decimals: state.selectedToken!.decimals,
      );

      _transactionStatusTimer?.cancel();

      _transactionStatusTimer = Timer.periodic(const Duration(seconds: 2), (
        timer,
      ) async {
        if (_isPollingTransaction) return;
        _isPollingTransaction = true;

        try {
          await getTransactionStatus(
            response,
            state.fromToken!.unique,
            state.fromToken!.decimals,
            (result) {
              _handleTradeSuccess(result, context, QuickTradeMode.sell);
            },
            () async {
              _handleTradeFailure(QuickTradeMode.sell);
            },
          );
        } finally {
          _isPollingTransaction = false;
        }
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
    if (percentage == '100') {
      return double.tryParse(balance) ?? 0;
    }

    final amount = NumericUtils.multiplyTwoNumbers(percentage, balance);
    // 除以 25 / 100
    return (amount / 100).toDouble();
  }

  void _handleTradeSuccess(
    TransferTransaction result,
    BuildContext context,
    QuickTradeMode mode,
  ) {
    // 不需要在这里更新 balance 因为在进入钱包页面的时候会自动刷新
    Logger.info(
      'handleTradeSuccess sell: ${result.txHash} ${mode.name} ${mode.name == QuickTradeMode.sell.name}',
    );
    if (mode.name == QuickTradeMode.sell.name) {
      emit(state.copyWith(sellTokenStatus: SellTokenStatus.success(result)));
    } else {
      emit(state.copyWith(buyTokenStatus: BuyTokenStatus.success(result)));
    }
  }

  void _handleTradeFailure(QuickTradeMode mode, {String? errorMessage}) async {
    Logger.error(
      'handleTradeFailure: ${mode.name} ${mode.name == QuickTradeMode.sell.name}',
    );

    // 显示错误提示 - 如果有具体错误消息就显示，否则显示默认消息
    // if (errorMessage != null) {
    TradeStatusToastUtils.showFailedToast(message: errorMessage);
    // }

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
      '${mode.name} token failure status',
      StackTrace.fromString(''),
      tags: {'feature': '${mode.name}Token'},
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
        txHash: transaction.txHash ?? '',
        chainId: chainId.toString(),
        network: state.fromToken!.network ?? '',
      );

      Logger.error(
        'getTrasactionStatus: ${response.status} ${response.status == TransactionStatusEnum.success.value}',
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
        tags: {'feature': 'getTransactionStatus'},
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
      return '0';
    }

    // 直接返回原始字符串，避免 double 转换导致的精度丢失
    return matches.first.balance;
  }

  @override
  Future<void> close() {
    // 取消防抖器，防止延迟执行
    _buyQuoteDebouncer.cancel();
    _sellQuoteDebouncer.cancel();

    _balanceCubitStream.cancel();
    _transactionStatusTimer?.cancel();
    stopPollingQuote();
    return super.close();
  }

  void clear() {
    // 停止轮询和取消防抖
    stopPollingQuote();
    _buyQuoteDebouncer.cancel();
    _sellQuoteDebouncer.cancel();

    // 重置请求版本
    _buyQuoteRequestVersion = 0;
    _sellQuoteRequestVersion = 0;

    emit(
      state.copyWith(
        fromToken: null,
        selectedToken: null,
        buyAmount: '',
        sellPercent: '',
        buyTokenStatus: const BuyTokenStatus.initial(),
        sellTokenStatus: const SellTokenStatus.initial(),
        buyQuote: null,
        sellQuote: null,
        buyQuoteStatus: QuickTradeQuoteStatus.initial,
        sellQuoteStatus: QuickTradeQuoteStatus.initial,
      ),
    );
  }

  bool buyAmountIsEnoughFee() {
    final fee = state.buyQuote?.fee?.toDouble() ?? 0.0;

    if (state.fromToken == null) return false;

    if (state.fromToken!.isNative) {
      final balance = NumericUtils.multiplyByDecimalPower(
        state.fromToken?.balance ?? '0',
        state.fromToken!.decimals,
      ).toString();

      final remainingBalance = balance.toDouble() - fee;
      return remainingBalance >= 0;
    }

    final nativeToken = _getNativeToken(state.fromToken!.network);
    if (nativeToken == null) {
      Logger.error('Native token not found for ${state.fromToken!.network}');
      return false;
    }

    final nativeBalance = NumericUtils.multiplyByDecimalPower(
      nativeToken.balance,
      nativeToken.decimals,
    ).toString();

    final remainingBalance = nativeBalance.toDouble() - fee;
    return remainingBalance >= 0;
  }

  bool sellAmountIsEnoughFee() {
    final fee = state.sellQuote?.fee?.toDouble() ?? 0.0;

    if (state.selectedToken == null) return false;

    if (state.selectedToken!.isNative) {
      final balance = NumericUtils.multiplyByDecimalPower(
        state.selectedToken?.balance ?? '0',
        state.selectedToken!.decimals,
      ).toString();

      final remainingBalance = balance.toDouble() - fee;

      Logger.info('remainingBalance: $remainingBalance');

      return remainingBalance >= 0;
    }

    final nativeToken = _getNativeToken(state.selectedToken!.network);
    if (nativeToken == null) {
      Logger.error(
          'Native token not found for ${state.selectedToken!.network}');
      return false;
    }

    final nativeBalance = NumericUtils.multiplyByDecimalPower(
      nativeToken.balance,
      nativeToken.decimals,
    ).toString();

    final remainingBalance = nativeBalance.toDouble() - fee;

    Logger.info('Native balance check for fee: $remainingBalance (Fee: $fee)');

    return remainingBalance >= 0;
  }

  Token? _getNativeToken(String? network) {
    if (network == null) return null;
    final tokens = balanceCubit.state.balances?.tokens ?? [];

    try {
      final match = tokens.firstWhere(
        (t) =>
            t.network.toLowerCase() == network.toLowerCase() &&
            TokenValidator.isNativeToken(t.tokenAddress, network: t.network),
      );
      return Token.fromBalance(match);
    } catch (e) {
      return null;
    }
  }
}
