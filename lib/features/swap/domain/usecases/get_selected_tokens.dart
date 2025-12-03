import '../entities/transaction_entity.dart';
import '../repositories/swap_repository.dart';

class GetSelectedTokens {
  final SwapRepository _swapRepository;

  GetSelectedTokens(this._swapRepository);

  Future<({TransactionEntity from, TransactionEntity to})> call() async {
    final cached = await _swapRepository.getSelectedTokens();
    return (from: cached.from, to: cached.to);
  }
}
