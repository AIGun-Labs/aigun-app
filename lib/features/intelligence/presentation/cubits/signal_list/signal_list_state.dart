import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/intelligence_entity.dart';

part 'signal_list_state.freezed.dart';

/// Signal List State
@freezed
sealed class SignalListState with _$SignalListState {
  const SignalListState._();

  const factory SignalListState({
    /// List of signal intelligence items
    @Default([]) List<IntelligenceEntity> items,

    /// Current chain ID filter
    @Default('all') String chainId,

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
  }) = _SignalListState;

  /// Initial state factory
  factory SignalListState.initial() => const SignalListState();
}
