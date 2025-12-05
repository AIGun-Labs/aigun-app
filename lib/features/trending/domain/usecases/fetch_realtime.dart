import '../../../../core/types/result.dart';
import '../../data/models/realtime_request_model.dart';
import '../entities/realtime_entity.dart';
import '../repositories/top_token_repo.dart';

class FetchRealtime {
  final TopTokenRepo _repo;

  FetchRealtime(this._repo);

  Future<Result<List<RealtimeEntity>>> call(
    List<RealtimeRequestModel> data,
  ) async {
    return await _repo.fetchTopTokenRealtime(data);
  }
}
