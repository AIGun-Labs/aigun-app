import '../../../../core/types/result.dart';
import '../../data/models/realtime_request_model.dart';
import '../entities/realtime_entity.dart';
import '../entities/top_token_entity.dart';

abstract interface class TopTokenRepo {
  Future<Result<List<TopTokenEntity>>> fetchTopTokens(String? lastTime);

  Future<Result<List<RealtimeEntity>>> fetchTopTokenRealtime(
    List<RealtimeRequestModel> data,
  );
}
