import 'package:aigun_app/enums/quick_trade_mode.dart';
import 'package:flutter/cupertino.dart';

import '../../l10n/l10n.dart';
import '../../widgets/token/models/token.dart';

class TokenPurchaseService {
  static Future<void> handlePurchase({
    required BuildContext context,
    required Token token,
    required QuickTradeMode mode,
    bool playSound = true,
  }) async {}

  static void _handleNativeTokenPurchase(
    BuildContext context,
    Token token,
  ) async {}

  static void _handleNonNativeTokenPurchase(
    BuildContext context,
    Token token,
  ) {}

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

  static QuickTradeMode getTradeModeFromScore(double score) {
    if (score > 0) {
      return QuickTradeMode.buy;
    } else {
      return QuickTradeMode.sell;
    }
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
