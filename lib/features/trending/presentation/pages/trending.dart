import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

import '../../../../core/service_locator.dart';
import '../../../../cubits/ai_agent/ai_agent_cubit.dart';
import '../../../../shared/presentation/widgets/sliver_tabbar_delegate.dart';
import '../../../../themes/colors.dart';
import '../../../../widgets/push_to_refresh_header.dart';
import '../../../collect/presentation/cubits/collect_cubit.dart';
import '../../../collect/presentation/widgets/collect_view.dart';
import '../../../home/presentation/pages/home.dart';
import '../cubits/hot_token_cubit.dart';
import '../widgets/hot_token_view.dart';
import '../widgets/search_bar.dart';
import '../widgets/tabbar_header.dart';
import '../widgets/top_pick_list.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({super.key});

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen>
    with SingleTickerProviderStateMixin {
  TopPickListSource? _topPickListSource;
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
    await getIt<AiAgentCubit>().getAiAgents();
    switch (_tabController.index) {
      case 0:
        if (!mounted) return true;
        await context.read<CollectCubit>().loadCollectTokens();
        break;
      case 1:
        await _topPickListSource?.refresh(true);
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
        maxDragOffset: 110.h,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              // 1. 搜索栏
              SliverAppBar(
                title: TrendingSearchBar(
                    openDrawer: () => HomeScreenState.scaffoldKey.currentState?.openDrawer()),
                floating: true,
                snap: true,
                pinned: false,
                expandedHeight: 56.h,
                toolbarHeight: 56.h,
                backgroundColor: AppColors.background(context),
                automaticallyImplyLeading: false,
                elevation: 0,
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverAppBarDelegate(
                  PreferredSize(
                    preferredSize: Size.fromHeight(30.h),
                    child: SizedBox(
                      height: 46.h, //防止溢出
                      child: TabbarHeader(controller: _tabController),
                    ),
                  ),
                  backgroundColor: AppColors.background(context),
                ),
              ),
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
              const CollectView(),
              TopPickList(
                onSourceCreated: (source) {
                  _topPickListSource = source;
                },
              ),
              BlocProvider(
                create: (context) => getIt<HotTokenCubit>(),
                child: const HotTokenView(),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
