
****，。，，。

---

1. **** - 
2. **** - 
3. ** Bug** - 
4. **** - 
5. **** - 

---

 ****：

```

├── 1.  (TradeCubit)
│   ├── ：Swap 
│   ├── ：lib/cubits/trade/trade_state.dart
│   ├── ：lib/cubits/trade/trade_cubit.dart
│   └── UI：lib/widgets/swap/widgets/swap.dart
│
└── 2.  (QuickTradeCubit)
    ├── ：
    ├── ：lib/cubits/quick_trade/quick_trade_state.dart
    ├── ：lib/cubits/quick_trade/quick_trade_cubit.dart
    └── UI：lib/widgets/sheet/trade.dart
```

---

**：**
- ：`lib/cubits/trade/trade_state.dart`
-  UI：`lib/widgets/swap/widgets/swap.dart:293-436`

**：**

```dart
// lib/widgets/swap/widgets/swap.dart:293-436
Widget _buildTradeButton(BuildContext context) {
  return BlocBuilder<TradeCubit, TradeState>(
    builder: (context, state) {
      final isLoading = state.status.maybeWhen(...);
      final isValid = state.paramsStatus.mapOrNull(...);
      final hasValidQuote = state.quoteStatus.maybeMap(...);
      final isQuoteLoading = state.quoteStatus.maybeMap(...);
      final isTradeLoading = state.status.maybeMap(...);
      final shouldCheckBalance = state.amount.isNotEmptyAndZeroValue;
      final isValidBalance = !shouldCheckBalance ? true : ...;
      final isEnoughFee = context.read<TradeCubit>().isEnoughFee(); // ❌ 
      final backgroundColor =
          isQuoteLoading ||
              isTradeLoading ||
              (!isValid ||
                  !state.amount.isNotEmptyAndZeroValue ||
                  !isValidBalance ||
                  !hasValidQuote ||
                  !isEnoughFee)
          ? AppColors.quinary
          : AppColors.buttonPrimary(context);
      final buttonTextContent = !shouldCheckBalance
          ? buttonText
          : !isEnoughFee
          ? S.of(context).feeNotEnough
          : isValidBalance
          ? buttonText
          : '${state.fromToken?.symbol} ${S.of(context).balanceNotEnough}';
    }
  );
}
```

**：**
- ****： widget， cubit
- ****：`isEnoughFee()` 
- ****：
- ****：，

```dart
final shouldCheckBalance = state.amount.isNotEmptyAndZeroValue; // ✅ 
final newAmount = state.amount.divideByDecimalPower(state.fromToken?.decimals ?? 18);
if (!newAmount.isNotEmptyAndZeroValue) { // ❌ 
  emit(state.copyWith(
    status: const TradeStatusMessage.failure(TradeStatus.paramsInvalid),
  ));
  return;
}
```

**Bug ：**
```
：0.000000000000000001（18 ）
：amount.isNotEmptyAndZeroValue = true ✅ 
：divideByDecimalPower(18) = "0"
swap() ：newAmount.isNotEmptyAndZeroValue = false ❌ 
： "" 
```

**TradeState ：**

```dart
// lib/cubits/trade/trade_state.dart:88-96
@freezed
sealed class TradeStatusMessage with _$TradeStatusMessage {
  const factory TradeStatusMessage.initial() = _TradeStatusInitial;
  const factory TradeStatusMessage.loading() = _TradeStatusLoading;
  const factory TradeStatusMessage.success(TransferTransaction transaction) = _TradeStatusSuccess;
  const factory TradeStatusMessage.failure(TradeStatus failure) = _TradeStatusFailure;
}

// lib/cubits/trade/trade_state.dart:72-78
@freezed
sealed class QuoteStatus with _$QuoteStatus {
  const factory QuoteStatus.initial() = _QuoteInitial;
  const factory QuoteStatus.loading() = _QuoteLoading;
  const factory QuoteStatus.success(TransferQuote quote) = _QuoteSuccess;
  const factory QuoteStatus.failure() = _QuoteFailure;
}

// lib/cubits/trade/trade_state.dart:80-86
@freezed
sealed class TradeParamsStatus with _$TradeParamsStatus {
  const factory TradeParamsStatus.initial() = _TradeParamsInitial;
  const factory TradeParamsStatus.loading() = _TradeParamsLoading;
  const factory TradeParamsStatus.success() = _TradeParamsSuccess;
  const factory TradeParamsStatus.failure() = _TradeParamsFailure;
}
```

---

**：**
- ：`lib/cubits/quick_trade/quick_trade_state.dart`
-  UI：`lib/widgets/sheet/trade.dart:1023-1072`
-  UI：`lib/widgets/sheet/trade.dart:820-854`

**：**

```dart
// lib/widgets/sheet/trade.dart:862-1021
Widget _buildBuy(bool isBalanceEnough) {
  return BlocBuilder<QuickTradeCubit, QuickTradeState>(
    builder: (context, state) {
      final isEnoughFee = context.read<QuickTradeCubit>().buyAmountIsEnoughFee();
      final isBuyAmountValid = context.read<QuickTradeCubit>().isBuyAmountValid();
      final isQuoteLoading = state.buyQuoteStatus == QuickTradeQuoteStatus.loading;
      final isTradeLoading = state.buyTokenStatus.whenOrNull(loading: () => true) ?? false;

      return _buildBuyButton(
        isBalanceEnough,
        isEnoughFee,
        isBuyAmountvalid: isBuyAmountValid,
        isQuoteLoading: isQuoteLoading,
        isTradeLoading: isTradeLoading,
      );
    }
  );
}

// lib/widgets/sheet/trade.dart:1023-1072
Widget _buildBuyButton(
  bool isBalanceEnough,
  bool isEnoughFee, {
  bool isBuyAmountvalid = false,
  bool isQuoteLoading = false,
  bool isTradeLoading = false,
}) {
  if (isBalanceEnough && isEnoughFee) {
    return _buildConfirmButton(
      text: S.of(context).buyNow,
      onPressed: isBalanceEnough && isEnoughFee && !isTradeLoading && isBuyAmountvalid
          ? () { context.read<QuickTradeCubit>().buyToken(context); }
          : null,
    );
  } else if (!isBalanceEnough) {
    return _buildBalanceNotEnough();
  } else {
    return _buildConfirmButton(
      text: S.of(context).feeNotEnough,
      backgroundColor: AppColors.surface(context),
      textColor: AppColors.textQuaternary(context),
      onPressed: null,
    );
  }
}
```

