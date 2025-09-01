import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/data/services/api/intel_api.dart';
import 'package:flutter_aigun/data/services/api/monitor_api.dart';
import 'package:flutter_aigun/data/services/ws/websocket_service.dart';
import 'package:flutter_aigun/utils/logger.dart';

import '../../data/models/intel/intel.dart';
import '../../utils/storage/index.dart';
import 'intel_state.dart';

/// Intel数据Cubit，负责处理Intel页面的数据流
class IntelCubit extends Cubit<IntelState> {
  final IntelApi _intelApi;
  final MonitorApi _monitorApi;
  final WebSocketService _webSocketService; // WebSocket 服务
  StreamSubscription? _webSocketStateSubscription; // 监听WebSocket状态变化
  StreamSubscription? _webSocketSubscription; // 监听WebSocket消息

  IntelCubit({
    MonitorApi? monitorApi,
    WebSocketService? webSocketService,
    IntelApi? intelApi,
  })  : _monitorApi = monitorApi ?? MonitorApi(),
        _webSocketService =
            webSocketService ?? WebSocketService('ws/v1/intelligence/'),
        _intelApi = intelApi ?? IntelApi(),
        super(const IntelState()) {
    _initialize(); // 初始化 Cubit
  }

  /// 初始化Cubit
  Future<void> _initialize() async {
    // await fetchHistoricalData(); // 查询历史数据
    if (!state.isConnected) {
      await _connectWebSocket(); // 连接WebSocket
    }
  }

  // /// 查询历史数据
  // Future<void> fetchHistoricalData({
  //   String? lastId,
  //   int? lastCreateAt,
  // }) async {
  //   try {
  //     // 初始加载(没有lastId)时显示加载指示器，加载更多时不显示
  //     final bool isInitialLoad = lastId == null && lastCreateAt == null;
  //     emit(state.copyWith(isLoading: isInitialLoad, errorMessage: ''));

  //     // 查询历史数据
  //     final data = await _monitorApi.getHistoryData(
  //       lastId: lastId,
  //       lastCreateAt: lastCreateAt,
  //     );

  //     // 处理返回数据
  //     _handleHistoricalData(data, isInitialLoad);
  //   } catch (e) {
  //     _handleError(e);
  //   }
  // }

  // /// 处理历史数据
  // void _handleHistoricalData(HistoryData data, bool isInitialLoad) {
  //   // 更新lastId和lastCreateAt
  //   final updatedState = state.copyWith(
  //     lastId: data.lastId ?? '',
  //     lastCreateAt: data.lastCreateAt ?? 0,
  //   );

  //   Logger.debug('updatedState: $updatedState');

  //   // 根据是否是初始加载，决定是替换还是追加数据
  //   if (isInitialLoad) {
  //     // 初始加载时替换数据
  //     emit(updatedState.copyWith(
  //       realtimeData: data.records ?? [],
  //       isLoading: false,
  //     ));
  //   } else {
  //     // 加载更多时追加数据
  //     final List<IntelMessage> updatedData = [
  //       ...state.realtimeData,
  //       ...(data.records ?? []),
  //     ];

  //     emit(updatedState.copyWith(
  //       realtimeData: updatedData,
  //       isLoading: false,
  //     ));

  //     Logger.debug('已加载更多数据，当前数据条数: ${updatedData.length}');
  //   }
  // }

  /// 处理错误
  // void _handleError(dynamic error) {
  //   emit(state.copyWith(
  //     errorMessage: error.message,
  //     isLoading: false,
  //   ));
  //   Logger.network('获取Intel数据异常: $error');
  // }

  /// 重试获取历史数据
  // Future<void> retryFetchHistoricalData() => fetchHistoricalData();

  /// 建立WebSocket连接
  Future<void> _connectWebSocket() async {
    // 清理旧的监听
    _disposeWebSocketListeners();

    // 设置新的监听
    // 监听 WebSocket 状态变化
    _webSocketStateSubscription = _webSocketService.statusController.stream
        .listen(_handleWebSocketStateChange);
    // 监听 WebSocket 消息
    _webSocketSubscription = _webSocketService.messageController.stream
        .listen(_handleWebSocketMessage);

    // 连接WebSocket
    _webSocketService.connect();
  }

  /// 处理WebSocket状态变化
  void _handleWebSocketStateChange(ConnectionStatus connectionState) {
    //
    final isConnected = connectionState == ConnectionStatus.connected;
    emit(state.copyWith(isConnected: isConnected));

    // 连接成功后发送订阅消息
    if (isConnected) {
      // _webSocketService.subscribe();
      _sendSubscription(); // 发送订阅消息
    }
  }

