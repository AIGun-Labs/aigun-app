import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/polling/polling_service.dart';
import '../../../../../core/types/result.dart';
import '../../../../../utils/logger.dart';
import '../../../application/usecases/fetch_intelligence_tokens.dart';
import '../../../application/usecases/manage_realtime_connection.dart';
import '../../../application/usecases/subscribe_realtime_intelligence.dart';
import '../../../domain/entities/intelligence_entity.dart';
import '../../../domain/entities/token_entity.dart';
import '../../../domain/repositories/intelligence_repository.dart';
import '../event_list/event_list_cubit.dart';
import '../signal_list/signal_list_cubit.dart';
import '../unread/unread_cubit.dart';
import 'intelligence_state.dart';

/// Intelligence Cubit
///
/// Main coordinator cubit that manages:
/// - WebSocket connection lifecycle
/// - Realtime data distribution to sub-cubits
/// - Tab switching
/// - Agent subscription management
/// - Token polling for visible items
class IntelligenceCubit extends Cubit<IntelligenceState> {
  final ManageRealtimeConnection _manageConnection;
  final SubscribeRealtimeIntelligence _subscribeRealtime;
  final FetchIntelligenceTokens _fetchTokens;

  // Sub-cubits for coordination
  final EventListCubit _eventListCubit;
  final SignalListCubit _signalListCubit;
  final UnreadCubit _unreadCubit;

  // Subscriptions
  StreamSubscription<RealtimeConnectionStatus>? _connectionStatusSubscription;
  StreamSubscription<IntelligenceEntity>? _realtimeDataSubscription;

  // Token polling service
  PollingService<Map<String, List<TokenEntity>>>? _tokenPollingService;

  /// Token polling interval (default: 3 seconds)
  static const Duration _pollingInterval = Duration(seconds: 3);

  /// Max polling interval for backoff (default: 5 seconds)
  static const Duration _maxPollingInterval = Duration(seconds: 5);

  /// Initial agent IDs to subscribe on connect
  // TODO: Replace with dynamic agent IDs from user settings or API
  static const List<String> _initialSubscriptions = [
    '01998e06-f10d-7156-b69c-99c03ea836bc',
    '01998e06-f10d-7156-b69c-9db854d882fe',
    '01998e06-f10d-7156-b69c-a2e777a1248c',
    '01998e06-f10d-7156-b69c-aa9c4e2a4791',
    '01998e06-f10d-7156-b69c-a43104ec96af',
  ];

  IntelligenceCubit({
    required ManageRealtimeConnection manageConnection,
    required SubscribeRealtimeIntelligence subscribeRealtime,
    required FetchIntelligenceTokens fetchTokens,
    required EventListCubit eventListCubit,
    required SignalListCubit signalListCubit,
    required UnreadCubit unreadCubit,
  }) : _manageConnection = manageConnection,
       _subscribeRealtime = subscribeRealtime,
       _fetchTokens = fetchTokens,
       _eventListCubit = eventListCubit,
       _signalListCubit = signalListCubit,
       _unreadCubit = unreadCubit,
       super(IntelligenceState.initial());

  /// Initialize the intelligence feature
  ///
  /// This should be called when entering the intelligence screen.
  Future<void> initialize() async {
    // Listen to connection status
    _connectionStatusSubscription?.cancel();
    _connectionStatusSubscription = _manageConnection.statusStream.listen(
      _onConnectionStatusChanged,
    );

    // Listen to realtime data
    _realtimeDataSubscription?.cancel();
    _realtimeDataSubscription = _subscribeRealtime().listen(_onRealtimeData);

    // Connect to realtime service (receives all messages by default)
    if (state.realtimeEnabled) {
      await connectRealtime();
    }

    // Start token polling
    startTokenPolling();

    // Load initial data for both lists
    await Future.wait([
      _eventListCubit.loadInitial(),
      _signalListCubit.loadInitial(),
    ]);
  }

  /// Connect to realtime WebSocket service
  ///
  /// Sends init subscription with agent IDs on connect.
  Future<void> connectRealtime() async {
    try {
      emit(state.copyWith(connectionError: null));
      await _manageConnection.connect(
        initialSubscriptions: _initialSubscriptions,
      );
    } catch (e) {
      emit(state.copyWith(connectionError: e.toString()));
    }
  }

  /// Disconnect from realtime service
  Future<void> disconnectRealtime() async {
    await _manageConnection.disconnect();
  }

  /// Change active tab
  void changeTab(int index) {
    if (index == state.activeTabIndex) return;

    emit(state.copyWith(activeTabIndex: index));

    // Clear unread for the tab being viewed
    if (index == 0) {
      _unreadCubit.clearEventUnread();
    } else if (index == 1) {
      _unreadCubit.clearSignalUnread();
    }
  }

