import '../../../../core/types/result.dart';

abstract interface class CollectRepo {
  Future<Result<void>> addCollectToken({
    required String network,
    required String address,
  });

  Future<Result<void>> deleteCollectToken({
    required String network,
    required String address,
  });

  Future<Result<void>> pinCollectToken({
    required String network,
    required String address,
  });
}
