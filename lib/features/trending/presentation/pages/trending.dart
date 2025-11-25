import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:extended_sliver/extended_sliver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

import '../../../../core/service_locator.dart';
import '../../../../themes/colors.dart';
import '../../../../widgets/push_to_refresh_header.dart';
import '../../../collect/presentation/cubits/collect_cubit.dart';
import '../../../collect/presentation/widgets/collect_tokens_view.dart';
import '../../../home/presentation/pages/home.dart';
import '../cubits/hot_token_cubit.dart';
import '../cubits/top_token_cubit.dart';
import '../widgets/hot_tokens_view.dart';
import '../widgets/search_bar.dart';
import '../widgets/tabbar_header.dart';
import '../widgets/top_tokens_view.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({super.key});

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<bool> _onRefresh() async {
    switch (_tabController.index) {
      case 0:
        await getIt<CollectCubit>().loadCollectTokens();
        break;
      case 1:
        await getIt<TopTokenCubit>().refresh();
        break;
      case 2:
        await getIt<HotTokenCubit>().refresh();
        break;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: PullToRefreshNotification(
        onRefresh: _onRefresh,
        maxDragOffset: 100.h,
        child: ExtendedNestedScrollView(
          onlyOneScrollInBody: true,
          pinnedHeaderSliverHeightBuilder: () => 30.h,
          key: UniqueKey(),
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              // 1. 搜索栏
              SliverAppBar(
                title: TrendingSearchBar(
                    openDrawer: () =>
                        HomeScreenState.scaffoldKey.currentState?.openDrawer()),
                floating: true,
                snap: true,
                pinned: false,
                expandedHeight: 56.h,
                toolbarHeight: 56.h,
                backgroundColor: AppColors.background(context),
                automaticallyImplyLeading: false,
                elevation: 0,
              ),
              SliverPinnedToBoxAdapter(
                child: SizedBox(
                  height: 36.h, //防止溢出
                  child: TabbarHeader(controller: _tabController),
                ),
              ),
              // SliverPersistentHeader(
              //     pinned: true,
              //     delegate: SliverAppBarDelegate(
              //       PreferredSize(
              //         preferredSize: Size.fromHeight(30.h),
              //         child: ,
              //       ),
              //       backgroundColor: AppColors.background(context),
              //     ),
              //   ),
              PullToRefreshContainer(
                  (PullToRefreshScrollNotificationInfo? info) {
                return SliverToBoxAdapter(
                  child: PullToRefreshHeader(info),
                );
              }),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              const CollectTokensView(),
              BlocProvider(
                create: (context) => getIt<TopTokenCubit>(),
                child: const TopTokensView(),
              ),
              BlocProvider(
                create: (context) => getIt<HotTokenCubit>(),
                child: const HotTokensView(),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
