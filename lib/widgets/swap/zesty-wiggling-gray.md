# 交易按钮状态优化方案（完整版）

## 📋 概述

本文档提供了一个**统一的交易按钮状态管理优化方案**，涵盖项目中所有交易场景的按钮状态管理。当前系统存在两套交易逻辑，状态管理分散且重复，本方案将通过引入统一的设计模式来解决这些问题。

---

## 🎯 优化目标

1. **统一状态管理** - 为所有交易场景提供一致的按钮状态模式
2. **消除代码重复** - 提取共享的验证逻辑和状态类型
3. **修复已知 Bug** - 解决小数转换验证不一致的问题
4. **提升可维护性** - 使用类型安全的密封联合类型
5. **增强用户体验** - 提供更清晰的错误提示优先级

---

## 📊 当前系统架构分析

### 系统概览

项目中存在 **两套独立的交易系统**：

```
交易系统架构
├── 1. 主交易系统 (TradeCubit)
│   ├── 用途：Swap 页面的代币交换
│   ├── 状态：lib/cubits/trade/trade_state.dart
│   ├── 逻辑：lib/cubits/trade/trade_cubit.dart
│   └── UI：lib/widgets/swap/widgets/swap.dart
│
└── 2. 快速交易系统 (QuickTradeCubit)
    ├── 用途：代币详情页的快速买卖
    ├── 状态：lib/cubits/quick_trade/quick_trade_state.dart
    ├── 逻辑：lib/cubits/quick_trade/quick_trade_cubit.dart
    └── UI：lib/widgets/sheet/trade.dart
```

---

## 🔍 详细问题分析

### 1. 主交易系统 (TradeCubit) 的问题

**文件位置：**
- 状态：`lib/cubits/trade/trade_state.dart`
- 按钮 UI：`lib/widgets/swap/widgets/swap.dart:293-436`

**当前问题：**

#### 1.1 分散的状态逻辑（143 行代码）

```dart
// lib/widgets/swap/widgets/swap.dart:293-436
Widget _buildTradeButton(BuildContext context) {
  return BlocBuilder<TradeCubit, TradeState>(
    builder: (context, state) {
      // ❌ 问题：7+ 个布尔标志在 widget 中计算
      final isLoading = state.status.maybeWhen(...);
      final isValid = state.paramsStatus.mapOrNull(...);
      final hasValidQuote = state.quoteStatus.maybeMap(...);
      final isQuoteLoading = state.quoteStatus.maybeMap(...);
      final isTradeLoading = state.status.maybeMap(...);
      final shouldCheckBalance = state.amount.isNotEmptyAndZeroValue;
      final isValidBalance = !shouldCheckBalance ? true : ...;
      final isEnoughFee = context.read<TradeCubit>().isEnoughFee(); // ❌ 每次重建都调用

      // ❌ 问题：复杂的条件嵌套
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

      // ❌ 问题：错误消息优先级硬编码
      final buttonTextContent = !shouldCheckBalance
          ? buttonText
          : !isEnoughFee
          ? S.of(context).feeNotEnough
          : isValidBalance
          ? buttonText
          : '${state.fromToken?.symbol} ${S.of(context).balanceNotEnough}';

      // ... 更多重复的逻辑
    }
  );
}
```

**核心问题：**
- **验证逻辑分散**：部分在 widget，部分在 cubit
- **重复计算**：`isEnoughFee()` 每次重建都调用
- **维护困难**：添加新验证需要修改多处
- **类型不安全**：手动管理多个布尔值，易出错

#### 1.2 验证不一致导致的 Bug

```dart
// 按钮检查
final shouldCheckBalance = state.amount.isNotEmptyAndZeroValue; // ✅ 通过

// swap() 方法检查（lib/cubits/trade/trade_cubit.dart:476-485）
final newAmount = state.amount.divideByDecimalPower(state.fromToken?.decimals ?? 18);
if (!newAmount.isNotEmptyAndZeroValue) { // ❌ 失败
  emit(state.copyWith(
    status: const TradeStatusMessage.failure(TradeStatus.paramsInvalid),
  ));
  return;
}
```

**Bug 场景：**
```
用户输入：0.000000000000000001（18 位小数）
按钮检查：amount.isNotEmptyAndZeroValue = true ✅ 按钮启用
小数转换：divideByDecimalPower(18) = "0"
swap() 检查：newAmount.isNotEmptyAndZeroValue = false ❌ 交易失败
结果：用户点击按钮后看到 "参数无效" 错误
```

#### 1.3 状态类型定义

**TradeState 使用的状态枚举：**

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

### 2. 快速交易系统 (QuickTradeCubit) 的问题

**文件位置：**
- 状态：`lib/cubits/quick_trade/quick_trade_state.dart`
- 买入按钮 UI：`lib/widgets/sheet/trade.dart:1023-1072`
- 卖出按钮 UI：`lib/widgets/sheet/trade.dart:820-854`

