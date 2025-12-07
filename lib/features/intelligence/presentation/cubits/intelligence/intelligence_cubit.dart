import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/intelligence_entity.dart';
import '../../../domain/repositories/intelligence_repository.dart';
import '../../../application/usecases/manage_agent_subscription.dart';
import '../../../application/usecases/manage_realtime_connection.dart';
import '../../../application/usecases/subscribe_realtime_intelligence.dart';
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
class IntelligenceCubit extends Cubit<IntelligenceState> {
  final ManageRealtimeConnection _manageConnection;
  final SubscribeRealtimeIntelligence _subscribeRealtime;
  final ManageAgentSubscription _manageSubscription;

  // Sub-cubits for coordination
  final EventListCubit _eventListCubit;
  final SignalListCubit _signalListCubit;
  final UnreadCubit _unreadCubit;

  // Subscriptions
  StreamSubscription<RealtimeConnectionStatus>? _connectionStatusSubscription;
  StreamSubscription<IntelligenceEntity>? _realtimeDataSubscription;

  IntelligenceCubit({
    required ManageRealtimeConnection manageConnection,
    required SubscribeRealtimeIntelligence subscribeRealtime,
    required ManageAgentSubscription manageSubscription,
    required EventListCubit eventListCubit,
    required SignalListCubit signalListCubit,
    required UnreadCubit unreadCubit,
  })  : _manageConnection = manageConnection,
        _subscribeRealtime = subscribeRealtime,
        _manageSubscription = manageSubscription,
        _eventListCubit = eventListCubit,
        _signalListCubit = signalListCubit,
        _unreadCubit = unreadCubit,
        super(IntelligenceState.initial());

  /// Initialize the intelligence feature
  ///
  /// This should be called when entering the intelligence screen.
  Future<void> initialize({List<String>? agentIds}) async {
    // Listen to connection status
    _connectionStatusSubscription?.cancel();
    _connectionStatusSubscription = _manageConnection.statusStream.listen(
      _onConnectionStatusChanged,
    );

    // Listen to realtime data
    _realtimeDataSubscription?.cancel();
    _realtimeDataSubscription = _subscribeRealtime().listen(
      _onRealtimeData,
    );

    // Connect to realtime service
    if (state.realtimeEnabled) {
      await connectRealtime(agentIds: agentIds);
    }

    // Load initial data for both lists
    await Future.wait([
      _eventListCubit.loadInitial(),
      _signalListCubit.loadInitial(),
    ]);
  }

  /// Connect to realtime WebSocket service
  Future<void> connectRealtime({List<String>? agentIds}) async {
    try {
      emit(state.copyWith(connectionError: null));
      await _manageConnection.connect(agentIds: agentIds);

      if (agentIds != null && agentIds.isNotEmpty) {
        emit(state.copyWith(subscribedAgentIds: agentIds));
      }
    } catch (e) {
      emit(state.copyWith(connectionError: e.toString()));
    }
  }

  /// Disconnect from realtime service
  Future<void> disconnectRealtime() async {
    await _manageConnection.disconnect();
  }

  /// Subscribe to specific agents
  void subscribeToAgents(List<String> agentIds) {
    _manageSubscription.subscribeAll(agentIds);

    final updatedIds = {...state.subscribedAgentIds, ...agentIds}.toList();
    emit(state.copyWith(subscribedAgentIds: updatedIds));
  }

  /// Unsubscribe from specific agents
  void unsubscribeFromAgents(List<String> agentIds) {
    for (final agentId in agentIds) {
      _manageSubscription.unsubscribe(agentId);
    }

    final updatedIds = state.subscribedAgentIds
        .where((id) => !agentIds.contains(id))
        .toList();
    emit(state.copyWith(subscribedAgentIds: updatedIds));
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
      connectRealtime(agentIds: state.subscribedAgentIds);
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

  /// Handle connection status changes
  void _onConnectionStatusChanged(RealtimeConnectionStatus status) {
    emit(state.copyWith(
      connectionStatus: status,
      lastConnectedAt:
          status == RealtimeConnectionStatus.connected ? DateTime.now() : null,
    ));
  }

  /// Handle incoming realtime data
  void _onRealtimeData(IntelligenceEntity item) {
    // Distribute to appropriate sub-cubit based on type
    if (item.isEventType) {
      _eventListCubit.addRealtimeItem(item);

      // Add to unread if not on events tab
      if (!state.isEventsTab) {
        _unreadCubit.addUnread(item);
      }
    } else if (item.isRadarSignal) {
      _signalListCubit.addRealtimeItem(item);

      // Add to unread if not on signals tab
      if (!state.isSignalsTab) {
        _unreadCubit.addUnread(item);
      }
    }
  }

  /// Clean up resources
  @override
  Future<void> close() async {
    await _connectionStatusSubscription?.cancel();
    await _realtimeDataSubscription?.cancel();
    await disconnectRealtime();
    return super.close();
  }
}
