import '../../../../core/types/result.dart';
import '../../domain/entities/support_chains_entity.dart';
import '../../domain/repositories/chain_repository.dart';

class GetSupportedChains {
  final ChainRepository _repository;

  GetSupportedChains(this._repository);

  Future<Result<SupportChainsEntity>> call() async {
    return _repository.getSupportedChains();
  }
}
