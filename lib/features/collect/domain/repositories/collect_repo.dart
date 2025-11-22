import '../../../../core/types/result.dart';
import '../entities/collect_token_entity.dart';

abstract class CollectRepo {
  Future<Result<List<CollectTokenEntity>>> fetchCollectTokens(
      {required String walletId});

  Future<Result<void>> addCollectToken(
      {required String network, required String address});

  Future<Result<void>> deleteCollectToken(
      {required String network, required String address});

  Future<Result<void>> pinCollectToken(
      {required String network, required String address});
}
