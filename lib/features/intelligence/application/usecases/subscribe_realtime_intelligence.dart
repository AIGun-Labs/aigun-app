import '../../domain/entities/intelligence_entity.dart';
import '../../domain/repositories/intelligence_repository.dart';

/// Subscribe Realtime Intelligence Use Case
///
/// Provides a stream of realtime intelligence updates
/// via WebSocket connection.
class SubscribeRealtimeIntelligence {
  final IntelligenceRepository _repository;

  SubscribeRealtimeIntelligence(this._repository);

  /// Execute the use case
  ///
  /// Returns a stream of intelligence entities as they arrive
  Stream<IntelligenceEntity> call() {
    return _repository.subscribeRealtimeIntelligence();
  }
}