```dart
// lib/widgets/sheet/trade.dart:589-858
Widget _buildSell(isBalanceEnough) {
  return BlocBuilder<QuickTradeCubit, QuickTradeState>(
    builder: (context, state) {
      final isEnoughFee = context.read<QuickTradeCubit>().sellAmountIsEnoughFee();
      final isQuoteLoading = state.sellQuoteStatus == QuickTradeQuoteStatus.loading;
      final isTradeLoading = state.sellTokenStatus.whenOrNull(loading: () => true) ?? false;
      return _buildConfirmButton(
        text: !isBalanceEnough
            ? S.of(context).balanceNotEnough
            : !isEnoughFee
            ? S.of(context).feeNotEnough
            : S.of(context).sellNow,
        backgroundColor:
            (isBalanceEnough && isEnoughFee && state.sellPercent.isNotEmptyAndZeroValue)
                ? AppColors.buttonPrimary(context)
                : AppColors.surface(context),
        textColor:
            (isBalanceEnough && isEnoughFee && state.sellPercent.isNotEmptyAndZeroValue)
                ? Colors.black
                : AppColors.textQuaternary(context),
        isQuoteLoading: isQuoteLoading,
        isTradeLoading: isTradeLoading,
        onPressed:
            isBalanceEnough &&
                !isQuoteLoading &&
                isEnoughFee &&
                !isTradeLoading &&
                state.sellPercent.isNotEmptyAndZeroValue
            ? () { context.read<QuickTradeCubit>().sellToken(context); }
            : null,
      );
    }
  );
}
```

**（）：**

```dart
// lib/cubits/quick_trade/quick_trade_cubit.dart:832-860
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
  if (nativeToken == null) return false;

  final nativeBalance = NumericUtils.multiplyByDecimalPower(
    nativeToken.balance,
    nativeToken.decimals,
  ).toString();
  final remainingBalance = nativeBalance.toDouble() - fee;
  return remainingBalance >= 0;
}

// lib/cubits/quick_trade/quick_trade_cubit.dart:862-898
bool sellAmountIsEnoughFee() {
  final fee = state.sellQuote?.fee?.toDouble() ?? 0.0;
  if (state.selectedToken == null) return false;

  if (state.selectedToken!.isNative) {
    final balance = NumericUtils.multiplyByDecimalPower(
      state.selectedToken?.balance ?? '0',
      state.selectedToken!.decimals,
    ).toString();
    final remainingBalance = balance.toDouble() - fee;
    return remainingBalance >= 0;
  }

  final nativeToken = _getNativeToken(state.selectedToken!.network);
  if (nativeToken == null) return false;

  final nativeBalance = NumericUtils.multiplyByDecimalPower(
    nativeToken.balance,
    nativeToken.decimals,
  ).toString();
  final remainingBalance = nativeBalance.toDouble() - fee;
  return remainingBalance >= 0;
}
```

**：**

```dart
// lib/cubits/quick_trade/quick_trade_cubit.dart:916-936
bool isBuyAmountValid() {
  if (!state.buyAmount.isNotEmptyAndZeroValue) {
    return false;
  }
  if (state.fromToken == null) {
    return false;
  }

  try {
    final multipliedAmount = NumericUtils.multiplyByDecimalPower(
      state.buyAmount,
      state.fromToken!.decimals,
    );
    return multipliedAmount > BigInt.zero;
  } catch (e) {
    Logger.error('Error validating buy amount: $e');
    return false;
  }
}
```

**QuickTradeState ：**

```dart
// lib/cubits/quick_trade/quick_trade_state.dart:15-26
@freezed
sealed class BuyTokenStatus with _$BuyTokenStatus {
  const factory BuyTokenStatus.initial() = _BuyTokenInitial;
  const factory BuyTokenStatus.loading() = _BuyTokenLoading;
  const factory BuyTokenStatus.success(TransferTransaction transaction) = _BuyTokenSuccess;
  const factory BuyTokenStatus.failure(BuyTokenFailure failure) = _BuyTokenFailure;
}

// lib/cubits/quick_trade/quick_trade_state.dart:31-43
@freezed
sealed class SellTokenStatus with _$SellTokenStatus {
  const factory SellTokenStatus.initial() = _SellTokenInitial;
  const factory SellTokenStatus.loading() = _SellTokenLoading;
  const factory SellTokenStatus.success(TransferTransaction transaction) = _SellTokenSuccess;
  const factory SellTokenStatus.failure(SellTokenFailure failure) = _SellTokenFailure;
}

// lib/cubits/quick_trade/quick_trade_state.dart:45
enum QuickTradeQuoteStatus { initial, loading, success, failure }
```

**（）：**

```dart
// lib/cubits/quick_trade/quick_trade_state.dart:69-103
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
}
```

---

 ** (State Pattern)** + ** (Computed Properties)** 。

```
┌─────────────────────────────────────────────────────────┐
│            (lib/shared/trade/)                │
│  ┌───────────────────────────────────────────────────┐  │
│  │  TradeButtonState ()                  │  │
│  │  ├─ Disabled (reason)                            │  │
│  │  ├─ QuoteLoading                                 │  │
│  │  ├─ Trading                                      │  │
│  │  └─ Ready                                        │  │
│  │                                                   │  │
│  │  TradeButtonDisabledReason ()        │  │
│  │  ├─ NoAmount                                     │  │
│  │  ├─ InvalidAmount (decimal conversion)          │  │
│  │  ├─ InsufficientBalance                         │  │
│  │  ├─ InsufficientFee                             │  │
│  │  ├─ NoQuote                                      │  │
│  │  ├─ QuoteFailed                                  │  │
│  │  ├─ InvalidParams                                │  │
│  │  └─ SameToken                                    │  │
│  └───────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
                            ↓ /
        ┌───────────────────┴───────────────────┐
        ↓                                       ↓
┌──────────────────┐                  ┌──────────────────┐
│   TradeState     │                  │ QuickTradeState  │
│  ┌────────────┐  │                  │  ┌────────────┐  │
│  │buttonState │  │                  │  │buyButton   │  │
│  │(getter)    │  │                  │  │State       │  │
│  └────────────┘  │                  │  │(getter)    │  │
│                  │                  │  │            │  │
│                  │                  │  │sellButton  │  │
│                  │                  │  │State       │  │
│                  │                  │  │(getter)    │  │
│                  │                  │  └────────────┘  │
└──────────────────┘                  └──────────────────┘
```