  /// 1.发送WebSocket订阅 init 订阅消息
  Future<void> _sendSubscription() async {
    final String token = await SecureStorageService().getToken() ?? '';

    _webSocketService.sendMessage({
      'type': 'init',
      "data": {
        "subscriptions": "0197e960-ee39-7f2d-afe3-b049dfcbd304",
        // "authorization": token.isNotEmpty ? "Bearer $token" : null
      }
    });
  }

  void addVisibleId(String id) {
    final updatedVisibleIds = [...state.visibleIds, id];
    emit(state.copyWith(visibleIds: updatedVisibleIds));
  }

  void removeVisibleId(String id) {
    final updatedVisibleIds =
        state.visibleIds.where((visibleId) => visibleId != id).toList();
    emit(state.copyWith(visibleIds: updatedVisibleIds));
  }

  Future<void> getTokensByIntelIds() async {
    if (state.visibleIds.isEmpty) return;

    try {
      final response = await _intelApi.getTokensByIntelIds(state.visibleIds);
      Logger.debug('getTokensByIntelIds: $response');
    } catch (e) {
      Logger.network('getTokensByIntelIds error: $e');
    }
  }

  /// 2.处理WebSocket消息
  void _handleWebSocketMessage(dynamic message) {
    try {
      if (message is! Map) return;

      // 处理欢迎消息
      if (message['type'] == 'welcome') {
        Logger.debug('WebSocket连接成功 - 收到欢迎消息');
        return;
      }

      // 处理ping响应
      if (message['type'] == 'pong') return;

      if (message['type'] == 'message') {
        // 处理正常的数据消息
        final Map<String, dynamic> jsonData =
            Map<String, dynamic>.from(message);
        Logger.debug('收到WebSocket消息: $jsonData');

        // 将消息解析为IntelMessageData类型
        final IntelMessage intelMessageData = IntelMessage.fromJson(jsonData);

        _updateAllMessages(intelMessageData.data!);
        Logger.debug('已添加新消息到暂存区: ${intelMessageData.data}');
      }
    } catch (e) {
      Logger.network('处理Intel WebSocket消息失败: $e');
    }
  }

  void _updateAllMessages(Intel newMessages) {
    final List<Intel> updatedAllMessage;

    if (state.allMessages == null) {
      updatedAllMessage = [newMessages];
    } else {
      updatedAllMessage = [newMessages, ...state.allMessages!];
    }

    emit(state.copyWith(allMessages: updatedAllMessage));
  }

  /// 将新消息添加到暂存列表
  void _addMessageToPending(Intel message) {
    final updatedPendingData = [message, ...state.pendingData];
    emit(state.copyWith(pendingData: updatedPendingData));
  }

  /// 加载暂存的新数据
  void loadPendingData() {
    if (state.pendingData.isEmpty) return;

    // 打印详细日志，查看暂存数据内容
    Logger.debug(
        '待加载的暂存数据: ${state.pendingData.map((m) => '标题:${m.title},内容:${m.content},时间:${m.createdAt},用户:${m.user?.name}').join('\n')}');

    final updatedRealtimeData = [...state.pendingData, ...state.realtimeData];

    emit(state.copyWith(
      realtimeData: updatedRealtimeData,
      pendingData: [], // 清空暂存数据
    ));

    Logger.debug('已加载暂存数据，当前数据条数: ${updatedRealtimeData.length}');
  }

  void getIntelHistoryData() async {
    final data = await _monitorApi.getHistoryData();
  }

  /// 重新连接WebSocket
  void reconnectWebSocket() => _webSocketService.connect();

  /// 断开WebSocket连接
  void disconnectWebSocket() {
    _webSocketService.disconnect();
    emit(state.copyWith(isConnected: false));
  }

  /// 清除错误信息
  void clearError() => emit(state.copyWith(errorMessage: ''));

  /// 清理WebSocket监听
  void _disposeWebSocketListeners() {
    _webSocketStateSubscription?.cancel();
    _webSocketSubscription?.cancel();
    _webSocketStateSubscription = null;
    _webSocketSubscription = null;
  }

  @override
  Future<void> close() {
    _disposeWebSocketListeners();
    _webSocketService.dispose();
    disconnectWebSocket();
    return super.close();
  }
}
