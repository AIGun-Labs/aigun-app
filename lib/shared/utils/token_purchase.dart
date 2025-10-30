import 'package:flutter/cupertino.dart';
import 'package:flutter_aigun/core/router/constants.dart';
import 'package:flutter_aigun/core/service_locator.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/cubits/sound_effect/sound_effect_cubit.dart';
import 'package:flutter_aigun/cubits/trade/trade_state.dart';
import 'package:flutter_aigun/utils/sheet/sheet.dart';
import 'package:flutter_aigun/widgets/sheet/common.dart';
import 'package:flutter_aigun/widgets/swap/widgets/swap.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
}
