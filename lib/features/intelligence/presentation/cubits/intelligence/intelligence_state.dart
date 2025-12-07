import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/repositories/intelligence_repository.dart';

part 'intelligence_state.freezed.dart';

/// Intelligence State
///
/// Main coordinator state that manages overall intelligence feature state.
@freezed
sealed class IntelligenceState with _$IntelligenceState {
  const IntelligenceState._();

  const factory IntelligenceState({
    /// Current active tab index (0: Events, 1: Signals)
    @Default(0) int activeTabIndex,

    /// WebSocket connection status
    @Default(RealtimeConnectionStatus.disconnected)
    RealtimeConnectionStatus connectionStatus,

    /// Whether realtime is enabled
    @Default(true) bool realtimeEnabled,

    /// Last connection error message
    String? connectionError,

    /// Timestamp of last successful connection
    DateTime? lastConnectedAt,
  }) = _IntelligenceState;

  /// Initial state factory
  factory IntelligenceState.initial() => const IntelligenceState();
}

/// Extension for convenience methods
extension IntelligenceStateX on IntelligenceState {
  /// Whether WebSocket is connected
  bool get isConnected =>
      connectionStatus == RealtimeConnectionStatus.connected;

  /// Whether WebSocket is connecting
  bool get isConnecting =>
      connectionStatus == RealtimeConnectionStatus.connecting;

  /// Whether WebSocket is reconnecting
  bool get isReconnecting =>
      connectionStatus == RealtimeConnectionStatus.reconnecting;

  /// Whether there's a connection error
  bool get hasConnectionError => connectionError != null;

  /// Check if viewing events tab
  bool get isEventsTab => activeTabIndex == 0;

  /// Check if viewing signals tab
  bool get isSignalsTab => activeTabIndex == 1;
}
