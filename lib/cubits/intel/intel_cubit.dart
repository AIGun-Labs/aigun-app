import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constant/count.dart';
import '../../core/constant/intel_type.dart';
import '../../core/enums/intel.dart';
import '../../core/polling/polling_service.dart';
import '../../core/service_locator.dart';
import '../../data/models/intel/intel.dart';
import '../../data/models/options/single_type/single_type.dart';
import '../../data/services/api/intel_api.dart';
import '../../data/services/sentry_service.dart';
import '../../data/services/ws/websocket_service.dart';
import '../../shared/utils/safe_request.dart';
import '../../utils/logger.dart';
import '../options/option_cubit.dart';
import '../options/options_state.dart';
import 'intel_state.dart';

/// Intel数据Cubit，负责处理Intel页面的数据流
class IntelCubit extends Cubit<IntelState> {
  final IntelApi _intelApi;
  final WebSocketService _webSocketService; // WebSocket 服务
  final OptionsCubit _optionsCubit; // Options Cubit 用于获取 singleTypeOptions
  late final StreamSubscription<OptionsState>? _optionsSubscription;
  StreamSubscription? _webSocketStateSubscription; // 监听WebSocket状态变化
  StreamSubscription? _webSocketSubscription; // 监听WebSocket消息

  PollingService<Map<String, List<Entity>>>? _pollingService;

  IntelCubit({
    WebSocketService? webSocketService,
    IntelApi? intelApi,
    required OptionsCubit optionsCubit,
  }) : _webSocketService =
           webSocketService ?? WebSocketService('ws/v1/intelligence/'),
       _intelApi = intelApi ?? getIt<IntelApi>(),
       _optionsCubit = optionsCubit,
       super(IntelState.initial) {
    _initialize(); // 初始化Cubit
  }

  void reset() {
    Logger.debug('StackTrace: ${StackTrace.current}');
    emit(IntelState.initial);
  }

  void startPollingTokensByIntelIds() {
    _pollingService?.stop();
    _pollingService = PollingService<Map<String, List<Entity>>>(
      baseInterval: const Duration(seconds: THREE),
      maxInterval: const Duration(seconds: FIVE),
      fetcher: (cancel) async {
        final tokensMap = await getTokensByIntelIds();
        return tokensMap ?? {};
      },
      onError: (error, stack) =>
          Logger.error('getTokensByIntelIds error: $error'),
      onData: (tokensMap) {
        if (tokensMap.isNotEmpty) {
          final updatedAllMessage = _updateListWithTokens(
            state.allMessages ?? [],
            tokensMap,
          );
          final updatedEventIntelligences = _updateListWithTokens(
            state.eventIntelligences,
            tokensMap,
          );
          final updatedSingleIntelligences = _updateListWithTokens(
            state.singleIntelligences,
            tokensMap,
          );

          emit(
            state.copyWith(
              allMessages: updatedAllMessage,
              eventIntelligences: updatedEventIntelligences,
              singleIntelligences: updatedSingleIntelligences,
            ),
          );
        }
      },
    )..start();
  }

  void stopPollingTokensByIntelIds() {
    _pollingService?.stop();
  }

  void _subscriptionStream() {
    _optionsSubscription = _optionsCubit.stream.listen((state) {
      emit(
        this.state.copyWith(singleTypeOptions: state.singleTypeOptions ?? []),
      );
    });
  }

  /// 初始化Cubit
  Future<void> _initialize() async {
    _subscriptionStream();
    if (!state.isConnected) {
      await connectWebSocket(); // 连接WebSocket
    }

    startPollingTokensByIntelIds();

    Future.wait([
      getEventIntelligence(),
      getSingleIntelligence(state.singleId),
    ], eagerError: false);
  }

  /// 建立WebSocket连接
  Future<void> connectWebSocket() async {
    // 清理旧的监听
    _disposeWebSocketListeners();

    // 设置新的监听
    // 监听 WebSocket 状态变化
    _webSocketStateSubscription = _webSocketService.statusController.stream
        .listen(_handleWebSocketStateChange);
    // 监听 WebSocket 消息
    _webSocketSubscription = _webSocketService.messageController.stream.listen(
      _handleWebSocketMessage,
    );

    // 连接WebSocket
    _webSocketService.connect();
  }