**当前问题：**

#### 2.1 买入按钮的分散逻辑

```dart
// lib/widgets/sheet/trade.dart:862-1021
Widget _buildBuy(bool isBalanceEnough) {
  return BlocBuilder<QuickTradeCubit, QuickTradeState>(
    builder: (context, state) {
      // ❌ 问题：每次重建都调用 cubit 方法
      final isEnoughFee = context.read<QuickTradeCubit>().buyAmountIsEnoughFee();
      final isBuyAmountValid = context.read<QuickTradeCubit>().isBuyAmountValid();

      // ❌ 问题：状态检查分散
      final isQuoteLoading = state.buyQuoteStatus == QuickTradeQuoteStatus.loading;
      final isTradeLoading = state.buyTokenStatus.whenOrNull(loading: () => true) ?? false;

      // ... UI 逻辑

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
  // ❌ 问题：嵌套的条件判断
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

#### 2.2 卖出按钮的重复逻辑

```dart
// lib/widgets/sheet/trade.dart:589-858
Widget _buildSell(isBalanceEnough) {
  return BlocBuilder<QuickTradeCubit, QuickTradeState>(
    builder: (context, state) {
      // ❌ 问题：与买入按钮相同的重复逻辑
      final isEnoughFee = context.read<QuickTradeCubit>().sellAmountIsEnoughFee();
      final isQuoteLoading = state.sellQuoteStatus == QuickTradeQuoteStatus.loading;
      final isTradeLoading = state.sellTokenStatus.whenOrNull(loading: () => true) ?? false;

      // ❌ 问题：手动计算按钮状态
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

#### 2.3 QuickTradeCubit 中的验证方法

**手续费验证（重复代码）：**

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
  // ❌ 问题：几乎完全相同的逻辑重复
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

**金额验证：**

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

#### 2.4 状态类型定义

**QuickTradeState 使用的状态枚举：**

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

**余额检查（扩展方法）：**

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

## 🎨 统一优化方案设计

### 核心设计理念

使用 **状态模式 (State Pattern)** + **计算属性 (Computed Properties)** 统一管理所有交易按钮状态。

### 架构设计

```
┌─────────────────────────────────────────────────────────┐
│           共享基础层 (lib/shared/trade/)                │
│  ┌───────────────────────────────────────────────────┐  │
│  │  TradeButtonState (密封联合类型)                  │  │
│  │  ├─ Disabled (reason)                            │  │
│  │  ├─ QuoteLoading                                 │  │
│  │  ├─ Trading                                      │  │
│  │  └─ Ready                                        │  │
│  │                                                   │  │
│  │  TradeButtonDisabledReason (密封联合类型)        │  │
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
                            ↓ 继承/使用
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

## 📐 详细实现方案

### 第一步：创建共享的按钮状态类型

**文件：** `lib/shared/trade/trade_button_state.dart`（新建）

```dart
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../l10n/l10n.dart';
import '../../themes/colors.dart';

part 'trade_button_state.freezed.dart';

/// 交易按钮的所有可能状态
/// 使用密封联合类型确保类型安全和完整的模式匹配
@freezed
sealed class TradeButtonState with _$TradeButtonState {
  const TradeButtonState._();

  /// 按钮禁用状态 - 无法进行交易
  const factory TradeButtonState.disabled({
    required TradeButtonDisabledReason reason,
  }) = TradeButtonDisabled;

  /// 正在获取报价 - 显示加载动画
  const factory TradeButtonState.quoteLoading() = TradeButtonQuoteLoading;

  /// 正在执行交易
  const factory TradeButtonState.trading() = TradeButtonTrading;

  /// 准备就绪 - 所有验证通过，可以交易
  const factory TradeButtonState.ready() = TradeButtonReady;

  // ==================== UI 辅助方法 ====================

  /// 按钮是否可点击
  bool get isEnabled => this is TradeButtonReady;

  /// 是否显示加载动画
  bool get isLoading => this is TradeButtonQuoteLoading || this is TradeButtonTrading;

  /// 获取按钮文本标签
  String getLabel(BuildContext context, {required String defaultLabel}) {
    return when(
      disabled: (reason) => reason.getLabel(context),
      quoteLoading: () => defaultLabel,
      trading: () => defaultLabel,
      ready: () => defaultLabel,
    );
  }

  /// 获取按钮背景色
  Color getBackgroundColor(BuildContext context) {
    return when(
      disabled: (_) => AppColors.quinary,
      quoteLoading: () => AppColors.quinary,
      trading: () => AppColors.buttonPrimary(context),
      ready: () => AppColors.buttonPrimary(context),
    );
  }

  /// 获取按钮文字颜色
  Color getLabelColor(BuildContext context) {
    return when(
      disabled: (_) => AppColors.textTertiary(context),
      quoteLoading: () => AppColors.textTertiary(context),
      trading: () => Colors.black,
      ready: () => Colors.black,
    );
  }

  /// 获取图标颜色
  Color getIconColor(BuildContext context) {
    return getLabelColor(context);
  }
}

/// 按钮禁用的具体原因
/// 每个原因都有对应的优先级和错误消息
@freezed
sealed class TradeButtonDisabledReason with _$TradeButtonDisabledReason {
  const TradeButtonDisabledReason._();

  /// 未输入金额
  const factory TradeButtonDisabledReason.noAmount() = _NoAmount;

  /// 金额无效（小数转换后为零）
  const factory TradeButtonDisabledReason.invalidAmount() = _InvalidAmount;

  /// 余额不足
  const factory TradeButtonDisabledReason.insufficientBalance({
    required String tokenSymbol,
  }) = _InsufficientBalance;

  /// 手续费不足
  const factory TradeButtonDisabledReason.insufficientFee() = _InsufficientFee;

  /// 没有报价
  const factory TradeButtonDisabledReason.noQuote() = _NoQuote;

  /// 报价失败
  const factory TradeButtonDisabledReason.quoteFailed() = _QuoteFailed;

  /// 参数无效
  const factory TradeButtonDisabledReason.invalidParams() = _InvalidParams;

  /// 选择了相同的代币
  const factory TradeButtonDisabledReason.sameToken() = _SameToken;

  /// 获取错误消息文本
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

  /// 错误优先级
  /// 数字越大优先级越高，优先显示高优先级的错误
  int get priority => when(
    noAmount: () => 1,          // 最低优先级：没输入金额
    noQuote: () => 2,           // 等待报价
    quoteFailed: () => 3,       // 报价失败
    invalidAmount: () => 4,     // 金额无效
    insufficientFee: () => 5,   // 手续费不足
    insufficientBalance: (_) => 6, // 余额不足
    invalidParams: () => 7,     // 参数错误
    sameToken: () => 8,         // 最高优先级：选择了相同代币
  );
}
```

---

### 第二步：为 TradeState 添加按钮状态计算

**文件：** `lib/cubits/trade/trade_state.dart`

在现有的 `TradeState` 类中添加计算属性 `buttonState`：

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../shared/trade/trade_button_state.dart';
import '../../utils/extensions/string.dart';
import '../../utils/numeric_utils.dart';

// ... 现有的导入和状态定义 ...

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

  /// ==================== 按钮状态计算（核心逻辑） ====================
  ///
  /// 计算交易按钮的当前状态
  /// 优先级顺序：Trading > QuoteLoading > Disabled (按优先级) > Ready
  TradeButtonState get buttonState {
    // 1️⃣ 最高优先级：正在执行交易
    final isTrading = status.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );
    if (isTrading) {
      return const TradeButtonState.trading();
    }

    // 2️⃣ 第二优先级：正在获取报价
    final isQuoteLoading = quoteStatus.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );
    if (isQuoteLoading) {
      return const TradeButtonState.quoteLoading();
    }

    // 3️⃣ 收集所有禁用原因
    final List<TradeButtonDisabledReason> reasons = [];

    // ✅ 检查：是否输入了金额
    if (!amount.isNotEmptyAndZeroValue) {
      reasons.add(const TradeButtonDisabledReason.noAmount());
    }

    // ✅ 检查：是否选择了相同的代币
    if (fromToken?.address == toToken?.address &&
        fromToken?.chainId == toToken?.chainId) {
      reasons.add(const TradeButtonDisabledReason.sameToken());
    }

    // ✅ 检查：参数验证状态
    final isParamsInvalid = paramsStatus.maybeWhen(
      failure: () => true,
      orElse: () => false,
    );
    if (isParamsInvalid) {
      reasons.add(const TradeButtonDisabledReason.invalidParams());
    }

    // ✅ 检查：金额经过小数转换后是否有效（修复 bug）
    if (amount.isNotEmptyAndZeroValue) {
      final newAmount = amount.divideByDecimalPower(fromToken?.decimals ?? 18);
      if (!newAmount.isNotEmptyAndZeroValue) {
        reasons.add(const TradeButtonDisabledReason.invalidAmount());
      }
    }

    // ✅ 检查：余额是否充足
    if (amount.isNotEmptyAndZeroValue && fromBalance != null) {
      final amountValue = double.tryParse(amount) ?? 0.0;
      final balanceValue = fromBalance ?? 0.0;
      if (amountValue > balanceValue) {
        reasons.add(TradeButtonDisabledReason.insufficientBalance(
          tokenSymbol: fromToken?.symbol ?? '',
        ));
      }
    }

    // ✅ 检查：报价状态（只在输入了有效金额时才检查）
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

    // ✅ 检查：手续费是否充足（只在有有效报价后才检查）
    final hasValidQuote = quoteStatus.maybeWhen(
      success: () => quote != null,
      orElse: () => false,
    );
    if (hasValidQuote && amount.isNotEmptyAndZeroValue) {
      final fee = quote?.fee?.toDouble() ?? 0.0;

      if (fromToken?.isNative ?? false) {
        // 原生代币：检查余额减去手续费
        final balance = NumericUtils.multiplyByDecimalPower(
          fromBalance.toString(),
          fromToken!.decimals,
        ).toString();
        final remainingBalance = balance.toDouble() - fee;
        if (remainingBalance < 0) {
          reasons.add(const TradeButtonDisabledReason.insufficientFee());
        }
      } else {
        // 非原生代币：需要检查原生代币余额来支付手续费
        // 这部分逻辑需要访问 nativeTokens，稍后在 TradeCubit 中实现辅助方法
        // 临时方案：先不在这里检查，由 cubit 提供方法
      }
    }

    // 4️⃣ 返回结果
    if (reasons.isEmpty) {
      return const TradeButtonState.ready();
    }

    // 按优先级排序，返回最高优先级的原因
    reasons.sort((a, b) => b.priority.compareTo(a.priority));
    return TradeButtonState.disabled(reason: reasons.first);
  }
}
```

**注意：** 由于 `TradeState` 是不可变的，无法直接访问 `nativeTokens` 列表来检查非原生代币的手续费。我们需要在 `TradeCubit` 中提供辅助方法。

---

### 第三步：在 TradeCubit 中添加辅助方法

**文件：** `lib/cubits/trade/trade_cubit.dart`

添加一个方法来检查手续费，供 `buttonState` getter 使用：

```dart
class TradeCubit extends Cubit<TradeState> {
  // ... 现有代码 ...

  /// 检查手续费是否充足（包含原生和非原生代币）
  /// 返回 null 表示手续费充足，返回原因表示不足
  TradeButtonDisabledReason? checkFeeValidation() {
    final quote = state.quote;
    final fromToken = state.fromToken;

    if (quote == null || fromToken == null) {
      return null; // 没有报价或代币信息，不检查
    }

    final fee = quote.fee?.toDouble() ?? 0.0;

    if (fromToken.isNative) {
      // 原生代币：直接检查余额
      final balance = NumericUtils.multiplyByDecimalPower(
        state.fromBalance.toString(),
        fromToken.decimals,
      ).toString();

      final remainingBalance = balance.toDouble() - fee;
      if (remainingBalance < 0) {
        return const TradeButtonDisabledReason.insufficientFee();
      }
    } else {
      // 非原生代币：检查原生代币余额
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

    return null; // 手续费充足
  }

  /// 获取原生代币（私有辅助方法）
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

  // ... 其他现有方法保持不变 ...
}
```

**更新 `buttonState` getter 以使用这个方法：**

由于 `TradeState` 是不可变的，我们需要将完整的按钮状态计算移到 `TradeCubit` 中作为方法，而不是作为 `TradeState` 的 getter。

**修正方案：** 在 `TradeCubit` 中提供一个方法：

```dart
class TradeCubit extends Cubit<TradeState> {
  // ... 现有代码 ...

  /// 获取交易按钮的当前状态
  TradeButtonState get buttonState {
    // 复用 TradeState 中的大部分逻辑
    final baseState = state.buttonState;

    // 如果基础状态已经是 trading/quoteLoading/ready，直接返回
    if (baseState is! TradeButtonDisabled) {
      return baseState;
    }

    // 如果是 disabled 状态，检查是否是因为没有检查手续费
    final reasons = <TradeButtonDisabledReason>[];

    // 重新收集所有原因（包括手续费检查）
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

    // ✅ 使用辅助方法检查手续费
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

### 第四步：重构 Swap 页面按钮 UI

**文件：** `lib/widgets/swap/widgets/swap.dart`

替换整个 `_buildTradeButton` 方法（第 293-436 行）：

```dart
Widget _buildTradeButton(BuildContext context) {
  return BlocBuilder<TradeCubit, TradeState>(
    builder: (context, state) {
      // ✅ 获取计算好的按钮状态（单一数据源）
      final tradeCubit = context.read<TradeCubit>();
      final buttonState = tradeCubit.buttonState;

      // ✅ 确定按钮默认文本
      final defaultLabel = widget.buyToken
          ? S.of(context).buyNow
          : S.of(context).tradeNow;

      // ✅ 根据状态决定按钮内容
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

      // ✅ 只在非加载状态时显示图标
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

**代码减少：**
- **之前：** 143 行
- **之后：** 60 行
- **减少：** 58%

---

### 第五步：为 QuickTradeState 添加按钮状态计算

**文件：** `lib/cubits/quick_trade/quick_trade_state.dart`

添加两个计算属性：`buyButtonState` 和 `sellButtonState`。

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../shared/trade/trade_button_state.dart';
import '../../utils/extensions/string.dart';
import '../../utils/numeric_utils.dart';

// ... 现有的导入和枚举定义 ...

extension QuickTradeStateExtension on QuickTradeState {
  // ... 现有的 isBalanceEnough() 方法保持不变 ...

  /// ==================== 买入按钮状态计算 ====================
  ///
  /// 计算买入按钮的当前状态
  TradeButtonState get buyButtonState {
    // 1️⃣ 最高优先级：正在执行交易
    final isTrading = buyTokenStatus.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );
    if (isTrading) {
      return const TradeButtonState.trading();
    }

    // 2️⃣ 第二优先级：正在获取报价
    if (buyQuoteStatus == QuickTradeQuoteStatus.loading) {
      return const TradeButtonState.quoteLoading();
    }

    // 3️⃣ 收集所有禁用原因
    final List<TradeButtonDisabledReason> reasons = [];

    // ✅ 检查：是否输入了买入金额
    if (!buyAmount.isNotEmptyAndZeroValue) {
      reasons.add(const TradeButtonDisabledReason.noAmount());
    }

    // ✅ 检查：是否选择了相同的代币
    if (fromToken?.address == selectedToken?.address &&
        fromToken?.chainId == selectedToken?.chainId) {
      reasons.add(const TradeButtonDisabledReason.sameToken());
    }

    // ✅ 检查：金额经过小数转换后是否有效
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

    // ✅ 检查：余额是否充足
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

    // ✅ 检查：报价状态
    if (buyAmount.isNotEmptyAndZeroValue) {
      if (buyQuoteStatus == QuickTradeQuoteStatus.failure) {
        reasons.add(const TradeButtonDisabledReason.quoteFailed());
      } else if (buyQuoteStatus != QuickTradeQuoteStatus.success || buyQuote == null) {
        reasons.add(const TradeButtonDisabledReason.noQuote());
      }
    }

    // ✅ 检查：手续费（需要在 QuickTradeCubit 中检查，因为需要访问 nativeTokens）
    // 这里先不检查，由 cubit 提供完整的状态

    // 4️⃣ 返回结果
    if (reasons.isEmpty) {
      return const TradeButtonState.ready();
    }

    reasons.sort((a, b) => b.priority.compareTo(a.priority));
    return TradeButtonState.disabled(reason: reasons.first);
  }

  /// ==================== 卖出按钮状态计算 ====================
  ///
  /// 计算卖出按钮的当前状态
  TradeButtonState get sellButtonState {
    // 1️⃣ 最高优先级：正在执行交易
    final isTrading = sellTokenStatus.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );
    if (isTrading) {
      return const TradeButtonState.trading();
    }

    // 2️⃣ 第二优先级：正在获取报价
    if (sellQuoteStatus == QuickTradeQuoteStatus.loading) {
      return const TradeButtonState.quoteLoading();
    }

    // 3️⃣ 收集所有禁用原因
    final List<TradeButtonDisabledReason> reasons = [];

    // ✅ 检查：是否输入了卖出百分比
    if (!sellPercent.isNotEmptyAndZeroValue) {
      reasons.add(const TradeButtonDisabledReason.noAmount());
    }

    // ✅ 检查：代币余额
    if (!(selectedToken?.balance.isNotEmptyAndZeroValue ?? false)) {
      reasons.add(TradeButtonDisabledReason.insufficientBalance(
        tokenSymbol: selectedToken?.symbol ?? '',
      ));
    }

    // ✅ 检查：卖出金额是否有效
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

    // ✅ 检查：报价状态
    if (sellPercent.isNotEmptyAndZeroValue) {
      if (sellQuoteStatus == QuickTradeQuoteStatus.failure) {
        reasons.add(const TradeButtonDisabledReason.quoteFailed());
      } else if (sellQuoteStatus != QuickTradeQuoteStatus.success || sellQuote == null) {
        reasons.add(const TradeButtonDisabledReason.noQuote());
      }
    }

    // 4️⃣ 返回结果
    if (reasons.isEmpty) {
      return const TradeButtonState.ready();
    }

    reasons.sort((a, b) => b.priority.compareTo(a.priority));
    return TradeButtonState.disabled(reason: reasons.first);
  }
}
```

---

### 第六步：在 QuickTradeCubit 中添加完整的按钮状态方法

**文件：** `lib/cubits/quick_trade/quick_trade_cubit.dart`

添加两个方法来获取完整的按钮状态（包含手续费检查）：

```dart
class QuickTradeCubit extends Cubit<QuickTradeState> {
  // ... 现有代码 ...

  /// 获取买入按钮的完整状态（包含手续费检查）
  TradeButtonState get buyButtonState {
    // 先获取基础状态
    final baseState = state.buyButtonState;

    // 如果不是 ready 或 disabled 状态，直接返回
    if (baseState is TradeButtonTrading || baseState is TradeButtonQuoteLoading) {
      return baseState;
    }

    // 如果已经有其他禁用原因，检查优先级
    if (baseState is TradeButtonDisabled) {
      // 如果优先级高于手续费检查，直接返回
      if (baseState.reason.priority > 5) {
        return baseState;
      }
    }

    // 检查手续费
    if (state.buyAmount.isNotEmptyAndZeroValue &&
        state.buyQuote != null &&
        !buyAmountIsEnoughFee()) {
      return const TradeButtonState.disabled(
        reason: TradeButtonDisabledReason.insufficientFee(),
      );
    }

    return baseState;
  }

  /// 获取卖出按钮的完整状态（包含手续费检查）
  TradeButtonState get sellButtonState {
    // 先获取基础状态
    final baseState = state.sellButtonState;

    // 如果不是 ready 或 disabled 状态，直接返回
    if (baseState is TradeButtonTrading || baseState is TradeButtonQuoteLoading) {
      return baseState;
    }

    // 如果已经有其他禁用原因，检查优先级
    if (baseState is TradeButtonDisabled) {
      // 如果优先级高于手续费检查，直接返回
      if (baseState.reason.priority > 5) {
        return baseState;
      }
    }

    // 检查手续费
    if (state.sellPercent.isNotEmptyAndZeroValue &&
        state.sellQuote != null &&
        !sellAmountIsEnoughFee()) {
      return const TradeButtonState.disabled(
        reason: TradeButtonDisabledReason.insufficientFee(),
      );
    }

    return baseState;
  }

  // ... 保留现有的 buyAmountIsEnoughFee() 和 sellAmountIsEnoughFee() 方法 ...
}
```

---

### 第七步：重构快速交易弹窗的买入按钮

**文件：** `lib/widgets/sheet/trade.dart`

替换 `_buildBuy` 方法中的按钮逻辑（第 862-1021 行）：

```dart
// 买入输入行
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
      // ✅ 获取计算好的按钮状态
      final quickTradeCubit = context.read<QuickTradeCubit>();
      final buttonState = quickTradeCubit.buyButtonState;

      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 18.h),

          // ... TextField 和其他 UI 保持不变 ...
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

          // 快速金额选择按钮
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

          // ✅ 新的统一按钮逻辑
          buttonState.when(
            disabled: (reason) {
              // 特殊处理余额不足的情况（显示两个按钮）
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

              // 其他禁用原因：显示单个禁用按钮
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

### 第八步：重构快速交易弹窗的卖出按钮

**文件：** `lib/widgets/sheet/trade.dart`

替换 `_buildSell` 方法中的按钮逻辑（第 589-858 行）：

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
      // ✅ 获取计算好的按钮状态
      final quickTradeCubit = context.read<QuickTradeCubit>();
      final buttonState = quickTradeCubit.sellButtonState;

      // 检查 sellPercent 是否为空或无效
      final sellPercent = state.sellPercent.isEmpty ? '0' : state.sellPercent;

      // 计算卖出金额
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
                // ... 百分比输入 TextField UI 保持不变 ...
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

          // 快速百分比选择按钮
          _buildSellButtons(
            onPressed: (value) {
              _handleSellPercentChange(value);
              _sellPercentFocusNode.unfocus();
            },
          ),

          SizedBox(height: 14.h),

          // ✅ 新的统一按钮逻辑
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

### 第九步：添加统一的按钮渲染方法

**文件：** `lib/widgets/sheet/trade.dart`

添加一个新的方法来统一渲染按钮（替换原来的 `_buildConfirmButton`）：

```dart
/// 统一的按钮渲染方法
/// 根据 TradeButtonState 自动处理所有 UI 逻辑
Widget _buildUnifiedButton({
  required TradeButtonState buttonState,
  required String defaultLabel,
  required VoidCallback? onPressed,
}) {
  // 根据状态决定图标
  final Widget? icon = buttonState.maybeWhen(
    quoteLoading: () => null, // 加载时不显示图标
    trading: () => null,      // 交易中不显示图标
    orElse: () => SvgPicture.asset(
      'assets/images/icons/aim-outline.svg',
      colorFilter: ColorFilter.mode(
        buttonState.getIconColor(context),
        BlendMode.srcIn,
      ),
    ),
  );

  // 根据状态决定按钮内容
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

**注意：** 可以保留原来的 `_buildBalanceNotEnough()` 方法，因为余额不足时有特殊的双按钮 UI。

---

### 第十步：添加本地化键值

**文件：** `lib/l10n/intl_en.arb`

```json
{
  "invalidAmount": "Invalid amount",
  "quoteFailed": "Quote failed, try again",
  "invalidParams": "Invalid parameters",
  "selectDifferentToken": "Select different tokens"
}
```

**文件：** `lib/l10n/intl_zh.arb`

```json
{
  "invalidAmount": "金额无效",
  "quoteFailed": "报价失败，请重试",
  "invalidParams": "参数无效",
  "selectDifferentToken": "请选择不同代币"
}
```

---

### 第十一步：运行代码生成

```bash
# 生成 Freezed 模型
dart run build_runner build --delete-conflicting-outputs

# 生成本地化文件
flutter gen-l10n
```

---

## ✅ 优化成果对比

### 代码量对比

| 文件 | 优化前 | 优化后 | 减少 |
|------|--------|--------|------|
| **主交易按钮** (`swap.dart`) | 143 行 | 60 行 | **58% ↓** |
| **快速买入按钮** (`trade.dart`) | ~160 行 | ~80 行 | **50% ↓** |
| **快速卖出按钮** (`trade.dart`) | ~270 行 | ~100 行 | **63% ↓** |
| **总计** | ~573 行 | ~240 行 + 共享层 (~120 行) | **37% ↓** |

### 验证逻辑对比

| 方面 | 优化前 | 优化后 |
|------|--------|--------|
| **验证位置** | Widget + Cubit 分散 | 统一在 State getter |
| **重复代码** | 手续费验证重复 3 次 | 共享方法，仅 1 次 |
| **类型安全** | 手动管理布尔值 | Freezed 密封联合类型 |
| **Bug 风险** | 验证不一致 | 单一数据源，无偏差 |

### 可维护性对比

**添加新验证的步骤：**

**优化前：**
1. 在 Cubit 中添加验证方法
2. 在 Widget 中调用方法
3. 更新按钮状态条件（5+ 处）
4. 更新按钮文本逻辑
5. 更新颜色逻辑
6. 在其他交易场景重复 1-5

**优化后：**
1. 在 `TradeButtonDisabledReason` 添加新原因
2. 在状态 getter 中添加检查逻辑
3. 添加本地化
4. 运行代码生成
5. ✅ 完成！所有场景自动更新

---

## 🎓 设计模式总结

### 1. 状态模式 (State Pattern)

```dart
sealed class TradeButtonState {
  // 每个状态封装自己的行为
  Color getBackgroundColor(BuildContext context);
  Color getLabelColor(BuildContext context);
  String getLabel(BuildContext context, {required String defaultLabel});
}
```

**优势：**
- 消除条件分支
- 添加新状态无需修改现有代码
- 编译器确保所有状态都被处理

### 2. 策略模式 (Strategy Pattern)

```dart
sealed class TradeButtonDisabledReason {
  // 每个原因有自己的标签策略
  String getLabel(BuildContext context);

  // 每个原因有自己的优先级策略
  int get priority;
}
```

**优势：**
- 错误消息可扩展
- 优先级算法清晰
- 易于测试

### 3. 计算属性 (Computed Properties)

```dart
extension on TradeState {
  TradeButtonState get buttonState {
    // 从基础状态计算派生状态
    // 只在状态变化时重新计算
  }
}
```

**优势：**
- 单一数据源
- 自动缓存（Freezed）
- 无需手动同步

### 4. 优先级队列模式

```dart
final reasons = <TradeButtonDisabledReason>[];
// 收集所有原因...
reasons.sort((a, b) => b.priority.compareTo(a.priority));
return TradeButtonState.disabled(reason: reasons.first);
```

**优势：**
- 自动选择最重要的错误
- 用户体验一致
- 易于调整优先级

---

## 🧪 测试策略

### 单元测试示例

```dart
group('TradeButtonState', () {
  test('买入按钮：无金额时返回 disabled(noAmount)', () {
    final state = QuickTradeState(
      buyAmount: '',
      fromToken: mockToken,
    );

    expect(state.buyButtonState, isA<TradeButtonDisabled>());
    final disabled = state.buyButtonState as TradeButtonDisabled;
    expect(disabled.reason, isA<_NoAmount>());
  });

  test('买入按钮：金额无效（小数转换后为零）', () {
    final state = QuickTradeState(
      buyAmount: '0.000000000000000001',
      fromToken: Token(decimals: 18),
    );

    final disabled = state.buyButtonState as TradeButtonDisabled;
    expect(disabled.reason, isA<_InvalidAmount>());
  });

  test('买入按钮：余额不足', () {
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

  test('买入按钮：所有验证通过时返回 ready', () {
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

  test('优先级测试：余额不足优先于手续费不足', () {
    final reasons = [
      const TradeButtonDisabledReason.insufficientFee(),  // 优先级 5
      TradeButtonDisabledReason.insufficientBalance(tokenSymbol: 'ETH'), // 优先级 6
    ];

    reasons.sort((a, b) => b.priority.compareTo(a.priority));

    expect(reasons.first, isA<_InsufficientBalance>());
  });
});
```

---

## 🚀 迁移步骤

### 阶段 1：准备（无破坏性更改）

1. ✅ 创建共享基础层
   - 创建 `lib/shared/trade/trade_button_state.dart`
   - 添加 `TradeButtonState` 和 `TradeButtonDisabledReason`
   - 运行 `dart run build_runner build`

2. ✅ 添加本地化
   - 更新 `intl_en.arb` 和 `intl_zh.arb`
   - 运行 `flutter gen-l10n`

### 阶段 2：主交易系统

1. ✅ 更新 `TradeState`
   - 添加 `buttonState` getter
   - 在 `TradeCubit` 中添加 `checkFeeValidation()` 方法

2. ✅ 重构 `swap.dart`
   - 替换 `_buildTradeButton()` 方法
   - 测试所有按钮状态

### 阶段 3：快速交易系统

1. ✅ 更新 `QuickTradeState`
   - 添加 `buyButtonState` 和 `sellButtonState` getters

2. ✅ 更新 `QuickTradeCubit`
   - 添加完整的按钮状态方法

3. ✅ 重构 `trade.dart`
   - 更新 `_buildBuy()` 方法
   - 更新 `_buildSell()` 方法
   - 添加 `_buildUnifiedButton()` 方法

### 阶段 4：测试

1. **手动测试所有场景：**
   - [ ] 主交易：没有输入金额
   - [ ] 主交易：金额无效（小数精度）
   - [ ] 主交易：余额不足
   - [ ] 主交易：手续费不足
   - [ ] 主交易：报价中
   - [ ] 主交易：报价失败
   - [ ] 主交易：交易中
   - [ ] 主交易：准备就绪
   - [ ] 快速买入：所有上述场景
   - [ ] 快速卖出：所有上述场景

2. **验证错误消息优先级**

3. **验证多语言显示**

### 阶段 5：清理

1. ✅ 删除不再使用的方法
   - `TradeCubit.checkAmount()`（如果没有其他地方使用）
   - 旧的 `_buildConfirmButton()`（保留一个用于余额不足场景）

2. ✅ 更新文档
   - 在 `CLAUDE.md` 中记录新模式
   - 添加使用示例

---

## 📝 最终总结

### 主要成就

✅ **统一架构** - 两套交易系统使用相同的按钮状态模式
✅ **代码减少** - 总体减少 37% 的代码，维护成本大幅降低
✅ **类型安全** - 使用 Freezed 密封联合类型，编译时保证正确性
✅ **Bug 修复** - 修复小数转换验证不一致问题
✅ **用户体验** - 基于优先级的错误消息，更清晰的反馈
✅ **可测试性** - 纯状态逻辑，易于编写单元测试
✅ **可扩展性** - 添加新验证只需 4 步，所有场景自动更新

### 技术亮点

- **状态模式** - 消除条件分支，OCP 原则
- **策略模式** - 可扩展的标签和优先级系统
- **计算属性** - 单一数据源，自动缓存
- **优先级队列** - 智能错误消息选择
- **值对象** - 不可变状态，线程安全

### 遵循原则

- **DRY** (Don't Repeat Yourself) - 共享验证逻辑
- **SOLID** - 单一职责、开闭原则
- **Clean Architecture** - 业务逻辑与 UI 分离
- **类型安全** - 利用 Dart 类型系统
- **可测试性** - 纯函数，无副作用

---

## 📚 相关文件清单

### 新建文件
- `lib/shared/trade/trade_button_state.dart` - 共享按钮状态类型（~120 行）

### 修改文件
- `lib/cubits/trade/trade_state.dart` - 添加 `buttonState` getter
- `lib/cubits/trade/trade_cubit.dart` - 添加 `checkFeeValidation()` 方法
- `lib/cubits/quick_trade/quick_trade_state.dart` - 添加 `buyButtonState` 和 `sellButtonState` getters
- `lib/cubits/quick_trade/quick_trade_cubit.dart` - 添加完整按钮状态方法
- `lib/widgets/swap/widgets/swap.dart` - 重构 `_buildTradeButton()` (143 → 60 行)
- `lib/widgets/sheet/trade.dart` - 重构买入/卖出按钮逻辑 (~430 → ~180 行)
- `lib/l10n/intl_en.arb` - 添加 4 个新键值
- `lib/l10n/intl_zh.arb` - 添加 4 个中文翻译

### 生成文件
- `lib/shared/trade/trade_button_state.freezed.dart` - Freezed 生成

---

## 🎯 下一步行动

您想让我开始实施这个优化方案吗？我建议按以下顺序进行：

1. **先实施阶段 1**：创建共享基础层和本地化
2. **然后阶段 2**：优化主交易系统（风险较小）
3. **最后阶段 3**：优化快速交易系统

每个阶段完成后我们都可以测试验证，确保一切正常。您觉得如何？