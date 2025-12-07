import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:extended_sliver/extended_sliver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/intelligence_entity.dart';
import '../cubits/signal_list/signal_list_cubit.dart';
import 'intelligence_list_view.dart';
import 'signal_type_choices.dart';

/// Signal List View Widget
///
/// Displays a list of signal-type (radar_signal) intelligence items.
class SignalListView extends StatelessWidget {
  const SignalListView({
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
    return ExtendedVisibilityDetector(
      uniqueKey: pageStorageKey,
      child: IntelligenceListView(
        items: items,
        isLoading: isLoading,
        isLoadingMore: isLoadingMore,
        hasReachedEnd: hasReachedEnd,
        errorMessage: errorMessage,
        onRefresh: onRefresh,
        onLoadMore: onLoadMore,
        headers: [SliverPinnedToBoxAdapter(child: SignalTypeChoicesWidget())],
        onVisibilityChanged: (id, isVisible) {
          final cubit = BlocProvider.of<SignalListCubit>(context);
          if (isVisible) {
            cubit.addVisibleId(id);
          } else {
            cubit.removeVisibleId(id);
          }
        },
      ),
    );
  }
}
