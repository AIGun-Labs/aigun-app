import '../../domain/repositories/chain_repository.dart';
import '../../domain/value_objects/network.dart';

class ChainRepositoryImpl implements ChainRepository {
  @override
  Future<List<ChainNetwork>> getSupportedChains() {
    throw UnimplementedError();
  }
}
