import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constant/count.dart';
import '../../core/enums/intel.dart';
import '../../core/polling/polling_service.dart';
import '../../core/service_locator.dart';
import '../../data/models/intel/intel.dart';
import '../../data/services/api/intel_api.dart';
import '../../data/services/api/monitor_api.dart';
import '../../data/services/sentry_service.dart';
import '../../data/services/ws/websocket_service.dart';
import '../../shared/utils/safe_request.dart';
import '../../utils/logger.dart';
import '../../utils/numeric_utils.dart';
import '../../utils/storage/secure/user_storage_service.dart';
import '../trending/trending_cubit.dart';
import 'intel_state.dart';

/// Intel数据Cubit，负责处理Intel页面的数据流
class IntelCubit extends Cubit<IntelState> {
  final IntelApi _intelApi;
  final MonitorApi _monitorApi;
  final WebSocketService _webSocketService; // WebSocket 服务
  StreamSubscription? _webSocketStateSubscription; // 监听WebSocket状态变化
  StreamSubscription? _webSocketSubscription; // 监听WebSocket消息

  PollingService<List<Intel>>? _pollingService;

  IntelCubit({
    MonitorApi? monitorApi,
    WebSocketService? webSocketService,
    IntelApi? intelApi,
  })  : _monitorApi = monitorApi ?? MonitorApi(),
        _webSocketService =
            webSocketService ?? WebSocketService('ws/v1/intelligence/'),
        _intelApi = intelApi ?? IntelApi(),
        super(IntelState.initial) {
    _initialize(); // 初始化 Cubit
  }

  void reset() {
    Logger.debug('IntelCubit.reset() called - clearing all data');
    Logger.debug('StackTrace: ${StackTrace.current}');
    emit(IntelState.initial);
  }

  void startPollingTokensByIntelIds() {
    _pollingService?.stop();
    _pollingService = PollingService<List<Intel>>(
      baseInterval: const Duration(seconds: FIVE),
      maxInterval: const Duration(seconds: ONE),
      fetcher: (cancel) async {
        final intels = await getTokensByIntelIds();
        return intels ?? [];
      },
      onData: (intels) {
        if (intels.isNotEmpty) {
          emit(state.copyWith(allMessages: intels));
        }
      },
    )..start();
  }

  void stopPollingTokensByIntelIds() {
    _pollingService?.stop();
  }

  /// 初始化Cubit
  Future<void> _initialize() async {
    if (!state.isConnected) {
      await connectWebSocket(); // 连接WebSocket
    }

//  tokens get every 5 seconds
    _tokenTimer = Timer.periodic(
        Duration(seconds: NumericUtils.getRandomInt(30, 50)), (timer) {
      getTokensByIntelIds();
    });

    Future.wait([
      getEventIntelligence(),
      getSingleIntelligence(state.singleId),
    ], eagerError: false);
  }

  Timer? _tokenTimer;

