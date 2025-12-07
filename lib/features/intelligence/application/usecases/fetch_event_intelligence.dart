import '../../../../core/types/result.dart';
import '../../domain/entities/intelligence_entity.dart';
import '../../domain/repositories/intelligence_repository.dart';

/// Fetch Event Intelligence Use Case
///
/// Fetches event-type intelligence (event, twitter, telegram, news)
/// with pagination support.
class FetchEventIntelligence {
  final IntelligenceRepository _repository;

  FetchEventIntelligence(this._repository);

  /// Execute the use case
  ///
  /// [page] - Page number (starts from 1)
  /// [pageSize] - Number of items per page (default: 10)
  Future<Result<List<IntelligenceEntity>>> call({
    int? page,
    int? pageSize,
  }) {
    return _repository.getEventIntelligence(
      page: page,
      pageSize: pageSize,
    );
  }
}