---

**：** `lib/shared/trade/trade_button_state.dart`（）

```dart
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../l10n/l10n.dart';
import '../../themes/colors.dart';

part 'trade_button_state.freezed.dart';
@freezed
sealed class TradeButtonState with _$TradeButtonState {
  const TradeButtonState._();
  const factory TradeButtonState.disabled({
    required TradeButtonDisabledReason reason,
  }) = TradeButtonDisabled;
  const factory TradeButtonState.quoteLoading() = TradeButtonQuoteLoading;
  const factory TradeButtonState.trading() = TradeButtonTrading;
  const factory TradeButtonState.ready() = TradeButtonReady;
  bool get isEnabled => this is TradeButtonReady;
  bool get isLoading => this is TradeButtonQuoteLoading || this is TradeButtonTrading;
  String getLabel(BuildContext context, {required String defaultLabel}) {
    return when(
      disabled: (reason) => reason.getLabel(context),
      quoteLoading: () => defaultLabel,
      trading: () => defaultLabel,
      ready: () => defaultLabel,
    );
  }
  Color getBackgroundColor(BuildContext context) {
    return when(
      disabled: (_) => AppColors.quinary,
      quoteLoading: () => AppColors.quinary,
      trading: () => AppColors.buttonPrimary(context),
      ready: () => AppColors.buttonPrimary(context),
    );
  }
  Color getLabelColor(BuildContext context) {
    return when(
      disabled: (_) => AppColors.textTertiary(context),
      quoteLoading: () => AppColors.textTertiary(context),
      trading: () => Colors.black,
      ready: () => Colors.black,
    );
  }
  Color getIconColor(BuildContext context) {
    return getLabelColor(context);
  }
}
@freezed
sealed class TradeButtonDisabledReason with _$TradeButtonDisabledReason {
  const TradeButtonDisabledReason._();
  const factory TradeButtonDisabledReason.noAmount() = _NoAmount;
  const factory TradeButtonDisabledReason.invalidAmount() = _InvalidAmount;
  const factory TradeButtonDisabledReason.insufficientBalance({
    required String tokenSymbol,
  }) = _InsufficientBalance;
  const factory TradeButtonDisabledReason.insufficientFee() = _InsufficientFee;
  const factory TradeButtonDisabledReason.noQuote() = _NoQuote;
  const factory TradeButtonDisabledReason.quoteFailed() = _QuoteFailed;
  const factory TradeButtonDisabledReason.invalidParams() = _InvalidParams;
  const factory TradeButtonDisabledReason.sameToken() = _SameToken;
  String getLabel(BuildContext context) {
    return when(
      noAmount: () => S.of(context).tradeNow,
      invalidAmount: () => S.of(context).invalidAmount,
      insufficientBalance: (symbol) => '$symbol ${S.of(context).balanceNotEnough}',
      insufficientFee: () => S.of(context).feeNotEnough,
      noQuote: () => S.of(context).tradeNow,
      quoteFailed: () => S.of(context).quoteFailed,
      invalidParams: () => S.of(context).invalidParams,
      sameToken: () => S.of(context).selectDifferentToken,
    );
  }
  int get priority => when(
    noAmount: () => 1,          // ：
    noQuote: () => 2,           // 
    quoteFailed: () => 3,       // 
    invalidAmount: () => 4,     // 
    insufficientFee: () => 5,   // 
    insufficientBalance: (_) => 6, // 
    invalidParams: () => 7,     // 
    sameToken: () => 8,         // ：
  );
}
```

---

**：** `lib/cubits/trade/trade_state.dart`

 `TradeState`  `buttonState`：

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../shared/trade/trade_button_state.dart';
import '../../utils/extensions/string.dart';
import '../../utils/numeric_utils.dart';

@freezed
sealed class TradeState with _$TradeState {
  const TradeState._();

