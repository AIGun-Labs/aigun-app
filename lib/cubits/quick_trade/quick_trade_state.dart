import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/transfer/index.dart';
import '../../shared/trade/trade_button_state.dart';
import '../../utils/extensions/string.dart';
import '../../utils/numeric_utils.dart';
import '../../widgets/token/models/token.dart';

part 'quick_trade_state.freezed.dart';

enum BuyTokenFailure { unknown }

enum QuickTradeMode { buy, sell }

@freezed
sealed class BuyTokenStatus with _$BuyTokenStatus {
  const BuyTokenStatus._();

  const factory BuyTokenStatus.initial() = _BuyTokenInitial;
  const factory BuyTokenStatus.loading() = _BuyTokenLoading;
  const factory BuyTokenStatus.success(TransferTransaction transaction) =
      _BuyTokenSuccess;
  const factory BuyTokenStatus.failure(BuyTokenFailure failure) =
      _BuyTokenFailure;

  bool get isBuyingToken => maybeWhen(orElse: () => false, loading: () => true);
}

enum SellTokenFailure { unknown }

@freezed
sealed class SellTokenStatus with _$SellTokenStatus {
  const SellTokenStatus._();

  const factory SellTokenStatus.initial() = _SellTokenInitial;
  const factory SellTokenStatus.loading() = _SellTokenLoading;
  const factory SellTokenStatus.success(TransferTransaction transaction) =
      _SellTokenSuccess;
  const factory SellTokenStatus.failure(SellTokenFailure failure) =
      _SellTokenFailure;

  bool get isSellingToken =>
      maybeWhen(orElse: () => false, loading: () => true);
}

enum QuickTradeQuoteStatus { initial, loading, success, failure }

@freezed
sealed class QuickTradeState with _$QuickTradeState {
  const factory QuickTradeState({
    @Default(BuyTokenStatus.initial()) BuyTokenStatus buyTokenStatus,
    @Default(SellTokenStatus.initial()) SellTokenStatus sellTokenStatus,
    // @Default(null) Token? toToken,
    @Default(null) Token? selectedToken,
    @Default(null) Token? fromToken,
    @Default('') String buyAmount,
    @Default('0') String sellPercent,
    @Default(QuickTradeMode.buy) QuickTradeMode mode,
    @Default(null) TransferQuote? quote,
    @Default(false) bool isNativeToken,
    @Default(null) TransferQuote? buyQuote,
    @Default(null) TransferQuote? sellQuote,
    @Default(QuickTradeQuoteStatus.initial)
    QuickTradeQuoteStatus buyQuoteStatus,
    @Default(QuickTradeQuoteStatus.initial)
    QuickTradeQuoteStatus sellQuoteStatus,
  }) = _QuickTradeState;
}

extension QuickTradeStateExtension on QuickTradeState {
  bool isBalanceEnough() {
    late bool isBalanceEnough;

    if (mode == QuickTradeMode.buy) {
      isBalanceEnough = NumericUtils.greaterThanOrEqual(
        fromToken?.balance ?? '0',
        buyAmount,
      );
    } else {
      if (!(selectedToken?.balance.isNotEmptyAndZeroValue ?? false)) {
        return false;
      }
      final sellPercentValue = sellPercent.isEmpty ? '0' : sellPercent;
      if (sellPercentValue == '100' || sellPercentValue == 'all') {
        return NumericUtils.isGreaterThanZero(selectedToken?.balance ?? '0');
      }
      final percent = (int.tryParse(sellPercentValue) ?? 0) / 100.0;

      final num sellAmount = NumericUtils.multiplyTwoNumbers(
        percent,
        selectedToken?.balance ?? '0',
      );
      final balance = selectedToken?.balance ?? '0';
      isBalanceEnough = NumericUtils.greaterThanOrEqual(balance, sellAmount);
    }

    return isBalanceEnough;
  }

  /// ==================== Buy Button State ====================
  ///
  /// Compute the buy button state
  /// Note: Fee validation requires access to native tokens, handled in QuickTradeCubit
  TradeButtonState get buyButtonState {
    // 1️⃣ Highest priority: Trading in progress
    final isTrading = buyTokenStatus.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );
    if (isTrading) {
      return const TradeButtonState.trading();
    }

    // 2️⃣ Second priority: Quote loading
    if (buyQuoteStatus == QuickTradeQuoteStatus.loading) {
      return const TradeButtonState.quoteLoading();
    }

    // 3️⃣ Collect all disabled reasons
    final List<TradeButtonDisabledReason> reasons = [];

