import '../entities/transaction_entity.dart';
import '../repositories/swap_repository.dart';

class SaveToToken {
  final SwapRepository _swapRepository;

  SaveToToken(this._swapRepository);

  Future<void> call(TransactionEntity token) =>
      _swapRepository.saveToToken(token);
}
