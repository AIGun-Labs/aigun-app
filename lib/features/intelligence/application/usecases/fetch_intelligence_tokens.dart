import '../../../../core/types/result.dart';
import '../../domain/entities/token_entity.dart';
import '../../domain/repositories/intelligence_repository.dart';

/// Fetch Intelligence Tokens Use Case
///
/// Fetches token data for a list of intelligence IDs.
/// Used for updating token prices in intelligence items.
class FetchIntelligenceTokens {
  final IntelligenceRepository _repository;

  FetchIntelligenceTokens(this._repository);

  /// Execute the use case
  ///
  /// [intelligenceIds] - List of intelligence IDs to fetch tokens for
  /// Returns a map of intelligence ID to list of tokens
  Future<Result<Map<String, List<TokenEntity>>>> call(
    List<String> intelligenceIds,
  ) {
    if (intelligenceIds.isEmpty) {
      return Future.value(const Result.success({}));
    }
    return _repository.getTokensByIntelligenceIds(intelligenceIds);
  }
}