    // Check: Has buy amount been entered
    if (!buyAmount.isNotEmptyAndZeroValue) {
      reasons.add(const TradeButtonDisabledReason.noAmount());
    }

    // Check: Are different tokens selected
    if (fromToken?.address == selectedToken?.address &&
        fromToken?.chainId == selectedToken?.chainId) {
      reasons.add(const TradeButtonDisabledReason.sameToken());
    }

    // Check: Amount validity after decimal conversion
    if (buyAmount.isNotEmptyAndZeroValue && fromToken != null) {
      try {
        final multipliedAmount = NumericUtils.multiplyByDecimalPower(
          buyAmount,
          fromToken!.decimals,
        );
        if (multipliedAmount <= BigInt.zero) {
          reasons.add(const TradeButtonDisabledReason.invalidAmount());
        }
      } catch (e) {
        reasons.add(const TradeButtonDisabledReason.invalidAmount());
      }
    }

    // Check: Balance sufficiency
    if (buyAmount.isNotEmptyAndZeroValue) {
      final isEnough = NumericUtils.greaterThanOrEqual(
        fromToken?.balance ?? '0',
        buyAmount,
      );
      if (!isEnough) {
        reasons.add(
          TradeButtonDisabledReason.insufficientBalance(
            tokenSymbol: fromToken?.symbol ?? '',
          ),
        );
      }
    }

    // Check: Quote status
    if (buyAmount.isNotEmptyAndZeroValue) {
      if (buyQuoteStatus == QuickTradeQuoteStatus.failure) {
        reasons.add(const TradeButtonDisabledReason.quoteFailed());
      } else if (buyQuoteStatus != QuickTradeQuoteStatus.success ||
          buyQuote == null) {
        reasons.add(const TradeButtonDisabledReason.noQuote());
      }
    }

    // 4️⃣ Return result
    if (reasons.isEmpty) {
      return const TradeButtonState.ready();
    }

    reasons.sort((a, b) => b.priority.compareTo(a.priority));
    return TradeButtonState.disabled(reason: reasons.first);
  }

  /// ==================== Sell Button State ====================
  ///
  /// Compute the sell button state
  /// Note: Fee validation requires access to native tokens, handled in QuickTradeCubit
  TradeButtonState get sellButtonState {
    // 1️⃣ Highest priority: Trading in progress
    final isTrading = sellTokenStatus.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );
    if (isTrading) {
      return const TradeButtonState.trading();
    }

    // 2️⃣ Second priority: Quote loading
    if (sellQuoteStatus == QuickTradeQuoteStatus.loading) {
      return const TradeButtonState.quoteLoading();
    }

    // 3️⃣ Collect all disabled reasons
    final List<TradeButtonDisabledReason> reasons = [];

    // Check: Has sell percent been entered
    if (!sellPercent.isNotEmptyAndZeroValue) {
      reasons.add(const TradeButtonDisabledReason.noAmount());
    }

    // Check: Token balance exists
    if (!(selectedToken?.balance.isNotEmptyAndZeroValue ?? false)) {
      reasons.add(
        TradeButtonDisabledReason.insufficientBalance(
          tokenSymbol: selectedToken?.symbol ?? '',
        ),
      );
    }

    // Check: Sell amount validity
    if (sellPercent.isNotEmptyAndZeroValue && selectedToken != null) {
      final sellPercentValue = sellPercent.isEmpty ? '0' : sellPercent;

      if (sellPercentValue != '100' && sellPercentValue != 'all') {
        final percent = (int.tryParse(sellPercentValue) ?? 0) / 100.0;
        final sellAmount = NumericUtils.multiplyTwoNumbers(
          percent,
          selectedToken!.balance,
        );

        if (!NumericUtils.isGreaterThanZero(sellAmount.toString())) {
          reasons.add(const TradeButtonDisabledReason.invalidAmount());
        }
      }
    }

    // Check: Quote status
    if (sellPercent.isNotEmptyAndZeroValue) {
      if (sellQuoteStatus == QuickTradeQuoteStatus.failure) {
        reasons.add(const TradeButtonDisabledReason.quoteFailed());
      } else if (sellQuoteStatus != QuickTradeQuoteStatus.success ||
          sellQuote == null) {
        reasons.add(const TradeButtonDisabledReason.noQuote());
      }
    }

    // 4️⃣ Return result
    if (reasons.isEmpty) {
      return const TradeButtonState.ready();
    }

    reasons.sort((a, b) => b.priority.compareTo(a.priority));
    return TradeButtonState.disabled(reason: reasons.first);
  }
}
