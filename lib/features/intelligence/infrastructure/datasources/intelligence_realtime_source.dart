import 'dart:async';
import 'dart:math';

import '../../../../data/services/sentry_service.dart';
import '../../../../data/services/ws/websocket_service.dart';
import '../../../../utils/logger.dart';
import '../../domain/repositories/intelligence_repository.dart';
import '../models/intelligence_message_model.dart';
import '../models/intelligence_model.dart';

/// Intelligence Realtime Source
///
/// Handles WebSocket connection for realtime intelligence updates.
/// Implements best practices:
/// - Connection lifecycle management
/// - Heartbeat/ping-pong
/// - Exponential backoff reconnection
/// - Dynamic subscription management
/// - Error handling and reporting
class IntelligenceRealtimeSource {
  final WebSocketService _webSocketService;

  // Stream controllers
  final _statusController =
      StreamController<RealtimeConnectionStatus>.broadcast();
  final _intelligenceController =
      StreamController<IntelligenceModel>.broadcast();

  // Current status tracking
  RealtimeConnectionStatus _currentStatus = RealtimeConnectionStatus.disconnected;

  /// Update status and notify listeners
  void _updateStatus(RealtimeConnectionStatus status) {
    _currentStatus = status;
    _statusController.add(status);
  }

  // Timers
  Timer? _heartbeatTimer;
  Timer? _reconnectTimer;

  // Reconnection configuration
  static const _initialReconnectDelay = Duration(seconds: 1);
  static const _maxReconnectDelay = Duration(seconds: 30);
  static const _heartbeatInterval = Duration(seconds: 30);
  int _reconnectAttempts = 0;

  // Subscription management
  final Set<String> _subscriptions = {};

  // Stream subscriptions
  StreamSubscription? _messageSubscription;
  StreamSubscription? _statusSubscription;

  /// Constructor
  IntelligenceRealtimeSource(this._webSocketService);

  /// Factory constructor with default WebSocket service
  factory IntelligenceRealtimeSource.create() {
    return IntelligenceRealtimeSource(
      WebSocketService('ws/v1/intelligence/'),
    );
  }

  // ==================== Public Getters ====================

  /// Stream of connection status updates
  Stream<RealtimeConnectionStatus> get statusStream => _statusController.stream;

  /// Stream of intelligence updates
  Stream<IntelligenceModel> get intelligenceStream =>
      _intelligenceController.stream;

  /// Current connection status
  RealtimeConnectionStatus get currentStatus => _currentStatus;

  /// Check if connected
  bool get isConnected =>
      currentStatus == RealtimeConnectionStatus.connected;

  // ==================== Connection Management ====================

  /// Connect to WebSocket server
  Future<void> connect() async {
    if (currentStatus == RealtimeConnectionStatus.connected ||
        currentStatus == RealtimeConnectionStatus.connecting) {
      Logger.debug('IntelligenceRealtimeSource: Already connected or connecting');
      return;
    }

    _updateStatus(RealtimeConnectionStatus.connecting);
    Logger.debug('IntelligenceRealtimeSource: Connecting...');

    try {
      // Setup listeners before connecting
      _setupListeners();

      // Connect
      _webSocketService.connect();

      // Note: Connection success is handled in _handleStatusChange
    } catch (e, s) {
      Logger.error('IntelligenceRealtimeSource: Connection error: $e');
      await SentryService().reportError(e, s, tags: {'feature': 'intelligence_ws'});
      _updateStatus(RealtimeConnectionStatus.error);
      _scheduleReconnect();
    }
  }

  /// Disconnect from WebSocket server
  Future<void> disconnect() async {
    Logger.debug('IntelligenceRealtimeSource: Disconnecting...');

    _stopHeartbeat();
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    _reconnectAttempts = 0;

    _disposeListeners();
    _webSocketService.disconnect();

    _updateStatus(RealtimeConnectionStatus.disconnected);
  }

  // ==================== Subscription Management ====================

  /// Subscribe to a specific agent
  void subscribe(String agentId) {
    _subscriptions.add(agentId);
    if (isConnected) {
      _sendFollowAgent(agentId);
    }
  }

  /// Unsubscribe from a specific agent
  void unsubscribe(String agentId) {
    _subscriptions.remove(agentId);
    if (isConnected) {
      _sendUnfollowAgent(agentId);
    }
  }

  /// Subscribe to multiple agents (used for initialization)
  void subscribeAll(List<String> agentIds) {
    _subscriptions.addAll(agentIds);
    if (isConnected) {
      _sendInitSubscription();
    }
  }

  /// Clear all subscriptions
  void clearSubscriptions() {
    _subscriptions.clear();
  }

  // ==================== Private Methods ====================

  void _setupListeners() {
    _disposeListeners();

    // Listen to WebSocket status changes
    _statusSubscription = _webSocketService.statusController.stream.listen(
      _handleStatusChange,
      onError: (error) {
        Logger.error('IntelligenceRealtimeSource: Status stream error: $error');
      },
    );

    // Listen to WebSocket messages
    _messageSubscription = _webSocketService.messageController.stream.listen(
      _handleMessage,
      onError: (error) {
        Logger.error('IntelligenceRealtimeSource: Message stream error: $error');
      },
    );
  }

  void _disposeListeners() {
    _statusSubscription?.cancel();
    _statusSubscription = null;
    _messageSubscription?.cancel();
    _messageSubscription = null;
  }

