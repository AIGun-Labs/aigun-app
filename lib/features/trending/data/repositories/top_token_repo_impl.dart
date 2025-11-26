import '../../../../core/types/result.dart';
import '../../domain/entities/top_token_entity.dart';
import '../../domain/repositories/top_token_repo.dart';
import '../mappers/top_token_mapper.dart';
import '../sources/top_token_romote_source.dart';

class TopTokenRepoImpl implements TopTokenRepo {
  final TopTokenRemoteSource _remoteSource;

  TopTokenRepoImpl(this._remoteSource);

  @override
  Future<Result<List<TopTokenEntity>>> fetchTopTokens(String? lastTime) async {
    try {
      final data = await _remoteSource.fetchTopTokens(lastTime);
      return Result.success(data.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
