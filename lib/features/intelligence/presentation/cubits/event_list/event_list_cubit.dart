import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/types/result.dart';
import '../../../application/usecases/fetch_event_intelligence.dart';
import '../../../application/usecases/fetch_intelligence_tokens.dart';
import '../../../domain/entities/intelligence_entity.dart';
import '../../../domain/entities/token_entity.dart';
import 'event_list_state.dart';

/// Event List Cubit
///
/// Manages the state of event-type intelligence list.
class EventListCubit extends Cubit<EventListState> {
  final FetchEventIntelligence _fetchEventIntelligence;
  final FetchIntelligenceTokens _fetchIntelligenceTokens;

  EventListCubit({
    required FetchEventIntelligence fetchEventIntelligence,
    required FetchIntelligenceTokens fetchIntelligenceTokens,
  })  : _fetchEventIntelligence = fetchEventIntelligence,
        _fetchIntelligenceTokens = fetchIntelligenceTokens,
        super(EventListState.initial());

  /// Load initial data
  Future<void> loadInitial() async {
    if (state.isLoading) return;

    emit(state.copyWith(
      isLoading: true,
      errorMessage: null,
      page: 1,
      hasReachedEnd: false,
    ));

    final result = await _fetchEventIntelligence(
      page: 1,
      pageSize: state.pageSize,
    );

    result.maybeWhen(
      success: (items) {
        emit(state.copyWith(
          items: items,
          isLoading: false,
          page: 2,
          hasReachedEnd: items.length < state.pageSize,
        ));
      },
      failure: (message) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: message,
        ));
      },
      orElse: () {},
    );
  }

  /// Load more data (pagination)
  Future<void> loadMore() async {
    if (state.isLoading || state.isLoadingMore || state.hasReachedEnd) return;

    emit(state.copyWith(isLoadingMore: true));

    final result = await _fetchEventIntelligence(
      page: state.page,
      pageSize: state.pageSize,
    );

    result.maybeWhen(
      success: (items) {
        emit(state.copyWith(
          items: [...state.items, ...items],
          isLoadingMore: false,
          page: state.page + 1,
          hasReachedEnd: items.length < state.pageSize,
        ));
      },
      failure: (message) {
        emit(state.copyWith(
          isLoadingMore: false,
          errorMessage: message,
        ));
      },
      orElse: () {},
    );
  }

  /// Refresh list
  Future<void> refresh() async {
    emit(state.copyWith(
      page: 1,
      hasReachedEnd: false,
      errorMessage: null,
    ));

    final result = await _fetchEventIntelligence(
      page: 1,
      pageSize: state.pageSize,
    );

    result.maybeWhen(
      success: (items) {
        emit(state.copyWith(
          items: items,
          page: 2,
          hasReachedEnd: items.length < state.pageSize,
          visibleIds: [],
        ));
      },
      failure: (message) {
        emit(state.copyWith(errorMessage: message));
      },
      orElse: () {},
    );
  }

  /// Add a new intelligence item from realtime source
  void addRealtimeItem(IntelligenceEntity item) {
    if (!item.isEventType) return;

    // Check if already exists
    if (state.items.any((i) => i.id == item.id)) return;

    emit(state.copyWith(
      items: [item, ...state.items],
    ));
  }

  /// Update tokens for intelligence items
  ///
  /// Uses DeepCollectionEquality to compare tokens and avoid unnecessary
  /// state updates when tokens haven't actually changed.
  void updateTokens(Map<String, List<TokenEntity>> tokensMap) {
    if (tokensMap.isEmpty) return;

    const equality = DeepCollectionEquality();
    bool hasChanges = false;

    final updatedItems = state.items.map((item) {
      final newTokens = tokensMap[item.id];
      if (newTokens == null) return item;

      // Skip update if tokens are equal
      if (equality.equals(item.tokens, newTokens)) {
        return item;
      }

      hasChanges = true;
      return item.copyWith(tokens: newTokens);
    }).toList();

    if (hasChanges) {
      emit(state.copyWith(items: updatedItems));
    }
  }

  /// Add visible ID for token polling
  void addVisibleId(String id) {
    if (state.visibleIds.contains(id)) return;
    emit(state.copyWith(visibleIds: [...state.visibleIds, id]));
  }

  /// Remove visible ID
  void removeVisibleId(String id) {
    emit(state.copyWith(
      visibleIds: state.visibleIds.where((v) => v != id).toList(),
    ));
  }

  /// Fetch tokens for visible items
  Future<void> fetchVisibleTokens() async {
    if (state.visibleIds.isEmpty) return;

    final result = await _fetchIntelligenceTokens(state.visibleIds);

    result.whenOrNull(
      success: (tokensMap) => updateTokens(tokensMap),
    );
  }
}
