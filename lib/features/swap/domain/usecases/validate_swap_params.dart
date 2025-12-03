import '../../../../core/types/result.dart';
import '../../../../utils/extensions/string.dart';
import '../../../../utils/validators/trade_validator.dart';
import '../entities/transaction_entity.dart';

/// 验证 Swap 参数的 Use Case
///
/// 用于在执行 swap 或获取报价前验证参数的有效性
class ValidateSwapParams {
  /// 验证 swap 参数
  ///
  /// 返回 [Result.success] 如果参数有效
  /// 返回 [Result.failure] 如果参数无效，包含错误信息
  Result<void> call({
    required TransactionEntity? fromToken,
    required TransactionEntity? toToken,
    required String amount,
    required double? fromBalance,
  }) {
    // 验证 chainId 是否为空
    if (TradeValidator.isChainIdEmpty(
      fromToken?.chainId ?? '',
      toToken?.chainId ?? '',
    )) {
      return const Result.failure('Invalid chain ID');
    }

    // 验证是否是同一个 token
    if (TradeValidator.equalsToken(
      fromToken?.uniqueId ?? '',
      toToken?.uniqueId ?? '',
      fromToken?.address ?? '',
      toToken?.address ?? '',
    )) {
      return const Result.failure('Cannot swap same token');
    }

    // 验证金额是否有效
    if (amount.isEmpty || !amount.isNotEmptyAndZeroValue) {
      return const Result.failure('Invalid amount');
    }

    // 验证余额是否足够
    if (fromBalance == null || fromBalance <= 0) {
      return const Result.failure('Insufficient balance');
    }

    // 验证金额是否超过余额
    final amountValue = double.tryParse(amount) ?? 0;
    if (amountValue > fromBalance) {
      return const Result.failure('Amount exceeds balance');
    }

    return const Result.success(null);
  }

  /// 仅验证询价所需的参数（不检查余额）
  Result<void> callForQuote({
    required TransactionEntity? fromToken,
    required TransactionEntity? toToken,
    required String amount,
  }) {
    // 验证 uniqueId 是否为空
    if (TradeValidator.isChainIdEmpty(
      fromToken?.uniqueId ?? '',
      toToken?.uniqueId ?? '',
    )) {
      return const Result.failure('Invalid token ID');
    }

    // 验证是否是同一个 token
    if (TradeValidator.equalsToken(
      fromToken?.uniqueId ?? '',
      toToken?.uniqueId ?? '',
      fromToken?.address ?? '',
      toToken?.address ?? '',
    )) {
      return const Result.failure('Cannot swap same token');
    }

    // 验证金额是否有效
    if (amount.isEmpty || !amount.isNotEmptyAndZeroValue) {
      return const Result.failure('Invalid amount');
    }

    return const Result.success(null);
  }
}
