import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/intelligence_entity.dart';
import '../cubits/event_list/event_list_cubit.dart';
import '../cubits/unread/unread_cubit.dart';
import 'intelligence_list_view.dart';

/// Event List View Widget
///
/// Displays a list of event-type intelligence items.
class EventListView extends StatelessWidget {
  const EventListView({
    super.key,
    required this.items,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasReachedEnd = false,
    this.errorMessage,
    this.onRefresh,
    this.onLoadMore,
    required this.pageStorageKey,
  });

  final List<IntelligenceEntity> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasReachedEnd;
  final String? errorMessage;
  final Future<void> Function()? onRefresh;
  final VoidCallback? onLoadMore;
  final PageStorageKey pageStorageKey;

  @override
  Widget build(BuildContext context) {
    return IntelligenceListView(
      pageStorageKey: pageStorageKey,
      items: items,
      isLoading: isLoading,
      isLoadingMore: isLoadingMore,
      hasReachedEnd: hasReachedEnd,
      errorMessage: errorMessage,
      onRefresh: onRefresh,
      onLoadMore: onLoadMore,
      onVisibilityChanged: (id, isVisible) {
        final cubit = BlocProvider.of<EventListCubit>(context);
        if (isVisible) {
          cubit.addVisibleId(id);
          // Remove from unread when user sees the item
          BlocProvider.of<UnreadCubit>(context).removeUnread(id);
        } else {
          cubit.removeVisibleId(id);
        }
      },
    );
  }
}
