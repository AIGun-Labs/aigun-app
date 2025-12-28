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

///
class QuoteCubit extends Cubit<QuoteState> {
  QuoteCubit({
    required GetQuote getQuote,
    required TradeSettingCubit tradeSettingCubit,
    required ValidateSwapParams validateSwapParams,
  }) : _getQuote = getQuote,
       _tradeSettingCubit = tradeSettingCubit,
       _validateSwapParams = validateSwapParams,
       super(const QuoteState());
  final GetQuote _getQuote;
  final TradeSettingCubit _tradeSettingCubit;
  final ValidateSwapParams _validateSwapParams;

  Timer? _quoteTimer;
  final Debouncer _quoteDebouncer = Debouncer(
    delay: const Duration(milliseconds: 300),
  );
  TransactionEntity? _fromToken;
  TransactionEntity? _toToken;

  // ==================== Token Updates ====================
  void updateTokens({
    TransactionEntity? fromToken,
    TransactionEntity? toToken,
  }) {
    _fromToken = fromToken;
    _toToken = toToken;
    emit(state.copyWith(quote: null));
    _requestQuoteWithDebounce();
  }

  // ==================== Amount Management ====================
  void updateAmount(String amount) {
    if (!amount.isNotEmptyAndZeroValue) {
      emit(state.copyWith(quote: null, amount: amount));
      return;
    }

    emit(state.copyWith(amount: amount));
    _requestQuoteWithDebounce();
  }

  void updateSlippage(int slippage) {
    emit(state.copyWith(slippage: slippage));
  }

  void updatePriorityFee(int priorityFee) {
    emit(state.copyWith(priorityFee: priorityFee));
  }

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
  void _requestQuoteWithDebounce() {
    _quoteDebouncer.run(getQuote);
  }

  Future<void> getQuote() async {
    final validation = _validateSwapParams.callForQuote(
      fromToken: _fromToken,
      toToken: _toToken,
      amount: state.amount,
    );

    if (!validation.isSuccess) {
      emit(state.copyWith(paramsStatus: const QuoteParamsStatus.invalid()));
      return;
    }
    final atomicAmount = multiplyByDecimalPower(
      state.amount,
      _fromToken!.decimals,
    ).toString();

    Logger.info('getQuote atomicAmount: $atomicAmount');
    Logger.info('getQuote amount: ${state.amount}');
    Logger.info('getQuote fromToken: $_fromToken');

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
            quote: null,
            status: QuoteStatus.failure(message),
            paramsStatus: const QuoteParamsStatus.invalid(),
          ),
        );
      },
    );
  }

  // ==================== Quote Timer ====================
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

  void _startPeriodicQuoteTimer() {
    _quoteTimer?.cancel();
    _quoteTimer = Timer.periodic(Duration(seconds: NumericConstants.ten), (
      timer,
    ) {
      getQuote();
    });
  }

  void stopQuoteTimer() {
    _quoteTimer?.cancel();
    _quoteTimer = null;
  }

  // ==================== Lifecycle ====================
  void pause() {
    stopQuoteTimer();
  }

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
