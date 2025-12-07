import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubits/event_list/event_list_cubit.dart';
import '../cubits/event_list/event_list_state.dart';
import '../cubits/intelligence/intelligence_cubit.dart';
import '../cubits/intelligence/intelligence_state.dart';
import '../cubits/signal_list/signal_list_cubit.dart';
import '../cubits/signal_list/signal_list_state.dart';
import '../cubits/unread/unread_cubit.dart';
import '../widgets/event_list_view.dart';
import '../widgets/search_bar.dart';
import '../widgets/signal_list_view.dart';
import '../widgets/signal_type_choices.dart';
import '../widgets/tabbar.dart';
import '../widgets/unread_bar.dart';

/// Intelligence Page
///
/// Main page for the intelligence feature displaying events and signals.
class IntelligencePage extends StatefulWidget {
  const IntelligencePage({super.key});

  @override
  State<IntelligencePage> createState() => _IntelligencePageState();
}

class _IntelligencePageState extends State<IntelligencePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  double _headerOffset = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChanged);

    // Initialize the intelligence cubit
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<IntelligenceCubit>().initialize();
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) {
      context.read<IntelligenceCubit>().changeTab(_tabController.index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: Stack(
          children: [
            Positioned(
              top: _headerOffset,
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                children: [
                  IntelligenceSearchBarWidget(),
                  IntelligenceTabbarWidget(tabController: _tabController),
                  Expanded(child: _buildTabContent()),
                ],
              ),
            ),
            _buildUnreadBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    return TabBarView(
      controller: _tabController,
      children: [
        // Events Tab
        BlocBuilder<EventListCubit, EventListState>(
          builder: (context, state) {
            return EventListView(
              items: state.items,
              isLoading: state.isLoading,
              isLoadingMore: state.isLoadingMore,
              hasReachedEnd: state.hasReachedEnd,
              errorMessage: state.errorMessage,
              onRefresh: () => context.read<EventListCubit>().refresh(),
              onLoadMore: () => context.read<EventListCubit>().loadMore(),
              pageStorageKey: const PageStorageKey('event_list'),
            );
          },
        ),
        // Signals Tab
        Column(
          children: [
            const SignalTypeChoicesWidget(),
            Expanded(
              child: BlocBuilder<SignalListCubit, SignalListState>(
                builder: (context, state) {
                  return SignalListView(
                    items: state.items,
                    isLoading: state.isLoading,
                    isLoadingMore: state.isLoadingMore,
                    hasReachedEnd: state.hasReachedEnd,
                    errorMessage: state.errorMessage,
                    onRefresh: () => context.read<SignalListCubit>().refresh(),
                    onLoadMore: () =>
                        context.read<SignalListCubit>().loadMore(),
                    pageStorageKey: const PageStorageKey('signal_list'),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUnreadBar() {
    // UnreadBarWidget handles all BlocBuilder logic internally
    return UnreadBarWidget(onTap: _scrollToTop);
  }

  void _scrollToTop() {
    // Clear unread and scroll to top
    final intelligenceCubit = context.read<IntelligenceCubit>();
    if (intelligenceCubit.state.isEventsTab) {
      context.read<UnreadCubit>().clearEventUnread();
    } else {
      context.read<UnreadCubit>().clearSignalUnread();
    }
    // Note: Actual scroll to top would need a ScrollController passed to list views
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth != 1) return false;

    if (notification is ScrollUpdateNotification) {
      // Handle iOS bounce-back issue
      if (notification.metrics.pixels < 0 &&
          (notification.scrollDelta ?? 0) > 0) {
        return false;
      }

      final double newOffset = (_headerOffset - notification.scrollDelta!)
          .clamp(-56.w, 0.0);
      if (newOffset != _headerOffset) {
        setState(() {
          _headerOffset = newOffset;
        });
      }

      _updateUnreadBarVisibility(notification.metrics.pixels);
    } else if (notification is OverscrollNotification) {
      final double newOffset = (_headerOffset - notification.overscroll).clamp(
        -56.w,
        0.0,
      );
      if (newOffset != _headerOffset) {
        setState(() {
          _headerOffset = newOffset;
        });
      }
    } else if (notification is ScrollEndNotification) {
      _updateUnreadBarVisibility(notification.metrics.pixels);
    }

    return false;
  }

  void _updateUnreadBarVisibility(double scrollPosition) {
    final unreadCubit = context.read<UnreadCubit>();
    final showUnreadBar = unreadCubit.state.showUnreadBar;

    if (scrollPosition > 300 && !showUnreadBar) {
      unreadCubit.setShowUnreadBar(true);
    } else if (scrollPosition <= 300 && showUnreadBar) {
      unreadCubit.setShowUnreadBar(false);
    }
  }
}
