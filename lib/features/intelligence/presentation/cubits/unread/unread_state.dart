import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/intelligence_entity.dart';

part 'unread_state.freezed.dart';

/// Unread State
@freezed
sealed class UnreadState with _$UnreadState {
  const UnreadState._();

  const factory UnreadState({
    /// List of unread intelligence items
    @Default([]) List<IntelligenceEntity> unreadItems,

    /// Whether to show the unread bar
    @Default(false) bool showUnreadBar,
  }) = _UnreadState;

  /// Initial state factory
  factory UnreadState.initial() => const UnreadState();

  /// Count of unread items
  int get unreadCount => unreadItems.length;

  /// Check if there are unread items
  bool get hasUnread => unreadItems.isNotEmpty;

  /// Count of unread event-type items
  int get unreadEventCount =>
      unreadItems.where((item) => item.isEventType).length;

  /// Count of unread signal-type items
  int get unreadSignalCount =>
      unreadItems.where((item) => item.isRadarSignal).length;
}