  const factory TradeState({
    @Default(TradeStatusMessage.initial()) TradeStatusMessage status,
    @Default(QuoteStatus.initial()) QuoteStatus quoteStatus,
    @Default(100) int slippage,
    @Default(0) int priorityFee,
    @Default('0') String amount,
    @Default(null) TransferQuote? quote,
    @Default([]) List<Token> availableTokens,
    @Default(defaultFormTradeToken) TradeToken? fromToken,
    @Default(defaultTradeToken) TradeToken? toToken,
    @Default(null) TextEditingController? amountController,
    @Default(TradeParamsStatus.initial()) TradeParamsStatus paramsStatus,
    @Default([]) List<Token> nativeTokens,
    @Default(null) String? toAmount,
    @Default(null) double? fromBalance,
    @Default(GetTokenBalanceStatus.initial())
    GetTokenBalanceStatus fromBalanceStatus,
    @Default(null) DateTime? lastQuoteTimestamp,
  }) = _TradeState;
  ///
  TradeButtonState get buttonState {
    final isTrading = status.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );
    if (isTrading) {
      return const TradeButtonState.trading();
    }
    final isQuoteLoading = quoteStatus.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );
    if (isQuoteLoading) {
      return const TradeButtonState.quoteLoading();
    }
    final List<TradeButtonDisabledReason> reasons = [];
    if (!amount.isNotEmptyAndZeroValue) {
      reasons.add(const TradeButtonDisabledReason.noAmount());
    }
    if (fromToken?.address == toToken?.address &&
        fromToken?.chainId == toToken?.chainId) {
      reasons.add(const TradeButtonDisabledReason.sameToken());
    }
    final isParamsInvalid = paramsStatus.maybeWhen(
      failure: () => true,
      orElse: () => false,
    );
    if (isParamsInvalid) {
      reasons.add(const TradeButtonDisabledReason.invalidParams());
    }
    if (amount.isNotEmptyAndZeroValue) {
      final newAmount = amount.divideByDecimalPower(fromToken?.decimals ?? 18);
      if (!newAmount.isNotEmptyAndZeroValue) {
        reasons.add(const TradeButtonDisabledReason.invalidAmount());
      }
    }
    if (amount.isNotEmptyAndZeroValue && fromBalance != null) {
      final amountValue = double.tryParse(amount) ?? 0.0;
      final balanceValue = fromBalance ?? 0.0;
      if (amountValue > balanceValue) {
        reasons.add(TradeButtonDisabledReason.insufficientBalance(
          tokenSymbol: fromToken?.symbol ?? '',
        ));
      }
    }
    if (amount.isNotEmptyAndZeroValue) {
      final hasQuote = quoteStatus.maybeWhen(
        success: () => quote != null,
        orElse: () => false,
      );
      final quoteFailed = quoteStatus.maybeWhen(
        failure: () => true,
        orElse: () => false,
      );

      if (quoteFailed) {
        reasons.add(const TradeButtonDisabledReason.quoteFailed());
      } else if (!hasQuote) {
        reasons.add(const TradeButtonDisabledReason.noQuote());
      }
    }
    final hasValidQuote = quoteStatus.maybeWhen(
      success: () => quote != null,
      orElse: () => false,
    );
    if (hasValidQuote && amount.isNotEmptyAndZeroValue) {
      final fee = quote?.fee?.toDouble() ?? 0.0;

      if (fromToken?.isNative ?? false) {
        final balance = NumericUtils.multiplyByDecimalPower(
          fromBalance.toString(),
          fromToken!.decimals,
        ).toString();
        final remainingBalance = balance.toDouble() - fee;
        if (remainingBalance < 0) {
          reasons.add(const TradeButtonDisabledReason.insufficientFee());
        }
      } else {
      }
    }
    if (reasons.isEmpty) {
      return const TradeButtonState.ready();
    }
    reasons.sort((a, b) => b.priority.compareTo(a.priority));
    return TradeButtonState.disabled(reason: reasons.first);
  }
}
```

**：**  `TradeState` ， `nativeTokens` 。 `TradeCubit` 。

---

**：** `lib/cubits/trade/trade_cubit.dart`

， `buttonState` getter ：

```dart
class TradeCubit extends Cubit<TradeState> {
  TradeButtonDisabledReason? checkFeeValidation() {
    final quote = state.quote;
    final fromToken = state.fromToken;

    if (quote == null || fromToken == null) {
      return null; // ，
    }

    final fee = quote.fee?.toDouble() ?? 0.0;

    if (fromToken.isNative) {
      final balance = NumericUtils.multiplyByDecimalPower(
        state.fromBalance.toString(),
        fromToken.decimals,
      ).toString();

      final remainingBalance = balance.toDouble() - fee;
      if (remainingBalance < 0) {
        return const TradeButtonDisabledReason.insufficientFee();
      }
    } else {
      final nativeToken = _getNativeToken(fromToken.network);
      if (nativeToken == null) {
        Logger.error('Native token not found for ${fromToken.network}');
        return const TradeButtonDisabledReason.insufficientFee();
      }

      final nativeBalance = NumericUtils.multiplyByDecimalPower(
        nativeToken.balance,
        nativeToken.decimals,
      ).toString();

      final remainingBalance = nativeBalance.toDouble() - fee;
      if (remainingBalance < 0) {
        return const TradeButtonDisabledReason.insufficientFee();
      }
    }

    return null; // 
  }
  Token? _getNativeToken(String? network) {
    if (network == null) return null;
    final tokens = state.nativeTokens;

    try {
      final match = tokens.firstWhere(
        (t) =>
            t.network?.toLowerCase() == network.toLowerCase() &&
            TokenValidator.isNativeToken(t.address, network: t.network ?? ''),
      );
      return match;
    } catch (e) {
      return null;
    }
  }
}
```

** `buttonState` getter ：**

 `TradeState` ， `TradeCubit` ， `TradeState`  getter。

**：**  `TradeCubit` ：

```dart
class TradeCubit extends Cubit<TradeState> {
  TradeButtonState get buttonState {
    final baseState = state.buttonState;
    if (baseState is! TradeButtonDisabled) {
      return baseState;
    }
    final reasons = <TradeButtonDisabledReason>[];
    if (!state.amount.isNotEmptyAndZeroValue) {
      reasons.add(const TradeButtonDisabledReason.noAmount());
    }

    if (state.fromToken?.address == state.toToken?.address &&
        state.fromToken?.chainId == state.toToken?.chainId) {
      reasons.add(const TradeButtonDisabledReason.sameToken());
    }

    final isParamsInvalid = state.paramsStatus.maybeWhen(
      failure: () => true,
      orElse: () => false,
    );
    if (isParamsInvalid) {
      reasons.add(const TradeButtonDisabledReason.invalidParams());
    }

    if (state.amount.isNotEmptyAndZeroValue) {
      final newAmount = state.amount.divideByDecimalPower(state.fromToken?.decimals ?? 18);
      if (!newAmount.isNotEmptyAndZeroValue) {
        reasons.add(const TradeButtonDisabledReason.invalidAmount());
      }
    }

    if (state.amount.isNotEmptyAndZeroValue && state.fromBalance != null) {
      final amountValue = double.tryParse(state.amount) ?? 0.0;
      final balanceValue = state.fromBalance ?? 0.0;
      if (amountValue > balanceValue) {
        reasons.add(TradeButtonDisabledReason.insufficientBalance(
          tokenSymbol: state.fromToken?.symbol ?? '',
        ));
      }
    }

    if (state.amount.isNotEmptyAndZeroValue) {
      final hasQuote = state.quoteStatus.maybeWhen(
        success: () => state.quote != null,
        orElse: () => false,
      );
      final quoteFailed = state.quoteStatus.maybeWhen(
        failure: () => true,
        orElse: () => false,
      );

      if (quoteFailed) {
        reasons.add(const TradeButtonDisabledReason.quoteFailed());
      } else if (!hasQuote) {
        reasons.add(const TradeButtonDisabledReason.noQuote());
      }
    }
    final hasValidQuote = state.quoteStatus.maybeWhen(
      success: () => state.quote != null,
      orElse: () => false,
    );
    if (hasValidQuote && state.amount.isNotEmptyAndZeroValue) {
      final feeCheck = checkFeeValidation();
      if (feeCheck != null) {
        reasons.add(feeCheck);
      }
    }

    if (reasons.isEmpty) {
      return const TradeButtonState.ready();
    }

    reasons.sort((a, b) => b.priority.compareTo(a.priority));
    return TradeButtonState.disabled(reason: reasons.first);
  }
}
```

---

**：** `lib/widgets/swap/widgets/swap.dart`

 `_buildTradeButton` （ 293-436 ）：

```dart
Widget _buildTradeButton(BuildContext context) {
  return BlocBuilder<TradeCubit, TradeState>(
    builder: (context, state) {
      final tradeCubit = context.read<TradeCubit>();
      final buttonState = tradeCubit.buttonState;
      final defaultLabel = widget.buyToken
          ? S.of(context).buyNow
          : S.of(context).tradeNow;
      final Widget content = buttonState.when(
        disabled: (reason) => Text(
          reason.getLabel(context),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: buttonState.getLabelColor(context),
          ),
        ),
        quoteLoading: () => LottieAsset(
          const $AssetsLottieGen().aim,
          config: LottieConfig(
            width: 24.w,
            height: 24.h,
            repeat: true,
            animate: true,
          ),
        ),
        trading: () => Text(
          defaultLabel,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        ready: () => Text(
          defaultLabel,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      );
      final Widget? icon = buttonState.maybeWhen(
        disabled: (_) => SvgPicture.asset(
          const $AssetsImagesIconsGen().aimOutline,
          colorFilter: ColorFilter.mode(
            buttonState.getIconColor(context),
            BlendMode.srcIn,
          ),
        ),
        ready: () => SvgPicture.asset(
          const $AssetsImagesIconsGen().aimOutline,
          colorFilter: const ColorFilter.mode(
            Colors.black,
            BlendMode.srcIn,
          ),
        ),
        orElse: () => null,
      );

      return PrimaryButton(
        disabledBackgroundColor: buttonState.getBackgroundColor(context),
        backgroundColor: buttonState.getBackgroundColor(context),
        onPressed: buttonState.isEnabled
            ? () async {
                context.read<SoundEffectCubit>().playGunLoad();
                await tradeCubit.swap(context);
              }
            : null,
        borderRadius: widget.buyToken
            ? BorderRadius.circular(50)
            : BorderRadius.zero,
        width: double.infinity,
        height: 50.h,
        cutSize: widget.buyToken ? 0 : 20.0,
        textColor: Colors.black,
        fontSize: 16.sp,
        icon: icon,
        label: content,
      );
    },
  );
}
```

**：**
- **：** 143 
- **：** 60 
- **：** 58%

---

**：** `lib/cubits/quick_trade/quick_trade_state.dart`

：`buyButtonState`  `sellButtonState`。

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../shared/trade/trade_button_state.dart';
import '../../utils/extensions/string.dart';
import '../../utils/numeric_utils.dart';

extension QuickTradeStateExtension on QuickTradeState {
  ///
  TradeButtonState get buyButtonState {
    final isTrading = buyTokenStatus.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );
    if (isTrading) {
      return const TradeButtonState.trading();
    }
    if (buyQuoteStatus == QuickTradeQuoteStatus.loading) {
      return const TradeButtonState.quoteLoading();
    }
    final List<TradeButtonDisabledReason> reasons = [];
    if (!buyAmount.isNotEmptyAndZeroValue) {
      reasons.add(const TradeButtonDisabledReason.noAmount());
    }
    if (fromToken?.address == selectedToken?.address &&
        fromToken?.chainId == selectedToken?.chainId) {
      reasons.add(const TradeButtonDisabledReason.sameToken());
    }
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
    if (buyAmount.isNotEmptyAndZeroValue) {
      final isEnough = NumericUtils.greaterThanOrEqual(
        fromToken?.balance ?? '0',
        buyAmount,
      );
      if (!isEnough) {
        reasons.add(TradeButtonDisabledReason.insufficientBalance(
          tokenSymbol: fromToken?.symbol ?? '',
        ));
      }
    }
    if (buyAmount.isNotEmptyAndZeroValue) {
      if (buyQuoteStatus == QuickTradeQuoteStatus.failure) {
        reasons.add(const TradeButtonDisabledReason.quoteFailed());
      } else if (buyQuoteStatus != QuickTradeQuoteStatus.success || buyQuote == null) {
        reasons.add(const TradeButtonDisabledReason.noQuote());
      }
    }
    if (reasons.isEmpty) {
      return const TradeButtonState.ready();
    }

    reasons.sort((a, b) => b.priority.compareTo(a.priority));
    return TradeButtonState.disabled(reason: reasons.first);
  }
  ///
  TradeButtonState get sellButtonState {
    final isTrading = sellTokenStatus.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );
    if (isTrading) {
      return const TradeButtonState.trading();
    }
    if (sellQuoteStatus == QuickTradeQuoteStatus.loading) {
      return const TradeButtonState.quoteLoading();
    }
    final List<TradeButtonDisabledReason> reasons = [];
    if (!sellPercent.isNotEmptyAndZeroValue) {
      reasons.add(const TradeButtonDisabledReason.noAmount());
    }
    if (!(selectedToken?.balance.isNotEmptyAndZeroValue ?? false)) {
      reasons.add(TradeButtonDisabledReason.insufficientBalance(
        tokenSymbol: selectedToken?.symbol ?? '',
      ));
    }
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
    if (sellPercent.isNotEmptyAndZeroValue) {
      if (sellQuoteStatus == QuickTradeQuoteStatus.failure) {
        reasons.add(const TradeButtonDisabledReason.quoteFailed());
      } else if (sellQuoteStatus != QuickTradeQuoteStatus.success || sellQuote == null) {
        reasons.add(const TradeButtonDisabledReason.noQuote());
      }
    }
    if (reasons.isEmpty) {
      return const TradeButtonState.ready();
    }

    reasons.sort((a, b) => b.priority.compareTo(a.priority));
    return TradeButtonState.disabled(reason: reasons.first);
  }
}
```

---

**：** `lib/cubits/quick_trade/quick_trade_cubit.dart`

（）：

```dart
class QuickTradeCubit extends Cubit<QuickTradeState> {
  TradeButtonState get buyButtonState {
    final baseState = state.buyButtonState;
    if (baseState is TradeButtonTrading || baseState is TradeButtonQuoteLoading) {
      return baseState;
    }
    if (baseState is TradeButtonDisabled) {
      if (baseState.reason.priority > 5) {
        return baseState;
      }
    }
    if (state.buyAmount.isNotEmptyAndZeroValue &&
        state.buyQuote != null &&
        !buyAmountIsEnoughFee()) {
      return const TradeButtonState.disabled(
        reason: TradeButtonDisabledReason.insufficientFee(),
      );
    }

    return baseState;
  }
  TradeButtonState get sellButtonState {
    final baseState = state.sellButtonState;
    if (baseState is TradeButtonTrading || baseState is TradeButtonQuoteLoading) {
      return baseState;
    }
    if (baseState is TradeButtonDisabled) {
      if (baseState.reason.priority > 5) {
        return baseState;
      }
    }
    if (state.sellPercent.isNotEmptyAndZeroValue &&
        state.sellQuote != null &&
        !sellAmountIsEnoughFee()) {
      return const TradeButtonState.disabled(
        reason: TradeButtonDisabledReason.insufficientFee(),
      );
    }

    return baseState;
  }
}
```

---

**：** `lib/widgets/sheet/trade.dart`

 `_buildBuy` （ 862-1021 ）：

```dart
Widget _buildBuy(bool isBalanceEnough) {
  return BlocBuilder<QuickTradeCubit, QuickTradeState>(
    buildWhen: (previous, current) =>
        previous.fromToken != current.fromToken ||
        previous.isNativeToken != current.isNativeToken ||
        previous.buyQuoteStatus != current.buyQuoteStatus ||
        previous.buyQuote != current.buyQuote ||
        previous.buyTokenStatus != current.buyTokenStatus ||
        previous.buyAmount != current.buyAmount,
    builder: (context, state) {
      final quickTradeCubit = context.read<QuickTradeCubit>();
      final buttonState = quickTradeCubit.buyButtonState;

      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 18.h),
          SizedBox(
            height: 46.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    controller: _buyAmountController,
                    onChanged: _handleBuyAmountChange,
                    keyboardType: TextInputType.number,
                    enableInteractiveSelection: true,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                    ],
                    style: TextStyle(
                      fontSize: 28.sp,
                      color: AppColors.textPrimary(context),
                      fontWeight: FontWeight.w700,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      hintText: '0.0',
                      hintStyle: TextStyle(
                        fontSize: 28.sp,
                        color: AppColors.textQuaternary(context),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 6.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        if (state.fromToken?.tokenAvatar.isNotEmpty ?? false)
                          ClipOval(
                            child: FeatureImage(
                              url: ImageUtils.getImageUrl(
                                state.fromToken?.tokenAvatar,
                              ),
                              width: 16.w,
                              height: 16.h,
                              fit: BoxFit.cover,
                              errorWidget: Container(
                                color: Colors.grey[200],
                                height: 16.h,
                                width: 16.w,
                              ),
                            ),
                          ),
                        SizedBox(width: 4.w),
                        Text(
                          state.fromToken?.symbol ?? '',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.textTertiary(context),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/icons/wallet-outline.svg',
                          width: 13.w,
                          height: 13.h,
                          colorFilter: ColorFilter.mode(
                            AppColors.textTertiary(context),
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          "${CurrencyFormatter.abbreviateTokenPrice(double.parse(state.fromToken?.balance ?? "0"))} ${state.fromToken?.symbol ?? ""}",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.textTertiary(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 8.h),
          state.isNativeToken
              ? _buildBuyButtons(
                  onPressed: (value) {
                    _handleBuyAmountChange(value);
                  },
                )
              : _buildBuyWithOtherToken(
                  onPressed: (value) {
                    _handleBuyAmountPercentChange(value);
                  },
                ),
          buttonState.when(
            disabled: (reason) {
              if (reason is _InsufficientBalance) {
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 8.w),
                      child: Text(
                        S.of(context).balanceNotEnoughHint(
                          state.fromToken?.symbol ?? '',
                        ),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.secondary,
                        ),
                      ),
                    ),
                    _buildBalanceNotEnough(),
                  ],
                );
              }
              return Column(
                children: [
                  SizedBox(height: 14.h),
                  _buildUnifiedButton(
                    buttonState: buttonState,
                    defaultLabel: S.of(context).buyNow,
                    onPressed: null,
                  ),
                ],
              );
            },
            quoteLoading: () => Column(
              children: [
                SizedBox(height: 14.h),
                _buildUnifiedButton(
                  buttonState: buttonState,
                  defaultLabel: S.of(context).buyNow,
                  onPressed: null,
                ),
              ],
            ),
            trading: () => Column(
              children: [
                SizedBox(height: 14.h),
                _buildUnifiedButton(
                  buttonState: buttonState,
                  defaultLabel: S.of(context).buyNow,
                  onPressed: null,
                ),
              ],
            ),
            ready: () => Column(
              children: [
                SizedBox(height: 14.h),
                _buildUnifiedButton(
                  buttonState: buttonState,
                  defaultLabel: S.of(context).buyNow,
                  onPressed: () {
                    context.read<SoundEffectCubit>().playGunLoad();
                    quickTradeCubit.buyToken(context);
                  },
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
```

---

**：** `lib/widgets/sheet/trade.dart`

 `_buildSell` （ 589-858 ）：

```dart
Widget _buildSell(isBalanceEnough) {
  return BlocBuilder<QuickTradeCubit, QuickTradeState>(
    buildWhen: (previous, current) =>
        previous.fromToken != current.fromToken ||
        previous.selectedToken != current.selectedToken ||
        previous.sellQuote != current.sellQuote ||
        previous.sellQuoteStatus != current.sellQuoteStatus ||
        previous.sellTokenStatus != current.sellTokenStatus ||
        previous.sellPercent != current.sellPercent,
    builder: (context, state) {
      final quickTradeCubit = context.read<QuickTradeCubit>();
      final buttonState = quickTradeCubit.sellButtonState;
      final sellPercent = state.sellPercent.isEmpty ? '0' : state.sellPercent;
      final String sellAmount;
      if (sellPercent == '100' || sellPercent == 'all') {
        sellAmount = state.selectedToken?.balance ?? '0';
      } else {
        final sellPercentValue = sellPercent.toPercentage();
        sellAmount = sellPercentValue.safeMultiply(
          state.selectedToken?.balance ?? '0',
        );
      }

      final balance = getIt<BalanceCubit>().getTokenBalance(
        state.selectedToken?.address,
        state.selectedToken?.network,
      );

      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 64.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Transform.translate(
                      offset: Offset(
                        0,
                        sellAmount.isNotEmptyAndZeroValue ? 8.h : 0,
                      ),
                      child: SizedBox(
                        width: 120.w,
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            TextField(
                              controller: _sellPercentController,
                              keyboardType: TextInputType.number,
                              onChanged: _handleSellPercentChange,
                              enableInteractiveSelection: true,
                              focusNode: _sellPercentFocusNode,
                              onEditingComplete: () {
                                _sellPercentFocusNode.unfocus();
                                context.read<QuickTradeCubit>().updateSellPercent(
                                  _sellPercentController.text,
                                );
                              },
                              onTap: () {
                                if (_sellPercentController.text == '0') {
                                  _sellPercentController.clear();
                                }
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                TextInputFormatter.withFunction((
                                  oldValue,
                                  newValue,
                                ) {
                                  if (newValue.text.isEmpty) {
                                    return newValue;
                                  }
                                  final int? value = int.tryParse(newValue.text);
                                  if (value == null) {
                                    return oldValue;
                                  }
                                  if (value > 100) {
                                    return oldValue;
                                  }
                                  if (newValue.text.length > 1 &&
                                      newValue.text.startsWith('0')) {
                                    return oldValue;
                                  }
                                  return newValue;
                                }),
                              ],
                              style: TextStyle(
                                fontSize: 28.sp,
                                color: AppColors.textPrimary(context),
                                fontWeight: FontWeight.w700,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '0',
                                hintStyle: TextStyle(
                                  fontSize: 28.sp,
                                  color: AppColors.textQuaternary(context),
                                  fontWeight: FontWeight.w700,
                                ),
                                contentPadding: EdgeInsets.zero,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            IgnorePointer(
                              child: Text(
                                "${_sellPercentController.text.isEmpty ? "0" : _sellPercentController.text}%",
                                style: TextStyle(
                                  fontSize: 28.sp,
                                  color: Colors.transparent,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Positioned(
                              left: _calculateTextWidth(
                                _sellPercentController.text,
                              ),
                              child: IgnorePointer(
                                child: Text(
                                  '%',
                                  style: TextStyle(
                                    fontSize: 28.sp,
                                    color: AppColors.textPrimary(context),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (sellAmount.isNotEmptyAndZeroValue && isBalanceEnough)
                      Padding(
                        padding: EdgeInsets.only(left: 3.w),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "${CurrencyFormatter.abbreviateTokenPrice(double.parse(sellAmount.toString()))} ${state.selectedToken?.symbol ?? ""}",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.textTertiary(context),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                Flexible(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        state.selectedToken?.symbol ?? '',
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textTertiary(context),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SvgPicture.asset(
                            'assets/images/icons/wallet-outline.svg',
                            colorFilter: ColorFilter.mode(
                              AppColors.textTertiary(context),
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            "${CurrencyFormatter.abbreviateTokenPrice(double.tryParse(balance.toString()) ?? 0)} ${state.selectedToken?.symbol ?? ""}",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.textTertiary(context),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 8.h),
          _buildSellButtons(
            onPressed: (value) {
              _handleSellPercentChange(value);
              _sellPercentFocusNode.unfocus();
            },
          ),

          SizedBox(height: 14.h),
          _buildUnifiedButton(
            buttonState: buttonState,
            defaultLabel: S.of(context).sellNow,
            onPressed: buttonState.isEnabled
                ? () {
                    context.read<SoundEffectCubit>().playGunLoad();
                    quickTradeCubit.sellToken(context);
                  }
                : null,
          ),
        ],
      );
    },
  );
}
```

---

**：** `lib/widgets/sheet/trade.dart`

（ `_buildConfirmButton`）：

```dart
Widget _buildUnifiedButton({
  required TradeButtonState buttonState,
  required String defaultLabel,
  required VoidCallback? onPressed,
}) {
  final Widget? icon = buttonState.maybeWhen(
    quoteLoading: () => null, // 
    trading: () => null,      // 
    orElse: () => SvgPicture.asset(
      'assets/images/icons/aim-outline.svg',
      colorFilter: ColorFilter.mode(
        buttonState.getIconColor(context),
        BlendMode.srcIn,
      ),
    ),
  );
  final Widget content = buttonState.when(
    disabled: (reason) => Text(
      reason.getLabel(context),
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
    quoteLoading: () => LottieAsset(
      const $AssetsLottieGen().aim,
      config: LottieConfig(
        width: 24.w,
        height: 24.w,
        repeat: true,
        animate: true,
      ),
    ),
    trading: () => Text(
      defaultLabel,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
    ready: () => Text(
      defaultLabel,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
  );

  return PrimaryButton(
    onPressed: buttonState.isLoading ? null : onPressed,
    height: 50.h,
    width: double.infinity,
    backgroundColor: buttonState.getBackgroundColor(context),
    disabledBackgroundColor: buttonState.getBackgroundColor(context),
    textColor: buttonState.getLabelColor(context),
    fontSize: 16,
    isLoading: buttonState is TradeButtonTrading,
    icon: icon,
    label: content,
  );
}
```

**：**  `_buildBalanceNotEnough()` ， UI。

---

**：** `lib/l10n/intl_en.arb`

```json
{
  "invalidAmount": "Invalid amount",
  "quoteFailed": "Quote failed, try again",
  "invalidParams": "Invalid parameters",
  "selectDifferentToken": "Select different tokens"
}
```

**：** `lib/l10n/intl_zh.arb`

```json
{
  "invalidAmount": "",
  "quoteFailed": "，",
  "invalidParams": "",
  "selectDifferentToken": ""
}
```

---

```bash
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n
```

---

|                     |      |                  |           |
| ------------------- | ---- | ---------------- | --------- |
| **** (`swap.dart`)  | 143  | 60               | **58% ↓** |
| **** (`trade.dart`) | ~160 | ~80              | **50% ↓** |
| **** (`trade.dart`) | ~270 | ~100             | **63% ↓** |
| ****                | ~573 | ~240  +  (~120 ) | **37% ↓** |

|          |                |              |
| -------- | -------------- | ------------ |
| ****     | Widget + Cubit | State getter |
| ****     | 3              | ， 1         |
| ****     |                | Freezed      |
| **Bug ** |                | ，           |

**：**

**：**
1.  Cubit 
2.  Widget 
3. （5+ ）
4. 
5. 
6.  1-5

**：**
1.  `TradeButtonDisabledReason` 
2.  getter 
3. 
4. 
5. ✅ ！

---

```dart
sealed class TradeButtonState {
  Color getBackgroundColor(BuildContext context);
  Color getLabelColor(BuildContext context);
  String getLabel(BuildContext context, {required String defaultLabel});
}
```

**：**
- 
- 
- 

```dart
sealed class TradeButtonDisabledReason {
  String getLabel(BuildContext context);
  int get priority;
}
```

**：**
- 
- 
- 

```dart
extension on TradeState {
  TradeButtonState get buttonState {
  }
}
```

**：**
- 
- （Freezed）
- 

```dart
final reasons = <TradeButtonDisabledReason>[];
reasons.sort((a, b) => b.priority.compareTo(a.priority));
return TradeButtonState.disabled(reason: reasons.first);
```

**：**
- 
- 
- 

---

```dart
group('TradeButtonState', () {
  test('： disabled(noAmount)', () {
    final state = QuickTradeState(
      buyAmount: '',
      fromToken: mockToken,
    );

    expect(state.buyButtonState, isA<TradeButtonDisabled>());
    final disabled = state.buyButtonState as TradeButtonDisabled;
    expect(disabled.reason, isA<_NoAmount>());
  });

  test('：（）', () {
    final state = QuickTradeState(
      buyAmount: '0.000000000000000001',
      fromToken: Token(decimals: 18),
    );

    final disabled = state.buyButtonState as TradeButtonDisabled;
    expect(disabled.reason, isA<_InvalidAmount>());
  });

  test('：', () {
    final state = QuickTradeState(
      buyAmount: '1000',
      fromToken: Token(balance: '100', symbol: 'ETH'),
      buyQuote: mockQuote,
      buyQuoteStatus: QuickTradeQuoteStatus.success,
    );

    final disabled = state.buyButtonState as TradeButtonDisabled;
    expect(disabled.reason, isA<_InsufficientBalance>());
    expect((disabled.reason as _InsufficientBalance).tokenSymbol, 'ETH');
  });

  test('： ready', () {
    final state = QuickTradeState(
      buyAmount: '100',
      fromToken: Token(balance: '1000', decimals: 18),
      selectedToken: mockDifferentToken,
      buyQuote: mockQuote,
      buyQuoteStatus: QuickTradeQuoteStatus.success,
    );

    expect(state.buyButtonState, isA<TradeButtonReady>());
    expect(state.buyButtonState.isEnabled, true);
  });

  test('：', () {
    final reasons = [
      const TradeButtonDisabledReason.insufficientFee(),  //  5
      TradeButtonDisabledReason.insufficientBalance(tokenSymbol: 'ETH'), //  6
    ];

    reasons.sort((a, b) => b.priority.compareTo(a.priority));

    expect(reasons.first, isA<_InsufficientBalance>());
  });
});
```

---

1. ✅ 
   -  `lib/shared/trade/trade_button_state.dart`
   -  `TradeButtonState`  `TradeButtonDisabledReason`
   -  `dart run build_runner build`

2. ✅ 
   -  `intl_en.arb`  `intl_zh.arb`
   -  `flutter gen-l10n`

1. ✅  `TradeState`
   -  `buttonState` getter
   -  `TradeCubit`  `checkFeeValidation()` 

2. ✅  `swap.dart`
   -  `_buildTradeButton()` 
   - 

1. ✅  `QuickTradeState`
   -  `buyButtonState`  `sellButtonState` getters

2. ✅  `QuickTradeCubit`
   - 

3. ✅  `trade.dart`
   -  `_buildBuy()` 
   -  `_buildSell()` 
   -  `_buildUnifiedButton()` 

1. **：**
   - [ ] ：
   - [ ] ：（）
   - [ ] ：
   - [ ] ：
   - [ ] ：
   - [ ] ：
   - [ ] ：
   - [ ] ：
   - [ ] ：
   - [ ] ：

2. ****

3. ****

1. ✅ 
   - `TradeCubit.checkAmount()`（）
   -  `_buildConfirmButton()`（）

2. ✅ 
   -  `CLAUDE.md` 
   - 

---

✅ **** - 
✅ **** -  37% ，
✅ **** -  Freezed ，
✅ **Bug ** - 
✅ **** - ，
✅ **** - ，
✅ **** -  4 ，

- **** - ，OCP 
- **** - 
- **** - ，
- **** - 
- **** - ，

- **DRY** (Don't Repeat Yourself) - 
- **SOLID** - 、
- **Clean Architecture** -  UI 
- **** -  Dart 
- **** - ，

---
- `lib/shared/trade/trade_button_state.dart` - （~120 ）
- `lib/cubits/trade/trade_state.dart` -  `buttonState` getter
- `lib/cubits/trade/trade_cubit.dart` -  `checkFeeValidation()` 
- `lib/cubits/quick_trade/quick_trade_state.dart` -  `buyButtonState`  `sellButtonState` getters
- `lib/cubits/quick_trade/quick_trade_cubit.dart` - 
- `lib/widgets/swap/widgets/swap.dart` -  `_buildTradeButton()` (143 → 60 )
- `lib/widgets/sheet/trade.dart` - / (~430 → ~180 )
- `lib/l10n/intl_en.arb` -  4 
- `lib/l10n/intl_zh.arb` -  4 
- `lib/shared/trade/trade_button_state.freezed.dart` - Freezed 

---

？：

1. ** 1**：
2. ** 2**：（）
3. ** 3**：

，。？