import '../../domain/entities/top_token_entity.dart';
import '../../domain/repositories/top_token_repository.dart';
import '../mappers/top_token_mapper.dart';
import '../sources/top_token_romote_source.dart';

class TopTokenRepositoryImpl implements TopTokenRepository {
  final TopTokenRemoteSource _remoteSource;

  TopTokenRepositoryImpl(this._remoteSource);

  @override
  Future<List<TopTokenEntity>> fetchTopTokens(String? network) async {
    final data = await _remoteSource.fetchTopTokens(network);
    return data.map((e) => e.toEntity()).toList();
  }
}
