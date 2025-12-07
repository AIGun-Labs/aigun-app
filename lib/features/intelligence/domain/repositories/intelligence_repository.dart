import '../../../../core/types/result.dart';
import '../entities/intelligence_entity.dart';
import '../entities/token_entity.dart';

/// Intelligence Repository Interface
///
/// Defines the contract for intelligence data operations.
/// This interface is implemented in the data layer.
abstract class IntelligenceRepository {
  // ==================== HTTP API Methods ====================

  /// Fetch event-type intelligence (event, twitter, telegram, news)
  ///
  /// [page] - Page number for pagination (starts from 1)
  /// [pageSize] - Number of items per page
  Future<Result<List<IntelligenceEntity>>> getEventIntelligence({
    int? page,
    int? pageSize,
  });

  /// Fetch signal-type intelligence (radar_signal)
  ///
  /// [chainId] - Chain ID to filter by (e.g., 'all', 'solana', 'ethereum')
  /// [page] - Page number for pagination
  /// [pageSize] - Number of items per page
  Future<Result<List<IntelligenceEntity>>> getSignalIntelligence({
    required String chainId,
    int? page,
    int? pageSize,
  });

  /// Fetch tokens by intelligence IDs
  ///
  /// Returns a map of intelligence ID to list of tokens
  Future<Result<Map<String, List<TokenEntity>>>> getTokensByIntelligenceIds(
    List<String> intelligenceIds,
  );

  // ==================== WebSocket/Realtime Methods ====================

  /// Subscribe to realtime intelligence updates
  ///
  /// Returns a stream of intelligence entities as they arrive
  Stream<IntelligenceEntity> subscribeRealtimeIntelligence();

  /// Get the current connection status stream
  Stream<RealtimeConnectionStatus> get connectionStatusStream;

  /// Get current connection status
  RealtimeConnectionStatus get currentConnectionStatus;

  /// Connect to realtime service
  ///
  /// [agentIds] - Optional list of agent IDs to subscribe to
  Future<void> connectRealtime({List<String>? agentIds});

  /// Disconnect from realtime service
  Future<void> disconnectRealtime();

  /// Subscribe to a specific agent
  void subscribeAgent(String agentId);

  /// Unsubscribe from a specific agent
  void unsubscribeAgent(String agentId);

  /// Subscribe to multiple agents
  void subscribeAgents(List<String> agentIds);
}

/// Realtime Connection Status
enum RealtimeConnectionStatus {
  /// Not connected
  disconnected,

  /// Attempting to connect
  connecting,

  /// Successfully connected
  connected,

  /// Attempting to reconnect after disconnection
  reconnecting,

  /// Connection error occurred
  error;

  /// Check if currently connected
  bool get isConnected => this == RealtimeConnectionStatus.connected;

  /// Check if attempting to connect
  bool get isConnecting =>
      this == RealtimeConnectionStatus.connecting ||
      this == RealtimeConnectionStatus.reconnecting;

  /// Check if in error state
  bool get hasError => this == RealtimeConnectionStatus.error;
}
