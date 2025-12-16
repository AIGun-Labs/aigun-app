import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:extended_sliver/extended_sliver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/style.dart';
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
  final ScrollController _scrollController = ScrollController();

  // Header heights
  static final double _appBarHeight = 56.w;
  static final double _tabBarHeight = tabbarHeight.h;
  static final double _fullHeaderHeight = _appBarHeight + _tabBarHeight;

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
    _scrollController.dispose();
    super.dispose();
  }

  /// Calculate the toast top position based on scroll offset
  double _calculateToastTop() {
    if (!_scrollController.hasClients) return _fullHeaderHeight + 10.h;
    final offset = _scrollController.offset;
    final top = (_fullHeaderHeight - offset).clamp(
      _tabBarHeight,
      _fullHeaderHeight,
    );
    final extraOffset = _tabController.index == 1 ? 46.w : 0.0;
    return top + 10.h + extraOffset;
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
      child: Stack(
        children: [
          ExtendedNestedScrollView(
            controller: _scrollController,
            floatHeaderSlivers: true,
            onlyOneScrollInBody: true,
            pinnedHeaderSliverHeightBuilder: () => _tabBarHeight,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      titleSpacing: 15.w,
                      title: IntelligenceSearchBarWidget(
                        onMenuPressed: () =>
                            Scaffold.maybeOf(context)?.openDrawer(),
                      ),
                      toolbarHeight: 56.w,
                      backgroundColor: AppColors.background(context),
                      automaticallyImplyLeading: false,
                    ),
                    SliverPinnedToBoxAdapter(
                      child: IntelligenceTabbarWidget(
                        tabController: _tabController,
                        onEmptyAreaTap: () {
                          if (_scrollController.hasClients) {
                            _scrollController.animateTo(
                              0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                      ),
                    ),
                  ];
                },
            body: TabBarView(
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
          // Floating unread bar with dynamic position based on scroll and tab
          AnimatedBuilder(
            animation: Listenable.merge([_scrollController, _tabController]),
            builder: (context, child) {
              return Positioned(
                top: _calculateToastTop(),
                left: 0,
                right: 0,
                child: child!,
              );
            },
            child: UnreadBarWidget(
              onTap: () {
                if (_scrollController.hasClients) {
                  _scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
