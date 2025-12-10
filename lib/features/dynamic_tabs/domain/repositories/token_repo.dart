import '../../../../core/types/result.dart';
import '../../../../shared/domain/entities/base_token_entity.dart';

abstract interface class TokenRepo {
  Future<Result<List<BaseTokenEntity>>> fetchTokens({
    required String apiUrl,
    String? lastTime,
  });
}
