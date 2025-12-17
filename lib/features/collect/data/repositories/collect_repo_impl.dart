import '../../../../core/types/result.dart';
import '../../domain/repositories/collect_repo.dart';
import '../sources/collect_remote_source.dart';

class CollectRepoImpl implements CollectRepo {
  CollectRepoImpl(this._remote);
  final CollectRemoteSource _remote;

  @override
  Future<Result<void>> addCollectToken({
    required String network,
    required String address,
  }) async {
    try {
      await _remote.fetchAdd(network: network, address: address);
      return const Result.success(null);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<void>> deleteCollectToken({
    required String network,
    required String address,
  }) async {
    try {
      await _remote.fetchDelete(network: network, address: address);
      return const Result.success(null);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<void>> pinCollectToken({
    required String network,
    required String address,
  }) async {
    try {
      await _remote.fetchPin(network: network, address: address);
      return const Result.success(null);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
