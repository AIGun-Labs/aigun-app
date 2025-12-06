import '../../../../core/types/result.dart';
import '../entities/support_chains_entity.dart';

abstract class ChainRepository {
  Future<Result<SupportChainsEntity>> getSupportedChains();
}
