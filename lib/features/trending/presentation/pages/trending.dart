import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:extended_sliver/extended_sliver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

import '../../../../core/service_locator.dart';
import '../../../../cubits/ai_agent/ai_agent_cubit.dart';
import '../../../../cubits/favorite_token/favorite_token_cubit.dart';
import '../../../../themes/colors.dart';
import '../../../../widgets/push_to_refresh_header.dart';
import '../widgets/ai_agent_section.dart';
import '../widgets/collection_list.dart';
import '../widgets/hot_list.dart';
import '../widgets/search_bar.dart';
import '../widgets/tabbar_header.dart';
import '../widgets/top_pick_list.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({super.key});

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  TopPickListSource? _topPickListSource;

  Future<bool> _onRefresh() async {
    await getIt<AiAgentCubit>().getAiAgents();
    await getIt<FavoriteTokenCubit>().getFavoriteTokens();
    await _topPickListSource?.refresh(true);
    return true;
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      titleSpacing: 20.w,
      automaticallyImplyLeading: false,
      title: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.h),
        child: TrendingSearchBar(
            openDrawer: () => Scaffold.of(context).openDrawer()),
      ),
      backgroundColor: AppColors.background(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(context),
        body: PullToRefreshNotification(
            onRefresh: _onRefresh,
            maxDragOffset: 110.h,
            child: DefaultTabController(
                length: 3,
                child: ExtendedNestedScrollView(
                  pinnedHeaderSliverHeightBuilder: () => 46.h,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) => [
                    PullToRefreshContainer(
                        (PullToRefreshScrollNotificationInfo? info) {
                      return SliverToBoxAdapter(
                        child: PullToRefreshHeader(info),
                      );
                    }),
                    const SliverToBoxAdapter(child: AiAgentSection()),
                    const SliverPinnedToBoxAdapter(
                      child: TabbarHeader(),
                    )
                  ],
                  body: TabBarView(children: [
                    const CollectionList(),
                    TopPickList(
                      onSourceCreated: (source) {
                        _topPickListSource = source;
                      },
                    ),
                    const HotList()
                  ]),
                ))));
  }
}
