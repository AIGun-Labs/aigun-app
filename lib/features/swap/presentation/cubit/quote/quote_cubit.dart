import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constant/count.dart';
import '../../../../../core/types/result.dart';
import '../../../../../cubits/trade_setting/trade_setting_cubit.dart';
import '../../../../../enums/trade_mode.dart';
import '../../../../../utils/debouncer.dart';
import '../../../../../utils/decimal.dart';
import '../../../../../utils/extensions/string.dart';
import '../../../../../utils/logger.dart';
import '../../../domain/entities/transaction_entity.dart';
import '../../../domain/usecases/get_quote.dart';
import '../../../domain/usecases/validate_swap_params.dart';
import 'quote_state.dart';

/// QuoteCubit 负责管理询价逻辑
///
/// 职责：
/// - 询价请求（带防抖）
/// - 询价定时刷新（10秒）
/// - 管理 amount / slippage / priorityFee
/// - 验证询价参数
class QuoteCubit extends Cubit<QuoteState> {
  final GetQuote _getQuote;
  final TradeSettingCubit _tradeSettingCubit;
  final ValidateSwapParams _validateSwapParams;

  Timer? _quoteTimer;
  final Debouncer _quoteDebouncer = Debouncer(
    delay: const Duration(milliseconds: 300),
  );

  /// 当前选中的 tokens（由外部设置）
  TransactionEntity? _fromToken;
  TransactionEntity? _toToken;

  QuoteCubit({
    required GetQuote getQuote,
    required TradeSettingCubit tradeSettingCubit,
    required ValidateSwapParams validateSwapParams,
  }) : _getQuote = getQuote,
       _tradeSettingCubit = tradeSettingCubit,
       _validateSwapParams = validateSwapParams,
       super(const QuoteState());

  // ==================== Token Updates ====================

  /// 更新当前选中的 tokens（由 SwapCubit 调用）
  void updateTokens({
    TransactionEntity? fromToken,
    TransactionEntity? toToken,
  }) {
    _fromToken = fromToken;
    _toToken = toToken;

    // Token 变化时，清除当前报价并重新询价
    emit(state.copyWith(quote: null));
    _requestQuoteWithDebounce();
  }

  // ==================== Amount Management ====================

  /// 更新交易金额
  void updateAmount(String amount) {
    if (!amount.isNotEmptyAndZeroValue) {
      emit(state.copyWith(quote: null, amount: amount));
      return;
    }

    emit(state.copyWith(amount: amount));
    _requestQuoteWithDebounce();
  }

  /// 更新滑点
  void updateSlippage(int slippage) {
    emit(state.copyWith(slippage: slippage));
  }

  /// 更新优先费用
  void updatePriorityFee(int priorityFee) {
    emit(state.copyWith(priorityFee: priorityFee));
  }

  /// 清除金额和报价
  void clear() {
    _quoteTimer?.cancel();
    emit(
      state.copyWith(
        amount: '',
        quote: null,
        status: const QuoteStatus.initial(),
        paramsStatus: const QuoteParamsStatus.initial(),
      ),
    );
  }

  // ==================== Quote Request ====================

  /// 带防抖的询价请求
  void _requestQuoteWithDebounce() {
    _quoteDebouncer.run(() {
      getQuote();
    });
  }

  /// 执行询价请求
  Future<void> getQuote() async {
    // 验证参数
    final validation = _validateSwapParams.callForQuote(
      fromToken: _fromToken,
      toToken: _toToken,
      amount: state.amount,
    );

    if (!validation.isSuccess) {
      emit(state.copyWith(paramsStatus: const QuoteParamsStatus.invalid()));
      return;
    }

    // 计算原子单位金额
    final atomicAmount = multiplyByDecimalPower(
      state.amount,
      _fromToken!.decimals,
    ).toString();

    Logger.info('atomicAmount: $atomicAmount');

    if (!atomicAmount.isNotEmptyAndZeroValue) {
      emit(state.copyWith(paramsStatus: const QuoteParamsStatus.invalid()));
      return;
    }

    emit(state.copyWith(status: const QuoteStatus.loading()));

    final setting = _tradeSettingCubit.getCurrentTradeCustomSetting();

    final result = await _getQuote(
      network: _fromToken!.network ?? '',
      fromChainId: _fromToken?.uniqueId ?? '',
      toChainId: _toToken?.uniqueId ?? '',
      inputMint: _fromToken?.address ?? '',
      outputMint: _toToken?.address ?? '',
      amount: atomicAmount,
      mode: setting.mode?.value ?? TradeMode.fast.value,
      options: setting.toJson(),
      decimals: _fromToken!.decimals,
    );

    result.whenOrNull(
      success: (quote) {
        emit(
          state.copyWith(
            status: QuoteStatus.success(quote),
            quote: quote,
            paramsStatus: const QuoteParamsStatus.valid(),
            lastQuoteTimestamp: DateTime.now(),
          ),
        );
        _startQuoteTimer();
      },
      failure: (message) {
        emit(
          state.copyWith(
            status: QuoteStatus.failure(message),
            paramsStatus: const QuoteParamsStatus.invalid(),
          ),
        );
      },
    );
  }

  // ==================== Quote Timer ====================

  /// 启动询价定时器
  void _startQuoteTimer() {
    _quoteTimer?.cancel();

    if (state.lastQuoteTimestamp != null) {
      final elapsed = DateTime.now().difference(state.lastQuoteTimestamp!);
      final remainingSeconds =
          Duration(seconds: NumericConstants.ten).inSeconds - elapsed.inSeconds;

      if (remainingSeconds > 0) {
        _quoteTimer = Timer(Duration(seconds: remainingSeconds), () {
          getQuote();
          _startPeriodicQuoteTimer();
        });
      } else {
        _startPeriodicQuoteTimer();
      }
    } else {
      _quoteTimer = Timer(Duration(seconds: NumericConstants.ten), () {
        getQuote();
        _startPeriodicQuoteTimer();
      });
    }
  }

  /// 启动周期性询价定时器
  void _startPeriodicQuoteTimer() {
    _quoteTimer?.cancel();
    _quoteTimer = Timer.periodic(Duration(seconds: NumericConstants.ten), (
      timer,
    ) {
      getQuote();
    });
  }

  /// 停止询价定时器
  void stopQuoteTimer() {
    _quoteTimer?.cancel();
    _quoteTimer = null;
  }

  // ==================== Lifecycle ====================

  /// 暂停定时器（在页面不可见时调用）
  void pause() {
    stopQuoteTimer();
  }

  /// 恢复定时器（在页面重新可见时调用）
  void resume() {
    if (state.amount.isNotEmpty && _fromToken != null && _toToken != null) {
      _startQuoteTimer();
    }
  }

  @override
  Future<void> close() {
    _quoteTimer?.cancel();
    _quoteDebouncer.dispose();
    return super.close();
  }
}
