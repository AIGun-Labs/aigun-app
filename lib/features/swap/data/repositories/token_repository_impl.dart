import '../../../../core/types/result.dart';
import '../../../../shared/domain/entities/base_token_entity.dart';
import '../../domain/entities/query_token_entity.dart';
import '../../domain/repositories/token_repository.dart';
import '../sources/token_remote_source.dart';

class TokenRepositoryImpl implements TokenRepository {
  final TokenRemoteSource _tokenRemoteSource;

  TokenRepositoryImpl(this._tokenRemoteSource);

  @override
  Future<Result<List<QueryTokenEntity>>> searchTokens({
    required String keyword,
    String? walletId,
  }) async {
    try {
      final result = await _tokenRemoteSource.searchTokens(keyword, walletId);
      return Result.success(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<List<BaseTokenEntity>>> getNativeTokens() async {
    try {
      final result = await _tokenRemoteSource.getNativeTokens();
      return Result.success(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
