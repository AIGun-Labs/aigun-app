import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constant/count.dart';
import '../../core/polling/polling_service.dart';
import '../../core/service_locator.dart';
import '../../core/utils/balance_calculator.dart';
import '../../core/utils/calculator.dart';
import '../../core/utils/token_handler.dart';
import '../../data/models/transfer/index.dart';
import '../../data/services/api/index.dart';
import '../../data/services/sentry_service.dart';
import '../../enums/transaction.dart';
import '../../shared/trade/trade_button_state.dart';
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
    this._tradeApi,
    this._tradeSettingCubit,
    this._walletStorage,
    this._balanceCubit,
  ) : super(const QuickTradeState());

  Timer? _transactionStatusTimer;

  final TradeApi _tradeApi;
  final TradeSettingCubit _tradeSettingCubit;
  final WalletStorage _walletStorage;

  final BalanceCubit _balanceCubit;
  final Debouncer _buyQuoteDebouncer = Debouncer(
    delay: const Duration(milliseconds: 300),
  );
  final Debouncer _sellQuoteDebouncer = Debouncer(
    delay: const Duration(milliseconds: 300),
  );
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
          baseInterval: Duration(seconds: NumericConstants.ten),
          fetcher: (cancel) async {
            final quote = await getBuyQuote();
            if (quote == null) {
              throw Exception('Unable to fetch buy quote - invalid parameters');
            }
            return quote;
          },
          onError: (error, stack) async {
            emit(
              state.copyWith(
                buyQuote: null,
                buyQuoteStatus: QuickTradeQuoteStatus.initial,
              ),
            );
            await SentryService().reportError(
              error,
              stack,
              tags: {'feature': 'getBuyQuote'},
            );
          },
          onData: (quote) {
            Logger.error('getBuyQuote success: ${quote.toJson()}');
            emit(
              state.copyWith(
                buyQuote: quote,
                buyQuoteStatus: QuickTradeQuoteStatus.success,
              ),
            );
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
                'Unable to fetch sell quote - invalid parameters',
              );
            }
            return quote;
          },
          onError: (error, stack) async {
            emit(
              state.copyWith(
                sellQuote: null,
                sellQuoteStatus: QuickTradeQuoteStatus.initial,
              ),
            );
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
                sellQuoteStatus: QuickTradeQuoteStatus.success,
              ),
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

  void initialize() {
    // 监听 balanceCubit，更新 selectedToken 的 balance 字段
    _balanceCubitStream = _balanceCubit.stream.listen((balanceState) {
      // 异步处理，避免在 build 阶段触发状态更新
      Future.microtask(() async {
        final token = BalanceCalculator.getBalanceFromList(
          address: state.selectedToken?.address ?? '',
          network: state.selectedToken?.network ?? '',
          balances: _balanceCubit.state.balances?.tokens,
        );

        // 只在 selectedToken 不为 null 时更新 balance 字段
        if (state.selectedToken != null) {
          final updatedToken = state.selectedToken!.copyWith(
            balance: token?.balance ?? '0',
          );
          emit(state.copyWith(selectedToken: updatedToken));
        }
      });
    });
  }

  Future<TransferQuote?> getBuyQuote() async {
    // 增加请求版本号
    final currentVersion= ++_buyQuoteRequestVersion;

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

    final isEnoughFee = balanceIsEnough(
      token: state.fromToken,
      fee: state.buyQuote?.fee ?? '0',
    );

    // 只有余额充足才显示加载中状态
    if (isEnoughFee) {
      emit(state.copyWith(buyQuoteStatus: QuickTradeQuoteStatus.loading));
    }

    try {
      final newAmount = NumericUtils.multiplyByDecimalPower(
        state.buyAmount,
        state.fromToken!.decimals,
      ).toString();

      final settingOptions = _tradeSettingCubit.getCurrentTradeCustomSetting();
      final settingMode = _tradeSettingCubit.getTradeMode();

      final quote = await _tradeApi.getQuote(
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
        emit(
          state.copyWith(
            buyQuote: quote,
            buyQuoteStatus: QuickTradeQuoteStatus.success,
          ),
        );
      }

      return quote;
    } catch (e, s) {
      // 只有当这仍是最新请求时才更新错误状态
      if (currentVersion == _buyQuoteRequestVersion) {
        emit(
          state.copyWith(
            buyQuote: null,
            buyQuoteStatus: QuickTradeQuoteStatus.initial,
          ),
        );
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

      final settingOptions = _tradeSettingCubit.getCurrentTradeCustomSetting();
      final settingMode = _tradeSettingCubit.getTradeMode();

      final quote = await _tradeApi.getQuote(
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
        emit(
          state.copyWith(
            sellQuote: quote,
            sellQuoteStatus: QuickTradeQuoteStatus.success,
          ),
        );
      }

      return quote;
    } catch (e, s) {
      // 只有当这仍是最新请求时才更新错误状态
      if (currentVersion == _sellQuoteRequestVersion) {
        emit(
          state.copyWith(
            sellQuote: null,
            sellQuoteStatus: QuickTradeQuoteStatus.initial,
          ),
        );
      }
      await SentryService().reportError(
        e,
        s,
        tags: {'feature': 'getSellQuote'},
      );
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

    if (!balanceIsEnough(
      token: state.fromToken,
      fee: state.buyQuote?.fee ?? '0',
    )) {
      return;
    }

    emit(
      state.copyWith(
        buyTokenStatus: const BuyTokenStatus.loading(),
        sellTokenStatus: const SellTokenStatus.initial(),
      ),
    );
    try {
      final settingOptions = _tradeSettingCubit.getCurrentTradeCustomSetting();
      final newAmount = NumericUtils.multiplyByDecimalPower(
        state.buyAmount,
        state.fromToken!.decimals,
      );

      final wallet = await _walletStorage.getSelectedWallet();

      final response = await _tradeApi.swap(
        network: state.fromToken?.network ?? '',
        fromChainId: state.fromToken?.unique ?? '',
        toChainId: state.selectedToken?.unique ?? '',
        inputMint: state.fromToken!.address,
        outputMint: state.selectedToken!.address,
        amount: newAmount.toString(),
        walletId: wallet?.id ?? '',
        options: settingOptions,
        mode: _tradeSettingCubit.getTradeMode(),
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

    if (!balanceIsEnough(
      token: state.selectedToken,
      fee: state.sellQuote?.fee ?? '0',
    )) {
      return;
    }

    emit(
      state.copyWith(
        sellTokenStatus: const SellTokenStatus.loading(),
        buyTokenStatus: const BuyTokenStatus.initial(),
      ),
    );
    try {
      final sellAmount = await _percentageToAmount(
        state.sellPercent,
        state.selectedToken?.balance ?? '0',
      );

      final wallet = await _walletStorage.getSelectedWallet();
      final settingOptions = _tradeSettingCubit.getCurrentTradeCustomSetting();

      Logger.error(
        'state.selectedToken!.decimals: ${state.selectedToken!.decimals}',
      );

      final amount = Calculator.toAtomicUnits(
        sellAmount ?? '',
        state.selectedToken?.decimals ?? 0,
      );

      final response = await _tradeApi.swap(
        network: state.fromToken?.network ?? '',
        fromChainId: state.selectedToken?.unique ?? '',
        toChainId: state.selectedToken?.unique ?? '',
        inputMint: state.selectedToken!.address,
        outputMint: getOutputMint(state.fromToken!.network ?? ''), //
        amount: amount.toString(),
        walletId: wallet?.id ?? '',
        options: settingOptions,
        mode: _tradeSettingCubit.getTradeMode(),
        decimals: state.selectedToken!.decimals,
      );

      _transactionStatusTimer?.cancel();

      _transactionStatusTimer = Timer.periodic(
        Duration(seconds: NumericConstants.two),
        (timer) async {
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
        },
      );
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

  // Future<num?> _computedAmounPercentage(
  Future<String?> _percentageToAmount(String percentage, String balance) async {
    if (percentage == '100') {
      return balance;
    }

    final amount = Calculator.multiplyTwo(percentage, balance);
    // 除以 25 / 100
    return Calculator.divideTwo(amount, 100);
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
    final balances = _balanceCubit.state.balances?.tokens ?? [];
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

  /// 检查余额是否充足
  bool balanceIsEnough({required Token? token, required String fee}) {
    if (!fee.toString().isNotEmptyAndZeroValue) {
      return false;
    }
    if (token == null) return false;

    if (TokenValidator.isNative(state.fromToken?.isNative)) {
      return BalanceCalculator.balanceIsEnough(
        amount: token.balance,
        decimal: token.decimals,
        fee: fee,
      );
    }

    final native = TokenHandler.getNativeFromBalance(
      network: token.network,
      balances: _balanceCubit.state.balances?.tokens
          .map((e) => Token.fromBalance(e))
          .toList(),
    );
    if (native == null) return false;

    return BalanceCalculator.balanceIsEnough(
      amount: native.balance,
      decimal: native.decimals,
      fee: fee,
    );
  }

  bool isBuyAmountValid() {
    if (!state.buyAmount.isNotEmptyAndZeroValue) {
      return false;
    }

    if (state.fromToken == null) {
      return false;
    }

    final amount = Calculator.toAtomicUnits(
      state.buyAmount,
      state.fromToken!.decimals,
    );
    return Calculator.greaterThan(amount, BigInt.zero);
  }

  /// Get complete buy button state including fee validation
  /// This is the single source of truth for the buy button UI
  TradeButtonState get buyButtonState {
    // Get base state from QuickTradeState extension
    final baseState = state.buyButtonState;
    final isBalanceEnough = balanceIsEnough(
      token: state.fromToken,
      fee: state.buyQuote?.fee ?? '0',
    );

    // If already trading, quoteLoading, or ready (no disabled reasons), return as-is
    if (baseState is! TradeButtonDisabled) {
      return baseState;
    }

    // If there's already a high-priority error, return it
    if (baseState.reason.priority > 5) {
      return baseState;
    }

    // Check fee validation (only when we have a valid quote and amount)
    if (state.buyAmount.isNotEmptyAndZeroValue &&
        state.buyQuote != null &&
        !isBalanceEnough) {
      return const TradeButtonState.disabled(
        reason: TradeButtonDisabledReason.insufficientFee(),
      );
    }

    return baseState;
  }

  /// Get complete sell button state including fee validation
  /// This is the single source of truth for the sell button UI
  TradeButtonState get sellButtonState {
    // Get base state from QuickTradeState extension
    final baseState = state.sellButtonState;
    final isBalanceEnough = balanceIsEnough(
      token: state.selectedToken,
      fee: state.sellQuote?.fee ?? '0',
    );

    // If already trading, quoteLoading, or ready (no disabled reasons), return as-is
    if (baseState is! TradeButtonDisabled) {
      return baseState;
    }

    // If there's already a high-priority error, return it
    if (baseState.reason.priority > 5) {
      return baseState;
    }

    // Check fee validation (only when we have a valid quote and amount)
    if (state.sellPercent.isNotEmptyAndZeroValue &&
        state.sellQuote != null &&
        !isBalanceEnough) {
      return const TradeButtonState.disabled(
        reason: TradeButtonDisabledReason.insufficientFee(),
      );
    }

    return baseState;
  }
}
