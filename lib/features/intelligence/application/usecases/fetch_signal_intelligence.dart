import '../../../../core/types/result.dart';
import '../../domain/entities/intelligence_entity.dart';
import '../../domain/repositories/intelligence_repository.dart';

/// Fetch Signal Intelligence Use Case
///
/// Fetches radar signal intelligence filtered by chain ID
/// with pagination support.
class FetchSignalIntelligence {
  final IntelligenceRepository _repository;

  FetchSignalIntelligence(this._repository);

  /// Execute the use case
  ///
  /// [chainId] - Chain ID to filter (e.g., 'all', 'solana', 'ethereum')
  /// [page] - Page number (starts from 1)
  /// [pageSize] - Number of items per page (default: 10)
  Future<Result<List<IntelligenceEntity>>> call({
    required String chainId,
    int? page,
    int? pageSize,
  }) {
    return _repository.getSignalIntelligence(
      chainId: chainId,
      page: page,
      pageSize: pageSize,
    );
  }
}
