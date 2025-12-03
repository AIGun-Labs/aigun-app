import '../entities/transaction_entity.dart';
import '../repositories/swap_repository.dart';

class SaveFromToken {
  final SwapRepository repository;

  SaveFromToken(this.repository);

  Future<void> call(TransactionEntity token) => repository.saveFromToken(token);
}
