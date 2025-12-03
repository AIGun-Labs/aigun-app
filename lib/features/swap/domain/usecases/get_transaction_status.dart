import '../../../../core/types/result.dart';
import '../entities/transaction_status_entity.dart';
import '../repositories/swap_repository.dart';

class GetTransactionStatus {
  final SwapRepository _repository;

  GetTransactionStatus(this._repository);

  Future<Result<TransactionStatusEntity>> call({
    required String txHash,
    required String chainId,
    required String network,
  }) {
    return _repository.getTransactionStatus(
      txHash: txHash,
      chainId: chainId,
      network: network,
    );
  }
}
