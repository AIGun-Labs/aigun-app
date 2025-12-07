import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/intelligence_entity.dart';
import 'unread_state.dart';

/// Unread Cubit
///
/// Manages the unread intelligence items state.
class UnreadCubit extends Cubit<UnreadState> {
  UnreadCubit() : super(UnreadState.initial());

  /// Add an unread intelligence item
  void addUnread(IntelligenceEntity item) {
    // Avoid duplicates
    if (state.unreadItems.any((i) => i.id == item.id)) return;

    emit(state.copyWith(
      unreadItems: [...state.unreadItems, item],
      showUnreadBar: true,
    ));
  }

  /// Remove an unread item by ID
  void removeUnread(String id) {
    final updatedItems = state.unreadItems.where((i) => i.id != id).toList();

    emit(state.copyWith(
      unreadItems: updatedItems,
      showUnreadBar: updatedItems.isNotEmpty,
    ));
  }

  /// Check if an item is unread
  bool isUnread(String? id) {
    if (id == null) return false;
    return state.unreadItems.any((item) => item.id == id);
  }

  /// Clear all unread items
  void clearAll() {
    emit(state.copyWith(
      unreadItems: [],
      showUnreadBar: false,
    ));
  }

  /// Clear unread items by filter
  void clearByFilter(bool Function(IntelligenceEntity) filter) {
    final remaining = state.unreadItems.where((i) => !filter(i)).toList();

    emit(state.copyWith(
      unreadItems: remaining,
      showUnreadBar: remaining.isNotEmpty,
    ));
  }

  /// Clear event-type unread items
  void clearEventUnread() {
    clearByFilter((item) => item.isEventType);
  }

  /// Clear signal-type unread items
  void clearSignalUnread() {
    clearByFilter((item) => item.isRadarSignal);
  }

  /// Show/hide unread bar
  void setShowUnreadBar(bool show) {
    emit(state.copyWith(showUnreadBar: show));
  }
}
