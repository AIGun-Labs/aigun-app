import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/transfer/index.dart';
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
    // @Default(null) Token? toToken,
    @Default(null) Token? selectedToken,
    @Default(null) Token? fromToken,
    @Default("") String buyAmount,
    @Default("") String sellPercent,
    @Default(QuickTradeMode.buy) QuickTradeMode mode,
    @Default(null) TransferQuote? quote,
    @Default(false) bool isNativeToken,
  }) = _QuickTradeState;
}

extension QuickTradeStateExtension on QuickTradeState {
  bool isBalanceEnough() {
    late bool isBalanceEnough;

    if (mode == QuickTradeMode.buy) {
      // 直接比较余额和购买金额：余额 >= 购买金额
      isBalanceEnough = NumericUtils.greaterThanOrEqual(
          fromToken?.balance ?? "0", buyAmount);
    } else {
      // 如果代币余额为空，则返回 false
      if (!(selectedToken?.balance.isNotEmptyAndZeroValue ?? false)) {
        return false;
      }

      // 如果卖出百分比为空，则返回 false
      final sellPercentValue = sellPercent.isEmpty ? "0" : sellPercent;
      if (sellPercentValue == '100' || sellPercentValue == "all") {
        return NumericUtils.isGreaterThanZero(selectedToken?.balance ?? "0");
      }
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
