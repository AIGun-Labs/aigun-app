import '../entities/top_token_entity.dart';

abstract class TopTokenRepository {
  Future<List<TopTokenEntity>> fetchTopTokens(String? network);
}
