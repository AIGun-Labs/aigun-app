import '../entities/transaction_entity.dart';
import '../repositories/swap_repository.dart';

class SaveSelectedTokens {
  final SwapRepository _swapRepository;

  SaveSelectedTokens(this._swapRepository);

  Future<void> call({
    required TransactionEntity from,
    required TransactionEntity to,
  }) => _swapRepository.saveSelectedTokens(from: from, to: to);
}
