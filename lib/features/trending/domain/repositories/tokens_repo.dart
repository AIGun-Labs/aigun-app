import '../../../../core/types/result.dart';
import '../../../../shared/domain/entities/base_token_entity.dart';

abstract interface class TokensRepo {
  Future<Result<List<BaseTokenEntity>>> fetchTokens({
    Map<String, dynamic>? queryParameters,
  });

  Future<Result<List<BaseTokenEntity>>> fetchCollectedTokensByWalletId({
    required String walletId,
  });
}
