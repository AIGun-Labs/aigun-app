import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/intelligence_entity.dart';

part 'event_list_state.freezed.dart';

/// Event List State
@freezed
sealed class EventListState with _$EventListState {
  const EventListState._();

  const factory EventListState({
    /// List of event intelligence items
    @Default([]) List<IntelligenceEntity> items,

    /// Current page number
    @Default(1) int page,

    /// Page size
    @Default(10) int pageSize,

    /// Whether initial load is in progress
    @Default(false) bool isLoading,

    /// Whether loading more items
    @Default(false) bool isLoadingMore,

    /// Whether there are no more items to load
    @Default(false) bool hasReachedEnd,

    /// Error message if any
    String? errorMessage,

    /// List of visible item IDs (for token polling)
    @Default([]) List<String> visibleIds,
  }) = _EventListState;

  /// Initial state factory
  factory EventListState.initial() => const EventListState();
}
