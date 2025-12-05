import '../value_objects/network.dart';

abstract class ChainRepository {
  Future<List<ChainNetwork>> getSupportedChains();
}
