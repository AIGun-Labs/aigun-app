import '../../../../core/types/result.dart';
import '../../data/models/realtime_request_model.dart';
import '../entities/realtime_entity.dart';
import '../repositories/top_token_repo.dart';

class FetchRealtimeUsecase {
  final TopTokenRepo _repo;

  FetchRealtimeUsecase(this._repo);

  Future<Result<List<RealtimeEntity>>> call(
    List<RealtimeRequestModel> data,
  ) async {
    return await _repo.fetchTopTokenRealtime(data);
  }
}
