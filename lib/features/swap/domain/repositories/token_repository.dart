import '../../../../core/types/result.dart';
import '../../../../shared/domain/entities/token_entity.dart';
import '../entities/query_token_entity.dart';

abstract class TokenRepository {
  Future<Result<List<TokenEntity>>> getNativeTokens();

  Future<Result<List<QueryTokenEntity>>> searchTokens({
    required String keyword,
    String? walletId,
  });
}
