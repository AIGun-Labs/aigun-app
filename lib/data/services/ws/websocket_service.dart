// file: websocket_service.dart

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../config/app_config.dart';
import '../../../core/service_locator.dart';
import '../../../utils/logger.dart';
import '../../../utils/storage/secure/token_storage_service.dart';

enum ConnectionStatus { disconnected, connecting, connected, error }

class WebSocketService {
  // static final WebSocketService _instance = WebSocketService._internal();

  // factory WebSocketService() {
  //   return _instance;
  // }

  WebSocketService(this._endpoint);

  final String _endpoint;

  WebSocketChannel? _channel;
  String? _url;
  Timer? _reconnectTimer;
  Timer? _pingTimer;
  bool _isManualDisconnect = false;

  final Duration reconnectDelay = const Duration(seconds: 5);
  final Duration pingInterval = const Duration(seconds: 90);

  final messageController = StreamController<dynamic>.broadcast();
  final statusController = StreamController<ConnectionStatus>.broadcast();

  Stream<dynamic> get messages => messageController.stream;
  Stream<ConnectionStatus> get connectionStatus => statusController.stream;
  ConnectionStatus _currentStatus = ConnectionStatus.disconnected;
  ConnectionStatus get currentStatus => _currentStatus;

  void init() {
    statusController.add(ConnectionStatus.disconnected);
  }

  void connect() async {
    if (_currentStatus == ConnectionStatus.connected ||
        _currentStatus == ConnectionStatus.connecting) {
      if (kDebugMode) {
        Logger.info('WebSocketService: Already connected or connecting.');
      }
      return;
    }

    _isManualDisconnect = false;
    _updateStatus(ConnectionStatus.connecting);

    try {
      final String wsUrl = '${AppConfig.wsUrl}/$_endpoint';

      final String? token = await getIt<TokenStorageService>().getAccessToken();

      _channel = _createWebSocketChannel(wsUrl, token);

      _updateStatus(ConnectionStatus.connected);
      if (kDebugMode) print('WebSocketService: Connected successfully!');

      _reconnectTimer?.cancel();

      _startFirstHeartbeat();

      _channel!.stream.listen(
        _onMessageReceived,
        onDone: _onConnectionDone,
        onError: _onConnectionError,
        cancelOnError: true,
      );
    } catch (e) {
      if (kDebugMode) print('WebSocketService: Connection error: $e');
      _onConnectionError(e);
    }
  }

  WebSocketChannel _createWebSocketChannel(String url, String? token) {
    final headers = <String, dynamic>{};
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return IOWebSocketChannel.connect(Uri.parse(url), headers: headers);
  }

  void disconnect() {
    if (kDebugMode) print('WebSocketService: Manually disconnecting...');
    _isManualDisconnect = true;
    _clearTimers();
    _channel?.sink.close();
    _updateStatus(ConnectionStatus.disconnected);
  }

  void sendMessage(dynamic message) {
    if (_currentStatus != ConnectionStatus.connected || _channel == null) {
      if (kDebugMode) {
        print('WebSocketService: Cannot send message. Not connected.');
      }

      return;
    }

    if (message is Map) {
      message = jsonEncode(message);
    }

    if (kDebugMode) print('WebSocketService: Sending message: $message');
    _channel!.sink.add(message);
  }

  ///

  void subscribe(Map<String, dynamic> payload) {
    if (_currentStatus != ConnectionStatus.connected) {
      if (kDebugMode) {
        print('WebSocketService: Cannot subscribe. Not connected.');
      }
      return;
    }

    final subMessage = {'type': 'init', 'data': payload};
    sendMessage(subMessage);

    _startFirstHeartbeat();
  }

  void dispose() {
    if (kDebugMode) print('WebSocketService: Disposing...');
    _clearTimers();
    _channel?.sink.close();
    messageController.close();
    statusController.close();
  }

  void _startFirstHeartbeat() {
    _pingTimer?.cancel();

    _pingTimer = Timer(const Duration(seconds: 5), () {
      if (_currentStatus == ConnectionStatus.connected) {
        sendMessage({'type': 'ping'});

        _startRegularHeartbeat();
      }
    });
  }

  void _startRegularHeartbeat() {
    _pingTimer?.cancel();

    _pingTimer = Timer.periodic(pingInterval, (_) {
      if (_currentStatus == ConnectionStatus.connected) {
        sendMessage({'type': 'ping'});
      }
    });
  }

  void _onMessageReceived(dynamic message) {
    if (kDebugMode) print('WebSocketService: Message received: $message');
    Logger.debug('WebSocket: $message');

    try {
      if (message is String) {
        try {
          final jsonData = jsonDecode(message);
          messageController.add(jsonData);
        } catch (jsonError) {
          Logger.debug('JSON: $message');
          messageController.add(message);
        }
      } else {
        messageController.add(message);
      }
    } catch (e) {
      Logger.debug('WebSocket: $e');
    }
  }

  void _onConnectionDone() {
    if (kDebugMode) print('WebSocketService: Connection closed by server.');
    _handleDisconnect();
  }

  void _onConnectionError(dynamic error) {
    if (kDebugMode) {
      Logger.error('WebSocketService: Connection error: $error');
    }
    _updateStatus(ConnectionStatus.error);
    _handleDisconnect();
  }

  void _handleDisconnect() {
    _clearTimers();
    if (_currentStatus != ConnectionStatus.disconnected) {
      _updateStatus(ConnectionStatus.disconnected);
    }

    if (!_isManualDisconnect && _url != null) {
      if (kDebugMode) {
        _reconnectTimer = Timer(reconnectDelay, () => connect());
      }
    }
  }

  void _updateStatus(ConnectionStatus status) {
    _currentStatus = status;
    statusController.add(status);
  }

  void _clearTimers() {
    _pingTimer?.cancel();
    _reconnectTimer?.cancel();
  }
}
