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
import '../../data/services/ws/websocket_service.dart';
import '../../shared/utils/safe_request.dart';
import '../../utils/logger.dart';
import '../options/option_cubit.dart';
import 'intel_state.dart';

class IntelCubit extends Cubit<IntelState> {
  final IntelApi _intelApi;
  final WebSocketService _webSocketService;
  final OptionsCubit _optionsCubit;
  StreamSubscription? _webSocketStateSubscription;
  StreamSubscription? _webSocketSubscription;

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
    _initialize();
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

  Future<void> _initialize() async {
    emit(
      state.copyWith(
        singleTypeOptions: _optionsCubit.state.singleTypeOptions ?? [],
      ),
    );

    if (!state.isConnected) {
      await connectWebSocket();
    }

    Future.wait([
      getEventIntelligence(),
      getSingleIntelligence(state.singleId),
    ], eagerError: false);
  }

  Future<void> connectWebSocket() async {
    _disposeWebSocketListeners();

    _webSocketStateSubscription = _webSocketService.statusController.stream
        .listen(_handleWebSocketStateChange);

    _webSocketSubscription = _webSocketService.messageController.stream.listen(
      _handleWebSocketMessage,
    );

    _webSocketService.connect();
  }

  void _handleWebSocketStateChange(ConnectionStatus connectionState) {
    //
    final isConnected = connectionState == ConnectionStatus.connected;
    emit(state.copyWith(isConnected: isConnected));

    if (isConnected) {
      // _webSocketService.subscribe();
      _sendSubscription();
    }
  }

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
    final updatedVisibleIds = state.visibleIds
        .where((visibleId) => visibleId != id)
        .toList();
    emit(state.copyWith(visibleIds: updatedVisibleIds));
  }

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

  void _handleWebSocketMessage(dynamic message) async {
    try {
      if (message is! Map) return;

      if (message['type'] == 'welcome') {
        Logger.debug('WebSocket - ');
        return;
      }

      if (message['type'] == 'pong') return;

      if (message['type'] == 'follow_agent' ||
          message['type'] == 'unfollow_agent') {
        final messageText = message['message'];
        if (messageText == 'success') {
          Logger.debug('${message['type']} : ${message['data']}');
        }
        return;
      }

      if (message['type'] == 'error') {
        return;
      }

      if (message['type'] == 'message') {
        final Map<String, dynamic> jsonData = Map<String, dynamic>.from(
          message,
        );

        final IntelMessage intelMessageData = IntelMessage.fromJson(jsonData);

        if (intelMessageData.data != null &&
            intelMessageData.data?.id != null) {
          final intel = intelMessageData.data!;

          _updateAllMessages(intel);

          final intelType = intel.type;

          if (IntellgenceTypes.EVENT_LIST.contains(intelType)) {
            _updateEventIntelligences(intel);
          } else if (IntellgenceTypes.RADAR_SIGNAL == intelType) {
            _updateSingleIntelligences(intel);
          }

          // addUnreadId(intel.id!);
          addUnreadIntel(intel);

          // await getIt<TrendingCubit>().getLastestTokens();
          Logger.debug(': $intel');
        } else {
          Logger.error('WebSocketdata: $jsonData');
        }
      }
    } catch (e, s) {}
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

  void _updateEventIntelligences(Intel newIntel) {
    final currentEventIntelligences = state.eventIntelligences;
    final updatedEventIntelligences = [newIntel, ...currentEventIntelligences];
    emit(state.copyWith(eventIntelligences: updatedEventIntelligences));
  }

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

  bool _shouldAddToSingleIntelligences(Intel intel) {
    if (state.singleId == 'all') return true;

    final option = state.singleTypeOptions
        .cast<SingleTypeOptions?>()
        .firstWhere((opt) => opt?.slug == state.singleId, orElse: () => null);

    if (option == null || option.pushFilter == null) return false;

    return intel.aiAgent?.name?['en'] == option.pushFilter;
  }

  void updateEventPage(int eventPage) {
    emit(state.copyWith(eventPage: eventPage));
  }

  void reconnectWebSocket() => _webSocketService.connect();

  void disconnectWebSocket() {
    _webSocketService.disconnect();
    emit(state.copyWith(isConnected: false));
  }

  void clearError() => emit(state.copyWith(errorMessage: ''));

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

  Future<void> refreshIntels() async {
    if (state.isFetchingMore) {
      Logger.debug('refreshIntels: ，');
      return;
    }

    final oldMessages = state.allMessages;

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
            unreadIntels: [],
          ),
        );
      }
    } catch (e, s) {
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

    if (state.isNotSingleMore) {
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
          isNotMore: false,
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

  Future<void> sendFollowAgent(String subsetId) async {
    if (!state.isConnected) {
      await connectWebSocket();

      await Future.delayed(const Duration(milliseconds: 500));
    }

    _webSocketService.sendMessage({
      'type': 'follow_agent',
      'data': {'subset_id': subsetId},
    });
  }

  Future<void> sendUnfollowAgent(String subsetId) async {
    if (!state.isConnected) {
      await connectWebSocket();

      await Future.delayed(const Duration(milliseconds: 500));
    }

    _webSocketService.sendMessage({
      'type': 'unfollow_agent',
      'data': {'subset_id': subsetId},
    });
  }

  void addUnreadIntel(Intel intel) {
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

  void clearUnreadIntels({bool Function(Intel intel)? filter}) {
    if (filter == null) {
      emit(state.copyWith(unreadIntels: []));
    } else {
      final remaining = state.unreadIntels.where((i) => !filter(i)).toList();
      emit(state.copyWith(unreadIntels: remaining));
    }
  }

  bool isExistsUnreadIntel(String? id) =>
      state.unreadIntels.where((intel) => intel.id == id).isNotEmpty;
}
