import 'dart:async';

import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:extended_tabs/extended_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/screens/trending/widgets/collection_list.dart';
import 'package:flutter_aigun/screens/trending/widgets/hot_list.dart';
import 'package:flutter_aigun/screens/trending/widgets/push_to_refresh_header.dart';
import 'package:flutter_aigun/screens/trending/widgets/top_pick_list.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/widgets/card/agent.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

class HotSpotPage extends StatefulWidget {
  final Function(double)? onScrollUpdate;

  const HotSpotPage({super.key, this.onScrollUpdate});

  @override
  State<HotSpotPage> createState() => _HotSpotPageState();
}

class _HotSpotPageState extends State<HotSpotPage>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  double _lastShrinkRatio = -1.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!mounted || widget.onScrollUpdate == null) return;

    final shrinkRatio = (_scrollController.offset / 100).clamp(0.0, 1.0);

    if ((shrinkRatio - _lastShrinkRatio).abs() > 0.02) {
      _lastShrinkRatio = shrinkRatio;
      widget.onScrollUpdate!(shrinkRatio);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  // 模拟AI特工数据
  final List<Map<String, dynamic>> aiAgents = [
    {
      'name': 'Solana侦查官',
      'avatar': 'assets/images/solana_agent.png',
      'isFollowed': false,
    },
    {
      'name': 'BSC侦查官',
      'avatar': 'assets/images/bsc_agent.png',
      'isFollowed': true,
    },
    {
      'name': 'X Layer侦查官',
      'avatar': 'assets/images/xlayer_agent.png',
      'isFollowed': false,
    },
    {
      'name': 'Ethereum侦查官',
      'avatar': 'assets/images/chain/ethereum.png',
      'isFollowed': false,
    },
    {
      'name': 'Polygon侦查官',
      'avatar': 'assets/images/chain/polygon.png',
      'isFollowed': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: AppColors.background(context),
      child: PullToRefreshNotification(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 2));
            return true;
          },
          maxDragOffset: 110.h,
          child: DefaultTabController(
            length: 3,
            child: ExtendedNestedScrollView(
              controller: _scrollController,
              onlyOneScrollInBody: true,
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                PullToRefreshContainer(
                    (PullToRefreshScrollNotificationInfo? info) {
                  return SliverToBoxAdapter(
                    child: PullToRefreshHeader(info),
                  );
                }),
                SliverToBoxAdapter(
                  child: SizedBox(height: 10.h),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 2.w,
                      children: [
                        Text(
                          S.of(context).aiAgent,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary(context),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16.w,
                          color: AppColors.textTertiary(context),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 160.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      itemCount: aiAgents.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 14.w),
                      itemBuilder: (context, index) {
                        final agent = aiAgents[index];
                        return CardAgent(
                          name: agent['name'],
                          avatarPath: agent['avatar'],
                          isFollowed: agent['isFollowed'],
                          onFollowTap: () {
                            setState(() {
                              aiAgents[index]['isFollowed'] =
                                  !aiAgents[index]['isFollowed'];
                            });
                          },
                        );
                      },
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: 5.h),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _TabBarDelegate(
                      tabBar: TabBar(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          tabAlignment: TabAlignment.start,
                          isScrollable: true,
                          indicatorWeight: 0,
                          labelPadding: EdgeInsets.symmetric(horizontal: 10.w),
                          dividerColor: AppColors.border(context),
                          indicator: UnderlineTabIndicator(
                            borderSide: BorderSide(
                              width: 2.h,
                              color: AppColors.textPrimary(context),
                            ),
                          ),
                          indicatorSize: TabBarIndicatorSize.label,
                          labelStyle: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.textPrimary(context),
                            fontWeight: FontWeight.w700,
                          ),
                          unselectedLabelStyle: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.textSecondary(context),
                            fontWeight: FontWeight.w400,
                          ),
                          tabs: [
                        Tab(text: S.of(context).tracking),
                        Tab(text: S.of(context).topPick),
                        Tab(text: S.of(context).hot)
                      ])),
                ),
              ],
              body: const ExtendedTabBarView(link: true, children: [
                CollectionList(uniqueKey: Key('Tab1')),
                TopPickList(uniqueKey: Key('Tab2')),
                HotList(uniqueKey: Key('Tab3')),
              ]),
            ),
          )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _TabBarDelegate({required this.tabBar});

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColors.background(context),
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