  void _handleStatusChange(ConnectionStatus status) {
    Logger.debug('IntelligenceRealtimeSource: Status changed to $status');

    switch (status) {
      case ConnectionStatus.connected:
        _updateStatus(RealtimeConnectionStatus.connected);
        _reconnectAttempts = 0;
        _startHeartbeat();
        _resubscribeAll();
        break;

      case ConnectionStatus.disconnected:
        _updateStatus(RealtimeConnectionStatus.disconnected);
        _stopHeartbeat();
        _scheduleReconnect();
        break;

      case ConnectionStatus.connecting:
        _updateStatus(RealtimeConnectionStatus.connecting);
        break;

      case ConnectionStatus.error:
        _updateStatus(RealtimeConnectionStatus.error);
        _stopHeartbeat();
        _scheduleReconnect();
        break;
    }
  }

  void _handleMessage(dynamic message) {
    if (message is! Map) {
      Logger.debug('IntelligenceRealtimeSource: Invalid message format');
      return;
    }

    final type = message['type'] as String?;

    switch (type) {
      case 'welcome':
        Logger.debug('IntelligenceRealtimeSource: Received welcome message');
        break;

      case 'pong':
        // Heartbeat response - connection is alive
        break;

      case 'message':
        _handleIntelligenceMessage(message);
        break;

      case 'follow_agent':
      case 'unfollow_agent':
        final responseMessage = message['message'];
        if (responseMessage == 'success') {
          Logger.debug('IntelligenceRealtimeSource: $type success');
        }
        break;

      case 'error':
        _handleErrorMessage(message);
        break;

      default:
        Logger.debug('IntelligenceRealtimeSource: Unknown message type: $type');
    }
  }

  void _handleIntelligenceMessage(Map<dynamic, dynamic> message) {
    try {
      final jsonMessage = Map<String, dynamic>.from(message);
      final intelligenceMessage = IntelligenceMessageModel.fromJson(jsonMessage);

      if (intelligenceMessage.data != null) {
        _intelligenceController.add(intelligenceMessage.data!);
        Logger.debug(
          'IntelligenceRealtimeSource: Received intelligence: ${intelligenceMessage.data?.id}',
        );
      }
    } catch (e, s) {
      Logger.error('IntelligenceRealtimeSource: Parse error: $e');
      SentryService().reportError(
        e,
        s,
        tags: {'feature': 'intelligence_ws_parse'},
      );
    }
  }

  void _handleErrorMessage(Map<dynamic, dynamic> message) {
    final errorMsg = message['message'] ?? 'Unknown error';
    Logger.error('IntelligenceRealtimeSource: WebSocket error: $errorMsg');
    SentryService().reportError(
      'WebSocket error: $errorMsg',
      StackTrace.current,
      tags: {'feature': 'intelligence_ws_error'},
    );
  }

  // ==================== Heartbeat ====================

  void _startHeartbeat() {
    _stopHeartbeat();
    _heartbeatTimer = Timer.periodic(_heartbeatInterval, (_) {
      if (isConnected) {
        _webSocketService.sendMessage({'type': 'ping'});
      }
    });
  }

  void _stopHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
  }

  // ==================== Reconnection ====================

  void _scheduleReconnect() {
    if (_reconnectTimer != null) return;

    final delay = _calculateReconnectDelay();
    Logger.debug(
      'IntelligenceRealtimeSource: Scheduling reconnect in ${delay.inSeconds}s (attempt $_reconnectAttempts)',
    );

    _updateStatus(RealtimeConnectionStatus.reconnecting);

    _reconnectTimer = Timer(delay, () {
      _reconnectTimer = null;
      _reconnectAttempts++;
      connect();
    });
  }

  Duration _calculateReconnectDelay() {
    // Exponential backoff with jitter
    final exponentialDelay = _initialReconnectDelay.inMilliseconds *
        pow(2, _reconnectAttempts).toInt();
    final cappedDelay = min(exponentialDelay, _maxReconnectDelay.inMilliseconds);

    // Add random jitter (0-25% of delay)
    final jitter = (cappedDelay * 0.25 * (Random().nextDouble())).toInt();

    return Duration(milliseconds: cappedDelay + jitter);
  }

  // ==================== Subscription Messages ====================

  void _resubscribeAll() {
    if (_subscriptions.isNotEmpty) {
      _sendInitSubscription();
    }
  }

  void _sendInitSubscription() {
    if (_subscriptions.isEmpty) return;

    _webSocketService.sendMessage({
      'type': 'init',
      'data': {
        'subscriptions': _subscriptions.join('#'),
      },
    });
    Logger.debug(
      'IntelligenceRealtimeSource: Sent init subscription for ${_subscriptions.length} agents',
    );
  }

  void _sendFollowAgent(String agentId) {
    _webSocketService.sendMessage({
      'type': 'follow_agent',
      'data': {'subset_id': agentId},
    });
  }

  void _sendUnfollowAgent(String agentId) {
    _webSocketService.sendMessage({
      'type': 'unfollow_agent',
      'data': {'subset_id': agentId},
    });
  }

  // ==================== Disposal ====================

  /// Dispose resources
  Future<void> dispose() async {
    await disconnect();
    await _statusController.close();
    await _intelligenceController.close();
    _webSocketService.dispose();
  }
}