  /// Toggle realtime feature
  void toggleRealtime(bool enabled) {
    emit(state.copyWith(realtimeEnabled: enabled));

    if (enabled && !state.isConnected) {
      connectRealtime();
    } else if (!enabled && state.isConnected) {
      disconnectRealtime();
    }
  }

  /// Refresh current tab data
  Future<void> refreshCurrentTab() async {
    if (state.isEventsTab) {
      await _eventListCubit.refresh();
    } else {
      await _signalListCubit.refresh();
    }
  }

  /// Load more for current tab
  Future<void> loadMoreCurrentTab() async {
    if (state.isEventsTab) {
      await _eventListCubit.loadMore();
    } else {
      await _signalListCubit.loadMore();
    }
  }

  // ============ Token Polling ============

  /// Start token polling for visible items
  void startTokenPolling() {
    stopTokenPolling();

    _tokenPollingService = PollingService<Map<String, List<TokenEntity>>>(
      baseInterval: _pollingInterval,
      maxInterval: _maxPollingInterval,
      fetcher: _fetchVisibleTokens,
      onData: _onTokensFetched,
      onError: (error, stack) {
        Logger.error('IntelligenceCubit: getTokensByIntelIds error: $error');
      },
    )..start();
  }

  /// Stop token polling
  void stopTokenPolling() {
    _tokenPollingService?.stop();
    _tokenPollingService = null;
  }

  /// Fetch tokens for all visible items from both lists
  Future<Map<String, List<TokenEntity>>> _fetchVisibleTokens(
    CancelToken cancelToken,
  ) async {
    // Collect visible IDs from both cubits
    final eventVisibleIds = _eventListCubit.state.visibleIds;
    final signalVisibleIds = _signalListCubit.state.visibleIds;

    final allVisibleIds = <String>{...eventVisibleIds, ...signalVisibleIds};

    if (allVisibleIds.isEmpty) {
      return {};
    }

    final result = await _fetchTokens(allVisibleIds.toList());

    return result.maybeWhen(
      success: (tokensMap) => tokensMap,
      orElse: () => {},
    );
  }

  /// Handle fetched tokens - distribute to appropriate cubits
  void _onTokensFetched(Map<String, List<TokenEntity>> tokensMap) {
    if (tokensMap.isEmpty) return;

    // Update tokens in both cubits
    _eventListCubit.updateTokens(tokensMap);
    _signalListCubit.updateTokens(tokensMap);
  }

  // ============ Connection & Realtime ============

  /// Handle connection status changes
  void _onConnectionStatusChanged(RealtimeConnectionStatus status) {
    emit(
      state.copyWith(
        connectionStatus: status,
        lastConnectedAt: status == RealtimeConnectionStatus.connected
            ? DateTime.now()
            : null,
      ),
    );
  }

  /// Handle incoming realtime data
  void _onRealtimeData(IntelligenceEntity item) {
    // Distribute to appropriate sub-cubit based on type
    if (item.isEventType) {
      // Check if item already exists in list (avoid duplicate unread toast)
      final alreadyExists =
          _eventListCubit.state.items.any((i) => i.id == item.id);

      // Check if user is at the top of the list (first item is visible)
      final isAtTop = _eventListCubit.state.items.isNotEmpty &&
          _eventListCubit.state.visibleIds
              .contains(_eventListCubit.state.items.first.id);

      _eventListCubit.addRealtimeItem(item);

      // Add to unread only if it's a new item, on events tab, and not at top
      if (state.isEventsTab && !alreadyExists && !isAtTop) {
        _unreadCubit.addUnread(item);
      }
    } else if (item.isRadarSignal) {
      // Check if item will be added to the list (respecting chain filter)
      final signalState = _signalListCubit.state;
      final willBeAdded = signalState.chainId == 'all' ||
          signalState.pushFilter == null ||
          item.aiAgent?.englishName == signalState.pushFilter;

      if (!willBeAdded) return; // Skip if won't be shown in current filter

      // Check if item already exists in list (avoid duplicate unread toast)
      final alreadyExists = signalState.items.any((i) => i.id == item.id);

      // Check if user is at the top of the list (first item is visible)
      final isAtTop = signalState.items.isNotEmpty &&
          signalState.visibleIds.contains(signalState.items.first.id);

      _signalListCubit.addRealtimeItem(item);

      // Add to unread only if it's a new item, on signals tab, and not at top
      if (state.isSignalsTab && !alreadyExists && !isAtTop) {
        _unreadCubit.addUnread(item);
      }
    }
  }

  /// Clean up resources
  @override
  Future<void> close() async {
    await _connectionStatusSubscription?.cancel();
    await _realtimeDataSubscription?.cancel();
    stopTokenPolling();
    await disconnectRealtime();
    return super.close();
  }
}
