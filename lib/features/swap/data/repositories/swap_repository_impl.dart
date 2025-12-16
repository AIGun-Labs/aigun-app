import '../../../../core/types/result.dart';
import '../../../../data/models/trade/setting/trade_custom_setting.dart';
import '../../../../enums/trade_mode.dart';
import '../../../../infrastructure/network/error/app_exception.dart';
import '../../domain/entities/quote_entity.dart';
import '../../domain/entities/swap_result_entity.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/entities/transaction_status_entity.dart';
import '../../domain/repositories/swap_repository.dart';
import '../sources/swap_local_source.dart';
import '../sources/swap_remote_source.dart';

class SwapRepositoryImpl implements SwapRepository {
  SwapRepositoryImpl(this._remoteSource, this._localSource);
  final SwapRemoteSource _remoteSource;
  final SwapLocalSource _localSource;

  @override
  Future<Result<SwapResultEntity>> executeSwap({
    required String network,
    required String fromChainId,
    required String toChainId,
    required String inputMint,
    required String outputMint,
    required String amount,
    required String walletId,
    required TradeCustomSetting options,
    required TradeMode mode,
    required int decimals,
  }) async {
    try {
      final model = await _remoteSource.swap(
        network: network,
        fromChainId: fromChainId,
        toChainId: toChainId,
        inputMint: inputMint,
        outputMint: outputMint,
        amount: amount,
        walletId: walletId,
        options: options,
        mode: mode,
        decimals: decimals,
      );
      return Result.success(model.toEntity());
    } on BusinessException catch (e) {
      return Result.be(e);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
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
  }) async {
    try {
      // Convert Map to TradeCustomSetting
      final tradeOptions = TradeCustomSetting.fromJson(options);

      final model = await _remoteSource.getQuote(
        network: network,
        fromChainId: fromChainId,
        toChainId: toChainId,
        inputMint: inputMint,
        outputMint: outputMint,
        amount: amount,
        options: tradeOptions,
        mode: mode,
        decimals: decimals,
      );
      return Result.success(model.toEntity());
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<TransactionStatusEntity>> getTransactionStatus({
    required String txHash,
    required String chainId,
    required String network,
  }) async {
    try {
      final model = await _remoteSource.getTransactionStatus(
        txHash: txHash,
        chainId: chainId,
        network: network,
      );
      return Result.success(model.toEntity());
    } on BusinessException catch (e) {
      return Result.be(e);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<({TransactionEntity from, TransactionEntity to})>
  getSelectedTokens() async {
    final cached = await _localSource.getSelectedTokens();

    return (
      from: cached.from ?? TransactionEntity.defaultSol,
      to: cached.to ?? TransactionEntity.defaultUsdc,
    );
  }

  @override
  Future<void> saveFromToken(TransactionEntity token) =>
      _localSource.saveFromToken(token);

  @override
  Future<void> saveSelectedTokens({
    required TransactionEntity from,
    required TransactionEntity to,
  }) => _localSource.saveSelectedTokens(fromToken: from, toToken: to);

  @override
  Future<void> saveToToken(TransactionEntity token) =>
      _localSource.saveToToken(token);
}
