import '../../../../core/types/result.dart';
import '../../domain/entities/realtime_entity.dart';
import '../../domain/entities/top_token_entity.dart';
import '../../domain/repositories/top_token_repo.dart';
import '../mappers/realtime_mapper.dart';
import '../mappers/top_token_mapper.dart';
import '../models/realtime_request_model.dart';
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

  @override
  Future<Result<List<RealtimeEntity>>> fetchTopTokenRealtime(
    List<RealtimeRequestModel> data,
  ) async {
    try {
      final result = await _remoteSource.fetchTopTokenRealtime(data);
      return Result.success(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
