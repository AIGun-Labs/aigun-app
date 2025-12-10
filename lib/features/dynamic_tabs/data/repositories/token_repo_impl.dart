import '../../../../core/types/result.dart';
import '../../../../shared/domain/entities/base_token_entity.dart';
import '../../domain/repositories/token_repo.dart';
import '../mappers/list_token_mapper.dart';
import '../sources/list_token_remote_source.dart';

class TokenRepoImpl implements TokenRepo {
  final ListTokenRemoteSource _remoteSource;

  TokenRepoImpl(this._remoteSource);

  @override
  Future<Result<List<BaseTokenEntity>>> fetchTokens({
    required String apiUrl,
    String? lastTime,
  }) async {
    try {
      final data = await _remoteSource.fetchTokens(
        apiUrl: apiUrl,
        lastTime: lastTime,
      );
      return Result.success(data.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
