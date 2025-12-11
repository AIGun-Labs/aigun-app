// file: websocket_service.dart

import 'dart:async';
import 'dart:convert'; // 用于json编解码示例

import 'package:flutter/foundation.dart'; // 用于 kDebugMode
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../config/app_config.dart';
import '../../../core/service_locator.dart';
import '../../../utils/logger.dart';
import '../../../utils/storage/secure/token_storage_service.dart';

/// 连接状态枚举
enum ConnectionStatus { disconnected, connecting, connected, error }

class WebSocketService {
  /// 单例实例
  // static final WebSocketService _instance = WebSocketService._internal();

  // factory WebSocketService() {
  //   return _instance;
  // }

  WebSocketService(this._endpoint);

  final String _endpoint;

  // --- 私有变量 ---
  WebSocketChannel? _channel;
  String? _url;
  Timer? _reconnectTimer;
  Timer? _pingTimer; // 心跳定时器
  bool _isManualDisconnect = false;

  // --- 可配置项 ---
  final Duration reconnectDelay = const Duration(seconds: 5); // 重连延迟
  final Duration pingInterval = const Duration(seconds: 90); // 心跳间隔

  // --- 流控制器 (StreamControllers) ---
  final messageController = StreamController<dynamic>.broadcast();
  final statusController = StreamController<ConnectionStatus>.broadcast();

  // --- 公共 Getters ---
  Stream<dynamic> get messages => messageController.stream;
  Stream<ConnectionStatus> get connectionStatus => statusController.stream;
  ConnectionStatus _currentStatus = ConnectionStatus.disconnected;
  ConnectionStatus get currentStatus => _currentStatus;

  /// 初始化服务
  void init() {
    statusController.add(ConnectionStatus.disconnected);
  }

  /// 连接到WebSocket服务器 (简化版)
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
      final String wsUrl = '${AppConfig().env.wsUrl}/$_endpoint';
      _url = wsUrl; // 保存 URL 用于重连

      final String? token = await getIt<TokenStorageService>().getAccessToken();

      _channel = _createWebSocketChannel(wsUrl, token);

      _updateStatus(ConnectionStatus.connected);
      if (kDebugMode) Logger.info('WebSocketService: Connected successfully!');

      _reconnectTimer?.cancel();

      // 连接成功后，不立即开始心跳，等待订阅
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

  /// 断开连接
  void disconnect() {
    if (kDebugMode) Logger.error('WebSocketService: Manually disconnecting...');
    _isManualDisconnect = true;
    _clearTimers();
    _channel?.sink.close();
    _updateStatus(ConnectionStatus.disconnected);
  }

  /// 发送消息 (通用方法)
  void sendMessage(dynamic message) {
    if (_currentStatus != ConnectionStatus.connected || _channel == null) {
      if (kDebugMode) {
        Logger.debug('WebSocketService: Cannot send message. Not connected.');
      }

      return;
    }

    if (message is Map) {
      message = jsonEncode(message);
    }

    if (kDebugMode) Logger.debug('WebSocketService: Sending message: $message');
    _channel!.sink.add(message);
  }

  /// 订阅频道/主题
  ///
  /// [payload] - 订阅所需的数据，需要根据你的后端API来确定
  void subscribe(Map<String, dynamic> payload) {
    if (_currentStatus != ConnectionStatus.connected) {
      if (kDebugMode) {
        Logger.debug('WebSocketService: Cannot subscribe. Not connected.');
      }
      return;
    }
    // 实际的订阅消息格式需要根据你的后端来确定
    // 在你之前的代码中，似乎是 {"type": "init", "data": ...}
    final subMessage = {'type': 'init', 'data': payload};
    sendMessage(subMessage);

    // 订阅后，再开始心跳来保持连接
    _startFirstHeartbeat();
  }

  /// 释放资源
  void dispose() {
    if (kDebugMode) Logger.debug('WebSocketService: Disposing...');
    _clearTimers();
    _channel?.sink.close();
    messageController.close();
    statusController.close();
  }

  // --- 私有方法 ---

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
    if (kDebugMode) Logger.debug('收到WebSocket消息: $message');

    try {
      // 尝试解析JSON消息
      if (message is String) {
        try {
          // 尝试解析为JSON
          final jsonData = jsonDecode(message);
          messageController.add(jsonData);
        } catch (jsonError) {
          // 如果不是有效的JSON，直接传递原始字符串
          Logger.debug('收到非JSON格式消息: $message');
          messageController.add(message); // 启用非JSON消息传递
        }
      } else {
        // 直接传递非字符串消息
        messageController.add(message);
      }
    } catch (e) {
      Logger.debug('WebSocket消息处理失败: $e');
    }
  }

  void _onConnectionDone() {
    if (kDebugMode) print('WebSocketService: Connection closed by server.');
    _handleDisconnect();
  }

  void _onConnectionError(dynamic error) {
    Logger.error('WebSocketService: Connection error: $error');
    Logger.error('WebSocketService: URL was: $_url');
    _updateStatus(ConnectionStatus.error);
    _handleDisconnect();
  }

  void _handleDisconnect() {
    _clearTimers();
    if (_currentStatus != ConnectionStatus.disconnected) {
      _updateStatus(ConnectionStatus.disconnected);
    }

    if (!_isManualDisconnect && _url != null) {
      // 自动重连（生产环境和调试环境都启用）
      Logger.info(
        'WebSocketService: Scheduling reconnect in ${reconnectDelay.inSeconds}s',
      );
      _reconnectTimer = Timer(reconnectDelay, () => connect());
    }
  }

  void _updateStatus(ConnectionStatus status) {
    _currentStatus = status;
    statusController.add(status);
  }

  /// 统一清除所有定时器
  void _clearTimers() {
    _pingTimer?.cancel();
    _reconnectTimer?.cancel();
  }
}
