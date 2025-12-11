import '../../../../core/types/result.dart';
import '../../../../shared/data/mappers/trade_token_mapper.dart';
import '../../../../shared/domain/entities/base_token_entity.dart';
import '../../domain/repositories/tokens_repo.dart';
import '../models/realtime_request_model.dart';
import '../sources/tokens_remote_source.dart';

class TokensRepoImpl implements TokensRepo {
  final TokensRemoteSource _remoteSource;

  TokensRepoImpl(this._remoteSource);

  @override
  Future<Result<List<BaseTokenEntity>>> fetchCollectedTokensByWalletId({
    required String walletId,
  }) async {
    try {
      final data = await _remoteSource.fetchCollectedTokensByWalletId(
        walletId: walletId,
      );
      return Result.success(data.map((e) => e.toBaseTokenEntity()).toList());
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<List<BaseTokenEntity>>> fetchTokens({
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final data = await _remoteSource.fetchTokens(
        queryParameters: queryParameters,
      );
      return Result.success(data.map((e) => e.toBaseTokenEntity()).toList());
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<List<BaseTokenEntity>>> fetchRealtimeTokens({
    required List<RealtimeRequestModel> body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final data = await _remoteSource.fetchTokensRealtime(
        data: body,
        queryParameters: queryParameters,
      );
      return Result.success(data.map((e) => e.toBaseTokenEntity()).toList());
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
