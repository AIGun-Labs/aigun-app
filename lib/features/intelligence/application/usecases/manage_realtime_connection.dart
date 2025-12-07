import '../../domain/repositories/intelligence_repository.dart';

/// Manage Realtime Connection Use Case
///
/// Handles WebSocket connection lifecycle for realtime intelligence.
class ManageRealtimeConnection {
  final IntelligenceRepository _repository;

  ManageRealtimeConnection(this._repository);

  /// Connect to realtime service
  ///
  /// [agentIds] - Optional list of agent IDs to subscribe to initially
  Future<void> connect({List<String>? agentIds}) {
    return _repository.connectRealtime(agentIds: agentIds);
  }

  /// Disconnect from realtime service
  Future<void> disconnect() {
    return _repository.disconnectRealtime();
  }

  /// Get connection status stream
  Stream<RealtimeConnectionStatus> get statusStream {
    return _repository.connectionStatusStream;
  }

  /// Get current connection status
  RealtimeConnectionStatus get currentStatus {
    return _repository.currentConnectionStatus;
  }

  /// Check if currently connected
  bool get isConnected {
    return _repository.currentConnectionStatus.isConnected;
  }
}
