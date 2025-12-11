import '../../../../core/types/result.dart';
import '../../../../shared/domain/entities/base_token_entity.dart';
import '../../data/models/realtime_request_model.dart';

abstract interface class TokensRepo {
  Future<Result<List<BaseTokenEntity>>> fetchTokens({
    Map<String, dynamic>? queryParameters,
  });

  Future<Result<List<BaseTokenEntity>>> fetchCollectedTokensByWalletId({
    required String walletId,
  });

  Future<Result<List<BaseTokenEntity>>> fetchRealtimeTokens({
    required List<RealtimeRequestModel> body,
    Map<String, dynamic>? queryParameters,
  });
}