  /// 建立WebSocket连接
  Future<void> connectWebSocket() async {
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
      _sendSubscription(); // 发送初始化订阅消息
    }
  }

  /// 1.发送WebSocket订阅 init 订阅消息
  Future<void> _sendSubscription() async {
    final userStorage = getIt<UserStorageService>();
    final subscriptions = await userStorage.getUserSubscriptions();

    _webSocketService.sendMessage({
      'type': 'init',
      "data": {
        "subscriptions": subscriptions,
        // "authorization": token.isNotEmpty ? "Bearer $token" : null
      }
    });
  }

  void addVisibleId(String id) {
    final updatedVisibleIds = [...state.visibleIds, id];
    removeUnreadId(id);
    emit(state.copyWith(visibleIds: updatedVisibleIds));
  }

  void removeVisibleId(String id) {
    // 在这里可以删除新消息
    final updatedVisibleIds =
        state.visibleIds.where((visibleId) => visibleId != id).toList();
    emit(state.copyWith(visibleIds: updatedVisibleIds));
  }

  void addUnreadId(String? id) {
    if (id == null || state.unreadIds.contains(id)) return;
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

  Future<void> getIntelsHistory({bool forceRefresh = false}) async {
    if (state.isFetchingMore) {
      return;
    }

    if (state.isNotMore && !forceRefresh) {
      return;
    }

    if (forceRefresh) {
      emit(state.copyWith(
        eventPage: 1,
        isNotMore: false,
        isFetchingMore: true,
      ));
    } else {
      emit(state.copyWith(isFetchingMore: true));
    }

    try {
      final currentPage = forceRefresh ? 1 : state.eventPage;
      final intels = await _intelApi.getIntelsHistory(currentPage,
          type: IntelQueryType.event.type, pageSize: state.eventPageSize);

      if (intels.isEmpty) {
        emit(state.copyWith(
          isNotMore: true,
          isFetchingMore: false,
        ));
      } else {
        final currentMessages =
            forceRefresh ? <Intel>[] : (state.allMessages ?? []);
        final nextPage = currentPage + 1;
        final newMessages = [...currentMessages, ...intels];

        emit(state.copyWith(
          allMessages: newMessages,
          eventPage: nextPage,
          isNotMore: false,
          isFetchingMore: false,
        ));
      }
    } catch (e, s) {
      await SentryService().reportError(e, s, tags: {
        "feature": "getIntelsHistory"
      }, extra: {
        "eventPage": state.eventPage,
        "eventPageSize": state.eventPageSize,
      });
      emit(state.copyWith(
        isFetchingMore: false,
      ));
    }
  }

  Future<void> getEventIntelligence() async {
    if (state.isFetchingMore) {
      return;
    }

    if (state.isNotMore) {
      return;
    }

    emit(state.copyWith(isFetchingMore: true));

    final eventIntelligence = await safeRequest(() =>
        _intelApi.getIntelsHistory(state.eventPage,
            type: IntelQueryType.event.type, pageSize: state.eventPageSize));

    if (eventIntelligence != null && eventIntelligence.isNotEmpty) {
      final currentEventIntelligence = state.eventIntelligences;
      final nextPage = state.eventPage + 1;

      final newEventIntelligences = [
        ...currentEventIntelligence,
        ...eventIntelligence
      ];

      emit(state.copyWith(
          isNotMore: false,
          isFetchingMore: false,
          eventIntelligences: newEventIntelligences,
          eventPage: nextPage));
    } else {
      emit(state.copyWith(isNotMore: true, isFetchingMore: false));
    }
  }

  Future<void> getSingleIntelligence(String? singleId) async {
    if (state.isFetchingSingleMore) {
      return;
    }

    if (state.isNotSingleMore) {
      return;
    }
    emit(state.copyWith(isFetchingSingleMore: true));

    final singleIntelligences = await safeRequest(() =>
        _intelApi.getIntelsHistory(state.singlePage,
            type: IntelQueryType.radarSignal.type,
            pageSize: state.singlePageSize,
            chainSingle: state.singleId));

    if (singleIntelligences != null && singleIntelligences.isNotEmpty) {
      final currentSingleIntelligences = state.singleIntelligences;
      final nextPage = state.singlePage + 1;

      final newSingleIntelligences = [
        ...currentSingleIntelligences,
        ...singleIntelligences
      ];

      emit(state.copyWith(
          isNotMore: false,
          isFetchingSingleMore: false,
          singleIntelligences: newSingleIntelligences,
          singlePage: nextPage));
    } else {
      emit(state.copyWith(isNotSingleMore: true, isFetchingSingleMore: false));
    }
  }

  void updateSingleId(String id) {
    emit(state.copyWith(singleId: id, singleIntelligences: []));
    refreshSingleIntelligence();
  }

// 定时根据 intel ids 获取token 信息
  Future<List<Intel>?> getTokensByIntelIds() async {
    List<Intel> intels = [];
    if (state.visibleIds.isEmpty) return intels;

    try {
      final tokensMap = await _intelApi.getTokensByIntelIds(state.visibleIds);

      // 确保 allMessages 不为 null
      final currentMessages = state.allMessages ?? [];

      intels = currentMessages.map((intel) {
        // 获取当前 intel 的 id
        final String? entityId = intel.id;

        // 如果 entityId 不为空 并且 tokenMap 包含当前 entityId
        if (entityId != null && tokensMap.containsKey(entityId)) {
          // get current intellagence entitys
          final tokens = tokensMap[entityId];
          // 如果 tokens 不为空，则更新 intelligence 的 tokens
          if (tokens != null) {
            // update intelligence  tokens
            return intel.copyWith(entities: tokens);
          }
        }

        return intel;
      }).toList();
    } catch (e, s) {
      await SentryService().reportError(e, s);
      Logger.error('getTokensByIntelIds error: $e');
    }
    return intels;
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

      // 处理关注/取消关注响应
      if (message['type'] == 'follow_agent' ||
          message['type'] == 'unfollow_agent') {
        final messageText = message['message'];
        if (messageText == 'success') {
          Logger.debug('${message['type']} 成功: ${message['data']}');
        }
        return;
      }

      // 处理错误消息
      if (message['type'] == 'error') {
        await SentryService().reportError(
            'WebSocket错误: ${message['message']}',
            StackTrace.fromString(
                "intel_cubit 225 line _handleWebSocketMessage Method"));
        return;
      }

      if (message['type'] == 'message') {
        // 处理正常的数据消息
        final Map<String, dynamic> jsonData =
            Map<String, dynamic>.from(message);

        // 将消息解析为IntelMessageData类型
        final IntelMessage intelMessageData = IntelMessage.fromJson(jsonData);

        if (intelMessageData.data != null &&
            intelMessageData.data?.id != null) {
          _updateAllMessages(intelMessageData.data!);
          addUnreadId(intelMessageData.data?.id!);
          await getIt<TrendingCubit>().getLastestTokens();
          Logger.debug('已添加新消息到暂存区: ${intelMessageData.data}');
        } else {
          await SentryService().reportError(
              "Received a WebSocket message error",
              StackTrace.fromString(
                  "intel_cubit: 246 line _handleWebSocketMessage Method"));
          Logger.error('收到WebSocket消息但data为空: $jsonData');
        }
      }
    } catch (e, s) {
      await SentryService().reportError("handle websocket intel error $e", s);
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

  void updateEventPage(int eventPage) {
    emit(state.copyWith(eventPage: eventPage));
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

  /// 刷新情报列表（重置所有状态并重新加载第一页）
  Future<void> refreshIntels() async {
    // 防止重复请求
    if (state.isFetchingMore) {
      Logger.debug("refreshIntels: 正在加载中，跳过重复请求");
      return;
    }

    // 缓存旧数据，以便在失败时恢复
    final oldMessages = state.allMessages;

    // 设置加载状态，但不清空数据
    emit(state.copyWith(
      isFetchingMore: true,
    ));

    try {
      final intels = await _intelApi.getIntelsHistory(1,
          type: IntelQueryType.radarSignal.type,
          pageSize: state.singlePageSize);

      if (intels.isEmpty) {
        emit(state.copyWith(
          isNotMore: oldMessages?.isEmpty ?? true,
          isFetchingMore: false,
        ));
      } else {
        emit(state.copyWith(
          allMessages: intels,
          eventPage: 2,
          isNotMore: false,
          isFetchingMore: false,
          visibleIds: [],
          unreadIds: [], // 清空未读列表，因为刷新后所有消息都是已读的
        ));
      }
    } catch (e, s) {
      await SentryService().reportError("refresh intels error: $e", s,
          tags: {"feature": "refreshIntels"});
      Logger.error("refreshIntels error: $e");
      // 加载失败时保留原数据
      emit(state.copyWith(isFetchingMore: false));
    }
  }

  Future<void> refreshEventIntelligence() async {
    if (state.isFetchingMore) {
      return;
    }

    if (state.isNotMore) {
      return;
    }

    emit(state.copyWith(isFetchingMore: true));

    final eventIntelligences = await safeRequest(() =>
        _intelApi.getIntelsHistory(1,
            type: IntelQueryType.event.type, pageSize: state.eventPageSize));

    if (eventIntelligences != null && eventIntelligences.isNotEmpty) {
      emit(state.copyWith(
        eventIntelligences: eventIntelligences,
        eventPage: 2,
        isNotMore: false,
        isFetchingMore: false,
        visibleIds: [],
        unreadIds: [],
      ));
    } else {
      emit(state.copyWith(isFetchingMore: false));
    }
  }

  Future<void> refreshSingleIntelligence() async {
    if (state.isFetchingSingleMore) {
      return;
    }

    if (state.isNotSingleMore) {
      return;
    }

    emit(state.copyWith(isFetchingSingleMore: true));

    final singleIntelligences = await safeRequest(() =>
        _intelApi.getIntelsHistory(1,
            type: IntelQueryType.radarSignal.type,
            chainSingle: state.singleId,
            pageSize: state.singlePageSize));

    if (singleIntelligences != null && singleIntelligences.isNotEmpty) {
      emit(state.copyWith(
        singleIntelligences: singleIntelligences,
        singlePage: 2,
        isNotMore: false,
        isFetchingSingleMore: false,
        visibleIds: [],
        unreadIds: [],
      ));
    } else {
      emit(state.copyWith(isFetchingSingleMore: false));
    }
  }

  /// 发送关注订阅消息
  Future<void> sendFollowAgent(String subsetId) async {
    // 如果未连接，先连接
    if (!state.isConnected) {
      await connectWebSocket();
      // 等待连接成功
      await Future.delayed(const Duration(milliseconds: 500));
    }

    _webSocketService.sendMessage({
      'type': 'follow_agent',
      "data": {
        "subset_id": subsetId,
      }
    });
  }

  /// 发送取消关注订阅消息
  Future<void> sendUnfollowAgent(String subsetId) async {
    // 如果未连接，先连接
    if (!state.isConnected) {
      await connectWebSocket();
      // 等待连接成功
      await Future.delayed(const Duration(milliseconds: 500));
    }

    _webSocketService.sendMessage({
      'type': 'unfollow_agent',
      "data": {
        "subset_id": subsetId,
      }
    });
  }
}
