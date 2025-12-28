import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/constants.dart';
import '../../core/service_locator.dart';
import '../../cubits/quick_trade/quick_trade_cubit.dart';
import '../../cubits/quick_trade/quick_trade_state.dart';
import '../../cubits/sound_effect/sound_effect_cubit.dart';
import '../../cubits/trade_setting/trade_setting_cubit.dart';
import '../../features/swap/presentation/cubit/swap/swap_cubit.dart';
import '../../features/swap/presentation/cubit/swap/swap_state.dart';
import '../../features/swap/presentation/widgets/swap.dart';
import '../../features/swap/presentation/widgets/swap_converters.dart';
import '../../l10n/l10n.dart';
import '../../utils/sheet/sheet.dart';
import '../../widgets/sheet/common.dart';
import '../../widgets/token/models/token.dart';
import '../presentation/cubits/new_user/new_user_cubit.dart';

class TokenPurchaseService {
  static Future<void> handlePurchase({
    required BuildContext context,
    required Token token,
    required QuickTradeMode mode,
    bool playSound = true,
  }) async {
    final isLoggedIn = BlocProvider.of<NewUserCubit>(
      context,
    ).state.isAuthenticated;

    if (!isLoggedIn) {
      context.pushNamed(RouteNames.login);
      return;
    }

    if (playSound) {
      context.read<SoundEffectCubit>().playGunLoad();
    }

    context.read<QuickTradeCubit>().updateMode(mode);
    //  Update network for trade setting
    context.read<TradeSettingCubit>().updateNetwork(token.network ?? '');
    if (token.isNativeToken) {
      _handleNativeTokenPurchase(context, token, mode);
    } else {
      _handleNonNativeTokenPurchase(context, token);
    }
  }

  static void _handleNativeTokenPurchase(
    BuildContext context,
    Token token,
    QuickTradeMode mode,
  ) {
    final swapCubit = context.read<SwapCubit>();
    swapCubit.clear();
    if (_isSolToken(token)) {
      // swapCubit.updateFromToken(defaultBNBTradeToken);
      // swapCubit.updateToToken(defaultFormTradeToken);
      _configureSolanaTokenSwap(swapCubit, mode);
    } else {
      // swapCubit.updateFromToken(defaultFormTradeToken);
      // swapCubit.updateToToken(token.toTransactionEntity());
      _configureNonSolanaTokenSwap(swapCubit, token, mode);
    }
    ShowSheet.common(
      context,
      CommonSheet(
        top: 16.w,
        left: 0,
        right: 0,
        child: SwapWidget(buyToken: true),
      ),
    );
  }

  static void _configureSolanaTokenSwap(
    SwapCubit swapCubit,
    QuickTradeMode mode,
  ) {
    if (mode == QuickTradeMode.buy) {
      swapCubit.setTokenPair(
        fromToken: defaultBNBTradeToken,
        toToken: defaultFormTradeToken,
      );
    } else {
      swapCubit.setTokenPair(
        fromToken: defaultFormTradeToken,
        toToken: defaultBNBTradeToken,
      );
    }
  }

  static void _configureNonSolanaTokenSwap(
    SwapCubit swapCubit,
    Token token,
    QuickTradeMode mode,
  ) {
    if (mode == QuickTradeMode.buy) {
      swapCubit.setTokenPair(
        fromToken: defaultFormTradeToken,
        toToken: token.toTransactionEntity(),
      );
    } else {
      swapCubit.setTokenPair(
        fromToken: token.toTransactionEntity(),
        toToken: defaultFormTradeToken,
      );
    }
  }

  static void _handleNonNativeTokenPurchase(BuildContext context, Token token) {
    ShowSheet.trade(context);
    getIt<QuickTradeCubit>().updateSelectedToken(token);
  }

  static bool _isSolToken(Token token) {
    return token.network?.toLowerCase() == 'solana';
  }

  static Token filterToken(List<Token> token, String network, String address) {
    return token.firstWhere(
      (element) =>
          element.address == address &&
          element.network?.toLowerCase() == network.toLowerCase(),
    );
  }

  static List<Token> excludeToken(
    List<Token> tokens,
    String network,
    String address,
  ) {
    return tokens
        .where(
          (element) =>
              !(element.address == address &&
                  element.network?.toLowerCase() == network.toLowerCase()),
        )
        .toList();
  }

  static List<Token> filterTokensWithBalance(List<Token> tokens) {
    return tokens.where((token) {
      final balance = double.tryParse(token.balance);
      return balance != null && balance > 0;
    }).toList();
  }

  static QuickTradeMode getTradeModeFromScore(double score, {String? action}) {
    if (score > 0) {
      return QuickTradeMode.buy;
    } else {
      return QuickTradeMode.sell;
    }
  }

  static QuickTradeMode getTradeModeFromAction(String action) {
    if (action.isEmpty) {
      return QuickTradeMode.buy;
    }
    return action.contains('long') ? QuickTradeMode.buy : QuickTradeMode.sell;
  }

  static List<QuickTradeMode> getTradeModesFromAction(String action) {
    final modes = <QuickTradeMode>[];

    if (action.isEmpty) {
      modes.add(QuickTradeMode.buy);
      modes.add(QuickTradeMode.sell);
    }
    if (action.contains('long')) {
      modes.add(QuickTradeMode.buy);
    }
    if (action.contains('short')) {
      modes.add(QuickTradeMode.sell);
    }
    return modes;
  }

  static String getTradeTextFromMode(
    BuildContext context,
    QuickTradeMode mode,
  ) {
    if (mode == QuickTradeMode.buy) {
      return S.of(context).buyIn;
    } else {
      return S.of(context).sellOut;
    }
  }

  static bool calculateFinalBalance({
    String? currentBalanceStr,
    required String sellAmountStr,
    String? tipFee = '0',
    String? gasFee = '0',
    String? priorityFee = '0',
  }) {
    final balance = double.tryParse(currentBalanceStr ?? '0') ?? 0.0;
    final sellAmount = double.tryParse(sellAmountStr) ?? 0.0;
    final totalFeeInToken =
        (double.tryParse(tipFee ?? '0') ?? 0) +
        (double.tryParse(gasFee ?? '0') ?? 0) +
        (double.tryParse(priorityFee ?? '0') ?? 0);
    final remain = balance - sellAmount - totalFeeInToken;
    final safeRemain = remain.isFinite ? (remain < 0 ? 0.0 : remain) : 0.0;
    return safeRemain > 0;
  }

  static String calculateRemainingBalance({
    String? currentBalanceStr,
    // required String sellAmountStr,
    String? tipFee = '0',
    String? gasFee = '0',
    String? priorityFee = '0',
  }) {
    final balance = double.tryParse(currentBalanceStr ?? '0') ?? 0.0;
    // final sellAmount = double.tryParse(sellAmountStr) ?? 0.0;
    final totalFeeInToken =
        (double.tryParse(tipFee ?? '0') ?? 0) +
        (double.tryParse(gasFee ?? '0') ?? 0) +
        (double.tryParse(priorityFee ?? '0') ?? 0);
    final remain = balance - totalFeeInToken;
    final safeRemain = remain.isFinite ? (remain < 0 ? 0.0 : remain) : 0.0;
    return safeRemain.toString();
  }

  static double feeUsdToTokenUnits({
    required double feeUsd,
    required Token token,
  }) {
    final price = double.tryParse(token.tokenPrice) ?? 0.0;
    if (price <= 0) return 0.0;
    return feeUsd / price;
  }
}
