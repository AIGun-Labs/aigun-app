import '../../../../core/types/result.dart';
import '../../../../data/services/sentry_service.dart';
import '../../../../utils/logger.dart';
import '../../domain/entities/intelligence_entity.dart';
import '../../domain/entities/token_entity.dart';
import '../../domain/repositories/intelligence_repository.dart';
import '../mappers/intelligence_mapper.dart';
import '../datasources/intelligence_realtime_source.dart';
import '../datasources/intelligence_remote_source.dart';

/// Intelligence Repository Implementation
///
/// Implements the IntelligenceRepository interface by coordinating
/// between remote and realtime data sources.
class IntelligenceRepositoryImpl implements IntelligenceRepository {
  final IntelligenceRemoteSource _remoteSource;
  final IntelligenceRealtimeSource _realtimeSource;

  IntelligenceRepositoryImpl(
    this._remoteSource,
    this._realtimeSource,
  );

  // ==================== HTTP API Methods ====================

  @override
  Future<Result<List<IntelligenceEntity>>> getEventIntelligence({
    int? page,
    int? pageSize,
  }) async {
    try {
      final models = await _remoteSource.fetchEventIntelligence(
        page: page,
        pageSize: pageSize,
      );

      final entities = models.map((m) => m.toEntity()).toList();
      return Result.success(entities);
    } catch (e, s) {
      Logger.error('IntelligenceRepository: getEventIntelligence error: $e');
      await SentryService().reportError(
        e,
        s,
        tags: {'feature': 'intelligence_event'},
      );
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<List<IntelligenceEntity>>> getSignalIntelligence({
    required String chainId,
    int? page,
    int? pageSize,
  }) async {
    try {
      final models = await _remoteSource.fetchSignalIntelligence(
        chainId: chainId,
        page: page,
        pageSize: pageSize,
      );

      final entities = models.map((m) => m.toEntity()).toList();
      return Result.success(entities);
    } catch (e, s) {
      Logger.error('IntelligenceRepository: getSignalIntelligence error: $e');
      await SentryService().reportError(
        e,
        s,
        tags: {'feature': 'intelligence_signal'},
      );
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<Map<String, List<TokenEntity>>>> getTokensByIntelligenceIds(
    List<String> intelligenceIds,
  ) async {
    if (intelligenceIds.isEmpty) {
      return const Result.success({});
    }

    try {
      final modelsMap =
          await _remoteSource.fetchTokensByIntelligenceIds(intelligenceIds);

      final entitiesMap = <String, List<TokenEntity>>{};
      for (final entry in modelsMap.entries) {
        entitiesMap[entry.key] =
            entry.value.map((m) => m.toEntity()).toList();
      }

      return Result.success(entitiesMap);
    } catch (e, s) {
      Logger.error('IntelligenceRepository: getTokensByIntelligenceIds error: $e');
      await SentryService().reportError(
        e,
        s,
        tags: {'feature': 'intelligence_tokens'},
      );
      return Result.failure(e.toString());
    }
  }

  // ==================== WebSocket/Realtime Methods ====================

  @override
  Stream<IntelligenceEntity> subscribeRealtimeIntelligence() {
    return _realtimeSource.intelligenceStream.map((model) => model.toEntity());
  }

  @override
  Stream<RealtimeConnectionStatus> get connectionStatusStream {
    return _realtimeSource.statusStream;
  }

  @override
  RealtimeConnectionStatus get currentConnectionStatus {
    return _realtimeSource.currentStatus;
  }

  @override
  Future<void> connectRealtime() async {
    await _realtimeSource.connect();
  }

  @override
  Future<void> disconnectRealtime() async {
    await _realtimeSource.disconnect();
  }

  @override
  void subscribeAgent(String agentId) {
    _realtimeSource.subscribe(agentId);
  }

  @override
  void unsubscribeAgent(String agentId) {
    _realtimeSource.unsubscribe(agentId);
  }

  @override
  void subscribeAgents(List<String> agentIds) {
    _realtimeSource.subscribeAll(agentIds);
  }
}
