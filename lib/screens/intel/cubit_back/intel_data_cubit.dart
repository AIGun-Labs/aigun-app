import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/data/services/api/monitor_api.dart';
import 'package:flutter_aigun/data/services/ws/websocket_service.dart';
import 'package:flutter_aigun/utils/logger.dart';

import '../../../data/models/intel_back/intel.dart';
import '../../../utils/storage/index.dart';
import 'intel_data_state.dart';

/// Intel数据Cubit，负责处理Intel页面的数据流
class IntelDataCubit extends Cubit<IntelDataState> {
  final MonitorApi _monitorApi;
  final WebSocketService _webSocketService;
  StreamSubscription? _webSocketStateSubscription;
  StreamSubscription? _webSocketSubscription;

  IntelDataCubit({
    MonitorApi? monitorApi,
    WebSocketService? webSocketService,
  })  : _monitorApi = monitorApi ?? MonitorApi(),
        _webSocketService =
            webSocketService ?? WebSocketService('ws/v1/subscription'),
        super(const IntelDataState()) {
    _initialize();
  }

  /// 初始化Cubit
  Future<void> _initialize() async {
    await fetchHistoricalData();
    if (!state.isConnected) {
      await _connectWebSocket();
    }
  }

  /// 查询历史数据
  Future<void> fetchHistoricalData({
    String? lastId,
    int? lastCreateAt,
  }) async {
    try {
      // 初始加载(没有lastId)时显示加载指示器，加载更多时不显示
      final bool isInitialLoad = lastId == null && lastCreateAt == null;
      emit(state.copyWith(isLoading: isInitialLoad, errorMessage: ''));

      final data = await _monitorApi.getHistoryData(
        lastId: lastId,
        lastCreateAt: lastCreateAt,
      );

      // 处理返回数据
      _handleHistoricalData(data, isInitialLoad);
    } catch (e) {
      _handleError(e);
    }
  }

  /// 处理历史数据
  void _handleHistoricalData(HistoryData data, bool isInitialLoad) {
    // 更新lastId和lastCreateAt
    final updatedState = state.copyWith(
      lastId: data.lastId ?? '',
      lastCreateAt: data.lastCreateAt ?? 0,
    );

    Logger.debug('updatedState: $updatedState');

    // 根据是否是初始加载，决定是替换还是追加数据
    if (isInitialLoad) {
      // 初始加载时替换数据
      emit(updatedState.copyWith(
        realtimeData: data.records ?? [],
        isLoading: false,
      ));
    } else {
      // 加载更多时追加数据
      final List<IntelMessage> updatedData = [
        ...state.realtimeData,
        ...(data.records ?? []),
      ];

      emit(updatedState.copyWith(
        realtimeData: updatedData,
        isLoading: false,
      ));

      Logger.debug('已加载更多数据，当前数据条数: ${updatedData.length}');
    }
  }

  /// 处理错误
  void _handleError(dynamic error) {
    emit(state.copyWith(
      errorMessage: error.message,
      isLoading: false,
    ));
    Logger.network('获取Intel数据异常: $error');
  }

  /// 重试获取历史数据
  Future<void> retryFetchHistoricalData() => fetchHistoricalData();

  /// 建立WebSocket连接
  Future<void> _connectWebSocket() async {
    // 清理旧的监听
    _disposeWebSocketListeners();

    // 设置新的监听
    _webSocketStateSubscription = _webSocketService.statusController.stream
        .listen(_handleWebSocketStateChange);
    _webSocketSubscription = _webSocketService.messageController.stream
        .listen(_handleWebSocketMessage);

    // 连接WebSocket
    _webSocketService.connect();
  }

  /// 处理WebSocket状态变化
  void _handleWebSocketStateChange(ConnectionStatus connectionState) {
    final isConnected = connectionState == ConnectionStatus.connected;
    emit(state.copyWith(isConnected: isConnected));

    // 连接成功后发送订阅消息
    if (isConnected) {
      _sendSubscription();
    }
  }

  /// 发送WebSocket订阅
  Future<void> _sendSubscription() async {
    final String token = await SecureStorageService().getToken() ?? '';

    _webSocketService.sendMessage({
      'type': 'init',
      "data": {
        "subscriptions": "3ac43583-8898-4924-95e1-872d480621f2",
        "authorization": token.isNotEmpty ? "Bearer $token" : null
      }
    });
  }

  /// 处理WebSocket消息
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
        final IntelMessageData intelMessageData =
            IntelMessageData.fromJson(jsonData);

        _addMessageToPending(intelMessageData.data!.message!);
        Logger.debug('已添加新消息到暂存区: ${intelMessageData.data!.message}');
      }
    } catch (e) {
      Logger.network('处理Intel WebSocket消息失败: $e');
    }
  }

  /// 将新消息添加到暂存列表
  void _addMessageToPending(IntelMessage message) {
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
