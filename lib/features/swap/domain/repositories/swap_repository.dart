import '../../../../core/types/result.dart';
import '../../../../data/models/trade/setting/trade_custom_setting.dart';
import '../../../../enums/trade_mode.dart';
import '../entities/quote_entity.dart';
import '../entities/swap_result_entity.dart';
import '../entities/transaction_entity.dart';
import '../entities/transaction_status_entity.dart';

abstract class SwapRepository {
  Future<Result<SwapResultEntity>> executeSwap({
    required String network,
    required String fromChainId,
    required String toChainId,
    required String inputMint,
    required String outputMint,
    required String amount,
    // required int slippage,
    // required String priorityFee,
    required String walletId,
    required TradeCustomSetting options,
    required TradeMode mode,
    required int decimals,
  });
  Future<Result<QuoteEntity>> getQuote({
    required String network,
    required String fromChainId,
    required String toChainId,
    required String inputMint,
    required String outputMint,
    required String amount,
    required Map<String, dynamic> options,
    required String mode,
    required int decimals,
  });
  Future<Result<TransactionStatusEntity>> getTransactionStatus({
    required String txHash,
    required String chainId,
    required String network,
  });
  Future<({TransactionEntity from, TransactionEntity to})> getSelectedTokens();

  Future<void> saveFromToken(TransactionEntity token);

  Future<void> saveToToken(TransactionEntity token);

  Future<void> saveSelectedTokens({
    required TransactionEntity from,
    required TransactionEntity to,
  });
}
