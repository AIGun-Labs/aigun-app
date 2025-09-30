import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/ai_agent/ai_agent_cubit.dart';
import 'package:flutter_aigun/cubits/ai_agent/ai_agent_state.dart';
import 'package:flutter_aigun/data/models/trending/ai_agent/ai_agent.dart';
import 'package:flutter_aigun/data/services/api/trending_api.dart';
import 'package:flutter_aigun/cubits/language/language_cubit.dart';
import 'package:flutter_aigun/cubits/language/language_state.dart';
import 'package:flutter_aigun/utils/resource.dart';
import 'package:flutter_aigun/widgets/card/agent_desc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

import 'push_to_refresh_header.dart';

class LoadMoreListSource extends LoadingMoreBase<AiAgent> {
  final TrendingApi _trendingApi = GetIt.instance<TrendingApi>();
  bool _hasMore = true;

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    try {
      // 如果是加载更多但没有更多数据，直接返回
      if (isloadMoreAction && !_hasMore) {
        return false;
      }

      // 调用 API 获取数据
      final aiAgents = await _trendingApi.getAiAgents();

      if (aiAgents.isEmpty) {
        _hasMore = false;
        return false;
      }

      // 如果是刷新操作，清空旧数据
      if (!isloadMoreAction) {
        clear();
      }

      // 添加新数据
      addAll(aiAgents);

      // 目前 API 返回全部数据，没有分页，标记没有更多
      _hasMore = false;

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> refresh([bool notifyStateChanged = false]) async {
    _hasMore = true;
    final result = await loadData(false);
    if (notifyStateChanged) {
      setState();
    }
    return result;
  }
}

class AiAgentPage extends StatefulWidget {
  final Function(double)? onScrollUpdate;

  const AiAgentPage({super.key, this.onScrollUpdate});

  @override
  State<AiAgentPage> createState() => _AiAgentPageState();
}

class _AiAgentPageState extends State<AiAgentPage>
    with AutomaticKeepAliveClientMixin {
  double _lastShrinkRatio = -1.0;
  late final LoadMoreListSource _source = LoadMoreListSource();

  void _onScroll(ScrollNotification notification) {
    if (!mounted || widget.onScrollUpdate == null) return;

    if (notification is ScrollUpdateNotification) {
      final scrollOffset = notification.metrics.pixels;
      final shrinkRatio = (scrollOffset / 100).clamp(0.0, 1.0);

      if ((shrinkRatio - _lastShrinkRatio).abs() > 0.02) {
        _lastShrinkRatio = shrinkRatio;
        widget.onScrollUpdate!(shrinkRatio);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        _onScroll(notification);
        return false;
      },
      child: PullToRefreshNotification(
          onRefresh: () async {
            await _source.refresh(true);
            return true;
          },
          maxDragOffset: 110.h,
          child: ExtendedNestedScrollView(
              onlyOneScrollInBody: true,
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    PullToRefreshContainer(
                        (PullToRefreshScrollNotificationInfo? info) {
                      return SliverToBoxAdapter(
                        child: PullToRefreshHeader(info),
                      );
                    }),
                  ],
              body: ExtendedVisibilityDetector(
                  uniqueKey: const Key('ai_agent'),
                  child: BlocBuilder<LanguageCubit, LanguageState>(
                      builder: (context, languageState) {
                    final currentLanguageCode =
                        languageState.locale.languageCode;
                    return LoadingMoreList(
                      ListConfig(
                        indicatorBuilder: (context, status) {
                          return const SizedBox.shrink();
                        },
                        showGlowLeading: false,
                        showGlowTrailing: false,
                        autoRefresh: true,
                        autoLoadMore: false,
                        cacheExtent: 50,
                        sourceList: _source,
                        padding: EdgeInsets.all(20.w),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 13.w,
                          crossAxisSpacing: 13.w,
                          childAspectRatio: 0.8,
                        ),
                        itemBuilder: (context, item, index) => CardAgentDesc(
                          name: currentLanguageCode == 'zh'
                              ? item.name.zh!
                              : item.name.en!,
                          avatarPath: getImageUrl(item.avatar) ?? '',
                          isFollowed: item.isFollowed,
                          desc: currentLanguageCode == 'zh'
                              ? item.description.zh!
                              : item.description.en!,
                          onFollowTap: () {
                            context.read<AiAgentCubit>().toggleFollowAgent(item);
                          },
                        ),
                      ),
                    );
                  })))),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
