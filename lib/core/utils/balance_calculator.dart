import 'package:decimal/decimal.dart';

import '../../cubits/balance/balance_cubit.dart';
import '../../data/models/wallet/token/token.dart';
import 'calculator.dart';

class BalanceCalculator {
  BalanceCalculator(this._balanceCubit);
  final BalanceCubit _balanceCubit;

  static bool balanceIsEnough({
    required String amount,
    required dynamic decimal,
    required dynamic fee,
  }) {
    final balance = Calculator.toAtomicUnits(amount, decimal);
    final remainingBalance = Calculator.subtractTwo(balance, fee);
    return Calculator.greaterThan(remainingBalance, Decimal.zero);
  }

  static Token? getBalanceFromList({
    required String address,
    required String network,
    required List<Token>? balances,
  }) {
    return balances
        ?.where(
          (token) => token.tokenAddress == address && token.network == network,
        )
        .firstOrNull;
  }

  static String? getBalance() {
    return null;
  }
}
