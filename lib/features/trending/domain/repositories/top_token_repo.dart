import '../../../../core/types/result.dart';
import '../entities/top_token_entity.dart';

abstract class TopTokenRepo {
  Future<Result<List<TopTokenEntity>>> fetchTopTokens(String? lastTime);
}
