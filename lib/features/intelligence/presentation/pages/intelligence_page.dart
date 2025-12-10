import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:extended_sliver/extended_sliver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../themes/colors.dart';
import '../cubits/event_list/event_list_cubit.dart';
import '../cubits/event_list/event_list_state.dart';
import '../cubits/intelligence/intelligence_cubit.dart';
import '../cubits/signal_list/signal_list_cubit.dart';
import '../cubits/signal_list/signal_list_state.dart';
import '../widgets/event_list_view.dart';
import '../widgets/search_bar.dart';
import '../widgets/signal_list_view.dart';
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this)
      ..addListener(_onTabChanged);

    // Initialize the intelligence cubit
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<IntelligenceCubit>(context).initialize();
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
      BlocProvider.of<IntelligenceCubit>(
        context,
      ).changeTab(_tabController.index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ExtendedNestedScrollView(
        floatHeaderSlivers: true,
        onlyOneScrollInBody: true,
        pinnedHeaderSliverHeightBuilder: () => 36.w,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              titleSpacing: 15.w,
              title: IntelligenceSearchBarWidget(
                onMenuPressed: () => Scaffold.maybeOf(context)?.openDrawer(),
              ),
              toolbarHeight: 56.w,
              backgroundColor: AppColors.background(context),
              automaticallyImplyLeading: false,
            ),
            SliverPinnedToBoxAdapter(
              child: IntelligenceTabbarWidget(
                tabController: _tabController,
                onEmptyAreaTap: () => PrimaryScrollController.of(context).animateTo(
                  0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: UnreadBarWidget(
                onTap: () => PrimaryScrollController.of(context).animateTo(
                  0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            // Events Tab
            // 在这里写的原因是 EventList 纯展示组件、利于测试不用 mock cubit、职责分离
            BlocBuilder<EventListCubit, EventListState>(
              builder: (context, state) {
                return EventListView(
                  items: state.items,
                  isLoading: state.isLoading,
                  isLoadingMore: state.isLoadingMore,
                  hasReachedEnd: state.hasReachedEnd,
                  errorMessage: state.errorMessage,
                  onRefresh: () =>
                      BlocProvider.of<EventListCubit>(context).refresh(),
                  onLoadMore: () =>
                      BlocProvider.of<EventListCubit>(context).loadMore(),
                  pageStorageKey: const PageStorageKey('event_list'),
                );
              },
            ),
            // Signals Tab
            BlocBuilder<SignalListCubit, SignalListState>(
              builder: (context, state) {
                return SignalListView(
                  items: state.items,
                  isLoading: state.isLoading,
                  isLoadingMore: state.isLoadingMore,
                  hasReachedEnd: state.hasReachedEnd,
                  errorMessage: state.errorMessage,
                  onRefresh: () =>
                      BlocProvider.of<SignalListCubit>(context).refresh(),
                  onLoadMore: () =>
                      BlocProvider.of<SignalListCubit>(context).loadMore(),
                  pageStorageKey: const PageStorageKey('signal_list'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
