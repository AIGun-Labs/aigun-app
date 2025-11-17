import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/router/constants.dart';
import '../../core/service_locator.dart';
import '../../cubits/index.dart';
import '../../cubits/sound_effect/sound_effect_cubit.dart';
import '../../cubits/trade/trade_state.dart';
import '../../l10n/l10n.dart';
import '../../utils/sheet/sheet.dart';
import '../../widgets/sheet/common.dart';
import '../../widgets/swap/widgets/swap.dart';
import '../../widgets/token/models/token.dart';

class TokenPurchaseService {
  static Future<void> handlePurchase({
    required BuildContext context,
    required Token token,
    required QuickTradeMode mode,
    bool playSound = true,
  }) async {
    final isLoggedIn = getIt<UserCubit>().state.isLoggedIn;

    if (!isLoggedIn) {
      context.pushNamed(RouteNames.login);
      return;
    }

    if (playSound) {
      context.read<SoundEffectCubit>().playGunLoad();
    }

    context.read<QuickTradeCubit>().updateMode(mode);
    //  Update network for trade setting
    await context.read<TradeSettingCubit>().updateNetwork(token.network ?? '');
    if (token.isNativeToken) {
      await _handleNativeTokenPurchase(context, token);
    } else {
      await _handleNonNativeTokenPurchase(context, token);
    }
  }

  static Future<void> _handleNativeTokenPurchase(
    BuildContext context,
    Token token,
  ) async {
    ShowSheet.common(
        context,
        CommonSheet(
            padding: EdgeInsets.only(top: 16.h),
            child: const TradeSwap(
              buyToken: true,
            )));

    if (_isSolToken(token)) {
      getIt<TradeCubit>().updateFromToken(defaultBNBTradeToken);
      getIt<TradeCubit>().updateToToken(defaultFormTradeToken);
    } else {
      getIt<TradeCubit>().updateFromToken(defaultFormTradeToken);
      getIt<TradeCubit>().updateToToken(TradeToken.fromToken(token));
    }
  }

  static Future<void> _handleNonNativeTokenPurchase(
    BuildContext context,
    Token token,
  ) async {
    ShowSheet.trade(context);
    getIt<QuickTradeCubit>().updateSelectedToken(token);
  }

  static bool _isSolToken(Token token) {
    return token.network?.toLowerCase() == "solana";
  }

  static Token filterToken(List<Token> token, String network, String address) {
    return token.firstWhere((element) =>
        element.address == address &&
        element.network?.toLowerCase() == network.toLowerCase());
  }

  /// 从 tokens 列表中排除掉指定的 token（通过 network 和 address 匹配）
  static List<Token> excludeToken(
      List<Token> tokens, String network, String address) {
    return tokens
        .where((element) => !(element.address == address &&
            element.network?.toLowerCase() == network.toLowerCase()))
        .toList();
  }

  /// 过滤掉 balance 为 0 或 null 的代币
  static List<Token> filterTokensWithBalance(List<Token> tokens) {
    return tokens.where((token) {
      final balance = double.tryParse(token.balance);
      return balance != null && balance > 0;
    }).toList();
  }

  static QuickTradeMode getTradeModeFromScore(double score) {
    if (score > 0) {
      return QuickTradeMode.buy;
    } else {
      return QuickTradeMode.sell;
    }
  }

  static String getTradeTextFromMode(
      BuildContext context, QuickTradeMode mode) {
    if (mode == QuickTradeMode.buy) {
      return S.of(context).buyIn;
    } else {
      return S.of(context).sellOut;
    }
  }

  static bool calculateFinalBalance({
    String? currentBalanceStr,
    // 计划卖出的代币数量（字符串形式，便于直接对接输入框）
    required String sellAmountStr,
    // 费用均以“代币数量”为单位传入；如果你的费用以 USD 或原生币计价，请先换算
    String? tipFee = "0",
    String? gasFee = "0",
    String? priorityFee = "0",
  }) {
    final balance = double.tryParse(currentBalanceStr ?? "0") ?? 0.0;
    final sellAmount = double.tryParse(sellAmountStr) ?? 0.0;

    // 合计需要从代币余额中扣减的费用（以代币单位计）
    final totalFeeInToken = (double.tryParse(tipFee ?? "0") ?? 0) +
        (double.tryParse(gasFee ?? "0") ?? 0) +
        (double.tryParse(priorityFee ?? "0") ?? 0);

    // 计算剩余余额，避免出现负数
    final remain = balance - sellAmount - totalFeeInToken;
    final safeRemain = remain.isFinite ? (remain < 0 ? 0.0 : remain) : 0.0;

    // 为了避免过长小数，这里限制展示小数位不超过 8 位
    return safeRemain > 0;
  }

  /// 计算扣除卖出金额和各项费用后的剩余余额
  /// 返回剩余余额的字符串形式，保持精度
  static String calculateRemainingBalance({
    String? currentBalanceStr,
    // 计划卖出的代币数量
    required String sellAmountStr,
    // 费用均以"代币数量"为单位传入
    String? tipFee = "0",
    String? gasFee = "0",
    String? priorityFee = "0",
  }) {
    final balance = double.tryParse(currentBalanceStr ?? "0") ?? 0.0;
    final sellAmount = double.tryParse(sellAmountStr) ?? 0.0;

    // 合计需要从代币余额中扣减的费用（以代币单位计）
    final totalFeeInToken = (double.tryParse(tipFee ?? "0") ?? 0) +
        (double.tryParse(gasFee ?? "0") ?? 0) +
        (double.tryParse(priorityFee ?? "0") ?? 0);

    // 计算剩余余额
    final remain = balance - sellAmount - totalFeeInToken;

    // 处理异常情况：负数或非有限值
    final safeRemain = remain.isFinite ? (remain < 0 ? 0.0 : remain) : 0.0;

    // 返回字符串形式，保持精度
    return safeRemain.toString();
  }

  /// 若你的贿赂费 / Gas / 优先费是以 USD 表示，可用此辅助函数先换算到代币单位
  static double feeUsdToTokenUnits({
    required double feeUsd,
    required Token token,
  }) {
    final price = double.tryParse(token.tokenPrice) ?? 0.0;
    if (price <= 0) return 0.0;
    return feeUsd / price;
  }
}