  /// 处理WebSocket状态变化?
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
    _webSocketService.sendMessage({
      'type': 'init',
      'data': {
        'subscriptions':
            '01998e06-f10d-7156-b69c-99c03ea836bc#01998e06-f10d-7156-b69c-9db854d882fe#01998e06-f10d-7156-b69c-a2e777a1248c#01998e06-f10d-7156-b69c-aa9c4e2a4791#01998e06-f10d-7156-b69c-a43104ec96af',
      },
    });
  }

  void addVisibleId(String id) {
    if (state.visibleIds.contains(id)) return;
    final updatedVisibleIds = [...state.visibleIds, id];
    removeUnreadIntel(id);
    emit(state.copyWith(visibleIds: updatedVisibleIds));
  }

  void removeVisibleId(String id) {
    // 在这里可以删除新消息
    final updatedVisibleIds = state.visibleIds
        .where((visibleId) => visibleId != id)
        .toList();
    emit(state.copyWith(visibleIds: updatedVisibleIds));
  }

  /// 判断指定ID是否为未读状态
  bool isUnread(String? id) {
    return id != null && state.unreadIntels.any((intel) => intel.id == id);
  }

  Future<void> getIntelsHistory({bool forceRefresh = false}) async {
    if (state.isFetchingMore) {
      return;
    }

    if (state.isNotMore && !forceRefresh) {
      return;
    }

    if (forceRefresh) {
      emit(
        state.copyWith(eventPage: 1, isNotMore: false, isFetchingMore: true),
      );
    } else {
      emit(state.copyWith(isFetchingMore: true));
    }

    try {
      final currentPage = forceRefresh ? 1 : state.eventPage;
      final intels = await _intelApi.getIntelsHistory(
        currentPage,
        type: IntelQueryType.event.type,
        pageSize: state.eventPageSize,
      );

      if (intels.isEmpty) {
        emit(state.copyWith(isNotMore: true, isFetchingMore: false));
      } else {
        final currentMessages = forceRefresh
            ? <Intel>[]
            : (state.allMessages ?? []);
        final nextPage = currentPage + 1;
        final newMessages = [...currentMessages, ...intels];

        emit(
          state.copyWith(
            allMessages: newMessages,
            eventPage: nextPage,
            isNotMore: false,
            isFetchingMore: false,
          ),
        );
      }
    } catch (e, s) {
      await SentryService().reportError(
        e,
        s,
        tags: {'feature': 'getIntelsHistory'},
        extra: {
          'eventPage': state.eventPage,
          'eventPageSize': state.eventPageSize,
        },
      );
      emit(state.copyWith(isFetchingMore: false));
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

    final eventIntelligence = await safeRequest(
      () => _intelApi.getIntelsHistory(
        state.eventPage,
        type: IntelQueryType.event.type,
        pageSize: state.eventPageSize,
      ),
      onError: (e, s) {
        Logger.error('getEventIntelligence error: $e');
      },
    );

    if (eventIntelligence != null && eventIntelligence.isNotEmpty) {
      final currentEventIntelligence = state.eventIntelligences;
      final nextPage = state.eventPage + 1;

      final newEventIntelligences = [
        ...currentEventIntelligence,
        ...eventIntelligence,
      ];

      emit(
        state.copyWith(
          isNotMore: false,
          isFetchingMore: false,
          eventIntelligences: newEventIntelligences,
          eventPage: nextPage,
        ),
      );
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

    final singleIntelligences = await safeRequest(
      () => _intelApi.getIntelsHistory(
        state.singlePage,
        type: IntelQueryType.radarSignal.type,
        pageSize: state.singlePageSize,
        chainSingle: state.singleId,
      ),
    );

    if (singleIntelligences != null && singleIntelligences.isNotEmpty) {
      final currentSingleIntelligences = state.singleIntelligences;
      final nextPage = state.singlePage + 1;

      final newSingleIntelligences = [
        ...currentSingleIntelligences,
        ...singleIntelligences,
      ];

      emit(
        state.copyWith(
          isNotMore: false,
          isFetchingSingleMore: false,
          singleIntelligences: newSingleIntelligences,
          singlePage: nextPage,
        ),
      );
    } else {
      emit(state.copyWith(isNotSingleMore: true, isFetchingSingleMore: false));
    }
  }

  void updateShowUnreadBar(bool showUnreadBar) {
    emit(state.copyWith(showUnreadBar: showUnreadBar));
  }

  void updateSingleId(String singleId) {
    if (state.singleId == singleId) {
      return;
    }

    emit(state.copyWith(singleId: singleId, singleIntelligences: []));
    refreshSingleIntelligence();
  }

  //  change return type to return the map directly
  Future<Map<String, List<Entity>>?> getTokensByIntelIds() async {
    if (state.visibleIds.isEmpty) return null;

    try {
      final tokensMap = await _intelApi.getTokensByIntelIds(state.visibleIds);
      return tokensMap;
    } catch (e, s) {
      SentryService().reportError(e, s);
      Logger.error('getTokensByIntelIds error: $e');
      return null;
    }
  }

  // Helper method to update a list of Intel with new tokens
  List<Intel> _updateListWithTokens(
    List<Intel> currentList,
    Map<String, List<Entity>> tokensMap,
  ) {
    bool listChanged = false;

    final updatedList = currentList.map((intel) {
      final entityId = intel.id;

      if (entityId != null && tokensMap.containsKey(entityId)) {
        final newTokens = tokensMap[entityId];
        if (newTokens != null) {
          if (const DeepCollectionEquality().equals(
            intel.entities,
            newTokens,
          )) {
            return intel;
          }

          listChanged = true;
          return intel.copyWith(entities: newTokens);
        }
      }
      return intel;
    }).toList();

    return listChanged ? updatedList : currentList;
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
            'intel_cubit 225 line _handleWebSocketMessage Method',
          ),
        );
        return;
      }

      if (message['type'] == 'message') {
        // 处理正常的数据消息
        final Map<String, dynamic> jsonData = Map<String, dynamic>.from(
          message,
        );

        // 将消息解析为IntelMessageData类型
        final IntelMessage intelMessageData = IntelMessage.fromJson(jsonData);

        if (intelMessageData.data != null &&
            intelMessageData.data?.id != null) {
          final intel = intelMessageData.data!;

          // 保持原有allMessages 更新逻辑
          _updateAllMessages(intel);

          // 根据 intel 的type 字段进行分类处理
          final intelType = intel.type;

          if (IntellgenceTypes.EVENT_LIST.contains(intelType)) {
            _updateEventIntelligences(intel);
          } else if (IntellgenceTypes.RADAR_SIGNAL == intelType) {
            _updateSingleIntelligences(intel);
          }

          // addUnreadId(intel.id!);
          addUnreadIntel(intel);

          // await getIt<TrendingCubit>().getLastestTokens();
          Logger.debug('已添加新消息到暂存区: $intel');
        } else {
          await SentryService().reportError(
            'Received a WebSocket message error',
            StackTrace.fromString(
              'intel_cubit: 246 line _handleWebSocketMessage Method',
            ),
          );
          Logger.error('收到WebSocket消息但data为空: $jsonData');
        }
      }
    } catch (e, s) {
      await SentryService().reportError('handle websocket intel error $e', s);
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

  /// 追加消息到事件情报列表
  void _updateEventIntelligences(Intel newIntel) {
    final currentEventIntelligences = state.eventIntelligences;
    final updatedEventIntelligences = [newIntel, ...currentEventIntelligences];
    emit(state.copyWith(eventIntelligences: updatedEventIntelligences));
  }

  /// 追加消息到链上信号列表（需要判断pushFilter）
  void _updateSingleIntelligences(Intel newIntel) {
    if (!_shouldAddToSingleIntelligences(newIntel)) {
      return;
    }

    final currentSingleIntelligences = state.singleIntelligences;
    final updatedSingleIntelligences = [
      newIntel,
      ...currentSingleIntelligences,
    ];
    emit(state.copyWith(singleIntelligences: updatedSingleIntelligences));
  }

  /// 判断是否应该将消息添加到 singleIntelligences
  bool _shouldAddToSingleIntelligences(Intel intel) {
    // singleId 为'all' 时接收所有radar_signal
    if (state.singleId == 'all') return true;

    // 查找当前 singleId 对应的pushFilter
    final option = state.singleTypeOptions
        .cast<SingleTypeOptions?>()
        .firstWhere((opt) => opt?.slug == state.singleId, orElse: () => null);

    // 找不到匹配或 pushFilter 为空，忽略消息
    if (option == null || option.pushFilter == null) return false;

    // 判断 ai_agent.name.en 是否匹配 pushFilter
    return intel.aiAgent?.name?['en'] == option.pushFilter;
  }

  void updateEventPage(int eventPage) {
    emit(state.copyWith(eventPage: eventPage));
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
    _optionsSubscription?.cancel();
    _webSocketService.dispose();
    stopPollingTokensByIntelIds();
    disconnectWebSocket();
    return super.close();
  }

  /// 刷新情报列表（重置所有状态并重新加载第一页）
  Future<void> refreshIntels() async {
    // 防止重复请求
    if (state.isFetchingMore) {
      return;
    }

    // 缓存旧数据，以便在失败时恢复
    final oldMessages = state.allMessages;

    // 设置加载状态，但不清空数据
    emit(state.copyWith(isFetchingMore: true));

    try {
      final intels = await _intelApi.getIntelsHistory(
        1,
        type: IntelQueryType.radarSignal.type,
        pageSize: state.singlePageSize,
      );

      if (intels.isEmpty) {
        emit(
          state.copyWith(
            isNotMore: oldMessages?.isEmpty ?? true,
            isFetchingMore: false,
          ),
        );
      } else {
        emit(
          state.copyWith(
            allMessages: intels,
            eventPage: 2,
            isNotMore: false,
            isFetchingMore: false,
            visibleIds: [],
            unreadIntels: [], // 清空未读列表，因为刷新后所有消息都是已读的
          ),
        );
      }
    } catch (e, s) {
      await SentryService().reportError(
        'refresh intels error: $e',
        s,
        tags: {'feature': 'refreshIntels'},
      );
      Logger.error('refreshIntels error: $e');
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

    final eventIntelligences = await safeRequest(
      () => _intelApi.getIntelsHistory(
        1,
        type: IntelQueryType.event.type,
        pageSize: state.eventPageSize,
      ),
    );

    if (eventIntelligences != null && eventIntelligences.isNotEmpty) {
      emit(
        state.copyWith(
          eventIntelligences: eventIntelligences,
          eventPage: 2,
          isNotMore: false,
          isFetchingMore: false,
          visibleIds: [],
          unreadIntels: [],
        ),
      );
    } else {
      emit(state.copyWith(isFetchingMore: false));
    }
  }

  Future<void> refreshSingleIntelligence() async {
    if (state.isFetchingSingleMore) {
      return;
    }

    emit(state.copyWith(isFetchingSingleMore: true));

    final singleIntelligences = await safeRequest(
      () => _intelApi.getIntelsHistory(
        1,
        type: IntelQueryType.radarSignal.type,
        chainSingle: state.singleId,
        pageSize: state.singlePageSize,
      ),
    );

    if (singleIntelligences != null && singleIntelligences.isNotEmpty) {
      emit(
        state.copyWith(
          singleIntelligences: singleIntelligences,
          singlePage: 2,
          isNotSingleMore: false,
          isFetchingSingleMore: false,
          visibleIds: [],
          unreadIntels: [],
          // unreadIds: [],
        ),
      );
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
      'data': {'subset_id': subsetId},
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
      'data': {'subset_id': subsetId},
    });
  }

  void addUnreadIntel(Intel intel) {
    // 避免重复添加
    if (state.unreadIntels.any((element) => element.id == intel.id)) return;

    final updatedUnreadIntels = [...state.unreadIntels, intel];

    emit(state.copyWith(unreadIntels: updatedUnreadIntels));
  }

  void removeUnreadIntel(String? id) {
    if (id == null) return;

    final updatedUnreadIntels = state.unreadIntels
        .where((intel) => intel.id != id)
        .toList();
    emit(state.copyWith(unreadIntels: updatedUnreadIntels));
  }

  // 清除特定类型的未读消息
  void clearUnreadIntels({bool Function(Intel intel)? filter}) {
    if (filter == null) {
      emit(state.copyWith(unreadIntels: []));
    } else {
      // 只保留不符合 filter 条件的消息
      final remaining = state.unreadIntels.where((i) => !filter(i)).toList();
      emit(state.copyWith(unreadIntels: remaining));
    }
  }

  bool isExistsUnreadIntel(String? id) =>
      state.unreadIntels.where((intel) => intel.id == id).isNotEmpty;
}
