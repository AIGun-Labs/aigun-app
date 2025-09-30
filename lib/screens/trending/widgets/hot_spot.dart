import 'dart:async';

import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:extended_tabs/extended_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/ai_agent/ai_agent_cubit.dart';
import 'package:flutter_aigun/cubits/ai_agent/ai_agent_state.dart';
import 'package:flutter_aigun/cubits/favorite_token/favorite_token_cubit.dart';
import 'package:flutter_aigun/cubits/language/language_cubit.dart';
import 'package:flutter_aigun/cubits/language/language_state.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/screens/trending/widgets/collection_list.dart';
import 'package:flutter_aigun/screens/trending/widgets/hot_list.dart'
    hide LoadMoreListSource;
import 'package:flutter_aigun/screens/trending/widgets/push_to_refresh_header.dart';
import 'package:flutter_aigun/screens/trending/widgets/top_pick_list.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/utils/resource.dart';
import 'package:flutter_aigun/utils/toast.dart';
import 'package:flutter_aigun/widgets/card/agent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  LoadMoreListSource? _topPickListSource;

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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: AppColors.background(context),
      child: PullToRefreshNotification(
          onRefresh: () async {
            context.read<AiAgentCubit>().getAiAgents();
            context.read<FavoriteTokenCubit>().getFavoriteTokens();
            _topPickListSource?.refresh(true);
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
                //ai 特工
                SliverToBoxAdapter(
                  child: BlocBuilder<AiAgentCubit, AiAgentState>(
                    builder: (context, agentState) {
                      return BlocBuilder<LanguageCubit, LanguageState>(
                        builder: (context, languageState) {
                          final currentLanguageCode =
                              languageState.locale.languageCode;

                          return agentState.status.maybeWhen(
                            success: (agents) {
                              if (agents.isEmpty) {
                                return const SizedBox.shrink();
                              }
                              return SizedBox(
                                height: 160.h,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  itemCount: agents.length,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(width: 14.w),
                                  itemBuilder: (context, index) {
                                    final agent = agents[index];
                                    return CardAgent(
                                      name: currentLanguageCode == 'zh'
                                          ? agent.name.zh ?? ''
                                          : agent.name.en ?? '',
                                      avatarPath:
                                          getImageUrl(agent.avatar) ?? '',
                                      isFollowed: agent.isFollowed,
                                      onFollowTap: () async {
                                        final wasFollowed = agent.isFollowed;
                                        await context
                                            .read<AiAgentCubit>()
                                            .toggleFollowAgent(agent);
                                        if (!wasFollowed && context.mounted) {
                                          ToastUtils.showCenterToast(context,
                                              S.of(context).followSuccess);
                                        }
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                            orElse: () => SizedBox(
                              height: 160.h,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          );
                        },
                      );
                    },
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
              body: ExtendedTabBarView(link: true, children: [
                const CollectionList(uniqueKey: Key('Tab1')),
                TopPickList(
                  uniqueKey: const Key('Tab2'),
                  onSourceCreated: (source) {
                    _topPickListSource = source;
                  },
                ),
                const HotList(uniqueKey: Key('Tab3')),
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
