import '../../../../core/types/result.dart';
import '../../../../utils/extensions/string.dart';
import '../../../../utils/validators/trade_validator.dart';
import '../entities/transaction_entity.dart';

///
class ValidateSwapParams {
  ///
  Result<void> call({
    required TransactionEntity? fromToken,
    required TransactionEntity? toToken,
    required String amount,
    required double? fromBalance,
  }) {
    if (TradeValidator.isChainIdEmpty(
      fromToken?.chainId ?? '',
      toToken?.chainId ?? '',
    )) {
      return const Result.failure('Invalid chain ID');
    }
    if (TradeValidator.equalsToken(
      fromToken?.uniqueId ?? '',
      toToken?.uniqueId ?? '',
      fromToken?.address ?? '',
      toToken?.address ?? '',
    )) {
      return const Result.failure('Cannot swap same token');
    }
    if (amount.isEmpty || !amount.isNotEmptyAndZeroValue) {
      return const Result.failure('Invalid amount');
    }
    if (fromBalance == null || fromBalance <= 0) {
      return const Result.failure('Insufficient balance');
    }
    final amountValue = double.tryParse(amount) ?? 0;
    if (amountValue > fromBalance) {
      return const Result.failure('Amount exceeds balance');
    }

    return const Result.success(null);
  }

  Result<void> callForQuote({
    required TransactionEntity? fromToken,
    required TransactionEntity? toToken,
    required String amount,
  }) {
    if (TradeValidator.isChainIdEmpty(
      fromToken?.uniqueId ?? '',
      toToken?.uniqueId ?? '',
    )) {
      return const Result.failure('Invalid token ID');
    }
    if (TradeValidator.equalsToken(
      fromToken?.uniqueId ?? '',
      toToken?.uniqueId ?? '',
      fromToken?.address ?? '',
      toToken?.address ?? '',
    )) {
      return const Result.failure('Cannot swap same token');
    }
    if (amount.isEmpty || !amount.isNotEmptyAndZeroValue) {
      return const Result.failure('Invalid amount');
    }

    return const Result.success(null);
  }
}
