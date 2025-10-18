import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:extended_sliver/extended_sliver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

import '../../../../core/service_locator.dart';
import '../../../../cubits/ai_agent/ai_agent_cubit.dart';
import '../../../../cubits/favorite_token/favorite_token_cubit.dart';
import '../../../../themes/colors.dart';
import '../../../../widgets/push_to_refresh_header.dart';
import '../widgets/ai_agent_section.dart';
import '../widgets/collection_list.dart';
import '../widgets/search_bar.dart';
import '../widgets/tabbar_header.dart';
import '../widgets/top_pick_list.dart';

class NewTrendingScreen extends StatefulWidget {
  const NewTrendingScreen({super.key});

  @override
  State<NewTrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<NewTrendingScreen> {
  LoadMoreListSource? _topPickListSource;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 20.w,
          automaticallyImplyLeading: false,
          title: Container(
            padding: EdgeInsets.symmetric(horizontal: 5.h),
            child: TrendingSearchBar(
                openDrawer: () => Scaffold.of(context).openDrawer()),
          ),
          backgroundColor: AppColors.background(context),
        ),
        body: PullToRefreshNotification(
            onRefresh: () async {
              await getIt<AiAgentCubit>().getAiAgents();
              await getIt<FavoriteTokenCubit>().getFavoriteTokens();
              await _topPickListSource?.refresh(true);
              return true;
            },
            maxDragOffset: 110.h,
            child: DefaultTabController(
                length: 3,
                child: ExtendedNestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) => [
                    PullToRefreshContainer(
                        (PullToRefreshScrollNotificationInfo? info) {
                      return SliverToBoxAdapter(
                        child: PullToRefreshHeader(info),
                      );
                    }),
                    const SliverToBoxAdapter(child: AiAgentSection()),
                    SliverToBoxAdapter(
                      child: SizedBox(height: 5.h),
                    ),
                    const SliverPinnedToBoxAdapter(
                      child: TabbarHeader(),
                    )
                  ],
                  body: TabBarView(children: [
                    const CollectionList(uniqueKey: Key('collection_list')),
                    TopPickList(
                      uniqueKey: const Key('top_pick_list'),
                      onSourceCreated: (source) {
                        _topPickListSource = source;
                      },
                    ),
                    Center(
                      child: Text(S.of(context).development),
                    )
                  ]),
                ))));
  }
}
