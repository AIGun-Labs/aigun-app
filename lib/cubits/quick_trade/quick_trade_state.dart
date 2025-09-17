import 'package:flutter_aigun/cubits/trade/trade_state.dart';
import 'package:flutter_aigun/data/models/transfer/index.dart';
import 'package:flutter_aigun/utils/extensions/string.dart';
import 'package:flutter_aigun/utils/numeric_utils.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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

  bool get isBuyingToken => maybeWhen(
        orElse: () => false,
        loading: () => true,
      );
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

  bool get isSellingToken => maybeWhen(
        orElse: () => false,
        loading: () => true,
      );
}

@freezed
class QuickTradeState with _$QuickTradeState {
  const factory QuickTradeState({
    @Default(BuyTokenStatus.initial()) BuyTokenStatus buyTokenStatus,
    @Default(SellTokenStatus.initial()) SellTokenStatus sellTokenStatus,
    @Default(null) Token? fromToken,
    // @Default(null) Token? toToken,
    @Default(null) Token? selectedToken,
    @Default("") String buyAmount,
    @Default("") String sellPercent,
    @Default(QuickTradeMode.buy) QuickTradeMode mode,
  }) = _QuickTradeState;
}

extension QuickTradeStateExtension on QuickTradeState {
  bool isBalanceEnough() {
    late bool isBalanceEnough;

    if (mode == QuickTradeMode.buy) {
      // 如果代币余额为空，则返回 false
      final buyAmountValue =
          NumericUtils.subtractNumbers(fromToken?.balance ?? "0", buyAmount);
      isBalanceEnough = NumericUtils.isGreaterThanZero(buyAmountValue);
    } else {
      // 如果代币余额为空，则返回 false
      if (!(selectedToken?.balance.isNotEmptyAndZeroValue ?? false))
        return false;

      // 如果卖出百分比为空，则返回 false
      final sellPercentValue = sellPercent.isEmpty ? "0" : sellPercent;
      final percent = (int.tryParse(sellPercentValue) ?? 0) / 100.0;

      final num sellAmount = NumericUtils.multiplyTwoNumbers(
          percent, selectedToken?.balance ?? "0");
      final balance = selectedToken?.balance ?? "0";

// 当前的代币余额是否大于 卖出数量的
      isBalanceEnough = NumericUtils.greaterThanOrEqual(balance, sellAmount);
    }

    return isBalanceEnough;
  }
}
