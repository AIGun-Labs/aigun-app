import '../../../../core/types/result.dart';
import '../../domain/entities/support_chains_entity.dart';
import '../../domain/repositories/chain_repository.dart';
import '../datasources/chain_remote_data_source.dart';

class ChainRepositoryImpl implements ChainRepository {
  final ChainRemoteDataSource _remoteSource;

  ChainRepositoryImpl(this._remoteSource);

  @override
  Future<Result<SupportChainsEntity>> getSupportedChains() async {
    try {
      final result = await _remoteSource.getSupportedChains();
      return Result.success(result.toEntity());
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
