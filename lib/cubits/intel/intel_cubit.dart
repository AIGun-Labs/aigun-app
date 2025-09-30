import 'dart:async';

import 'package:flutter_aigun/core/cubit_locator.dart';
import 'package:flutter_aigun/cubits/trending/trending_cubit.dart';
import 'package:flutter_aigun/utils/numeric_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/data/services/api/intel_api.dart';
import 'package:flutter_aigun/data/services/api/monitor_api.dart';
import 'package:flutter_aigun/data/services/ws/websocket_service.dart';
import 'package:flutter_aigun/utils/logger.dart';

import '../../data/models/intel/intel.dart';
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
    if (!state.isConnected) {
      await _connectWebSocket(); // 连接WebSocket
    }

//  tokens get every 5 seconds
    _tokenTimer = Timer.periodic(
        Duration(seconds: NumericUtils.getRandomInt(30, 50)), (timer) {
      getTokensByIntelIds();
    });

// once get intelligences history
    await getIntelsHistory();
  }

  Timer? _tokenTimer;

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
    _webSocketService.sendMessage({
      'type': 'init',
      "data": {
        "subscriptions":
            "01998e06-f10d-7156-b69c-9db854d882fe#01998e06-f10d-7156-b69c-99c03ea836bc",
        // "authorization": token.isNotEmpty ? "Bearer $token" : null
      }
    });
  }

  void addVisibleId(String id) {
    Logger.info("addVisibleId: $id");
    final updatedVisibleIds = [...state.visibleIds, id];
    removeUnreadId(id);
    emit(state.copyWith(visibleIds: updatedVisibleIds));
  }

  void removeVisibleId(String id) {
    // 在这里可以删除新消息
    Logger.info("removeVisibleId: $id");
    final updatedVisibleIds =
        state.visibleIds.where((visibleId) => visibleId != id).toList();
    emit(state.copyWith(visibleIds: updatedVisibleIds));
  }

  void addUnreadId(String? id) {
    if (id == null || state.unreadIds.contains(id)) return;
    Logger.info("addUnreadId: $id");
    final updatedUnreadIds = [...state.unreadIds, id];
    emit(state.copyWith(unreadIds: updatedUnreadIds));
  }

  void removeUnreadId(String? id) {
    if (id == null) return;
    Logger.info("removeUnreadId: $id");
    final updatedUnreadIds =
        state.unreadIds.where((unreadId) => unreadId != id).toList();
    emit(state.copyWith(unreadIds: updatedUnreadIds));
  }

  void clearUnreadIds() {
    emit(state.copyWith(unreadIds: []));
  }

  /// 判断指定ID是否为未读状态
  bool isUnread(String? id) {
    return id != null && state.unreadIds.contains(id);
  }

// get intelligences history
  Future<void> getIntelsHistory() async {
    // emit(state.copyWith(isLoading: true));
    emit(state.copyWith(isFetchingMore: true));
    try {
      final currentMessages = state.allMessages ?? [];
      final page = currentMessages.length ~/ state.pageSize + 1;
      final intels = await _intelApi.getIntelsHistory(page, state.pageSize);

// if intels is empty, set isNotMore to true
      if (intels.isEmpty) {
        emit(state.copyWith(isNotMore: true));
      } else {
        emit(state.copyWith(isNotMore: false));
      }
      emit(state.copyWith(allMessages: [...currentMessages, ...intels]));
    } catch (e) {
      Logger.error("getIntelsHistory error: $e");
    } finally {
      // emit(state.copyWith(isLoading: false));
      emit(state.copyWith(isFetchingMore: false));
    }
  }

// 定时根据 intel ids 获取token 信息
  Future<void> getTokensByIntelIds() async {
    if (state.visibleIds.isEmpty) return;

    try {
      final tokensMap = await _intelApi.getTokensByIntelIds(state.visibleIds);

      // 确保 allMessages 不为 null
      final currentMessages = state.allMessages ?? [];

      final updatedMessages = currentMessages.map((intel) {
        // get current intelligence id
        final String? entityId = intel.id;

        // if entityid  unequal Null and tokenMap nonexistent currentId
        if (entityId != null && tokensMap.containsKey(entityId)) {
          // get current intellagence entitys
          final tokens = tokensMap[entityId];
          if (tokens != null) {
            // update intelligence  tokens
            return intel.copyWith(entities: tokens);
          }
        }

        // 如果没有找到对应的 token 或 tokens 为 null，返回原始 Intel
        // if not found, return original intel
        return intel;
      }).toList();

      // 更新状态
      emit(state.copyWith(allMessages: updatedMessages));
    } catch (e) {
      Logger.error('getTokensByIntelIds error: $e');
    }
  }

  /// 2.处理WebSocket消息
  void _handleWebSocketMessage(dynamic message) async {
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

        if (intelMessageData.data != null &&
            intelMessageData.data?.id != null) {
          _updateAllMessages(intelMessageData.data!);
          addUnreadId(intelMessageData.data?.id!);
          await getIt<TrendingCubit>().getLastestTokens();

          Logger.debug('已添加新消息到暂存区: ${intelMessageData.data}');
        } else {
          Logger.error('收到WebSocket消息但data为空: $jsonData');
        }
      }
    } catch (e) {
      Logger.error('处理Intel WebSocket消息失败: $e');
    }
  }

  void _updateAllMessages(Intel newMessages) {
    final List<Intel> updatedAllMessage;

    final currentMessages = state.allMessages ?? [];
    if (currentMessages.isEmpty) {
      updatedAllMessage = [newMessages];
    } else {
      updatedAllMessage = [newMessages, ...currentMessages];
    }

    emit(state.copyWith(allMessages: updatedAllMessage));
  }

  void updatePage(int page) {
    emit(state.copyWith(page: page));
  }

  /// 加载暂存的新数据  TODO：没有使用到
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
    await _monitorApi.getHistoryData();
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
    _tokenTimer?.cancel();
    return super.close();
  }

  Future<void> refreshIntels() async {
    emit(state.copyWith(
      page: 1,
      isNotMore: false,
      allMessages: [],
      visibleIds: [],
      unreadIds: [], // 清空未读列表，因为刷新后所有消息都是已读的
      isFetchingMore: true,
    ));

    try {
      final intels = await _intelApi.getIntelsHistory(1, state.pageSize);

      if (intels.isEmpty) {
        emit(state.copyWith(isNotMore: true, isFetchingMore: false));
      } else {
        emit(state.copyWith(allMessages: intels, isFetchingMore: false));
      }
    } catch (e) {
      Logger.error("refreshIntels error: $e");
    } finally {
      emit(state.copyWith(isFetchingMore: false));
    }
  }
}
