import '../../../../core/types/result.dart';
import '../../../../shared/domain/entities/base_token_entity.dart';
import '../repositories/tokens_repo.dart';

class FetchRealtimeUsecase {
  final TokensRepo _repo;

  FetchRealtimeUsecase(this._repo);

  Future<Result<List<BaseTokenEntity>>> call({
    required List<BaseTokenEntity> body,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _repo.fetchRealtimeTokens(
      body: body,
      queryParameters: queryParameters,
    );
  }
}
