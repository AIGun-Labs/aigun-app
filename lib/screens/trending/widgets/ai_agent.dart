import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/data/models/trending/ai_agent/ai_agent.dart';
import 'package:flutter_aigun/data/services/api/trending_api.dart';
import 'package:flutter_aigun/cubits/language/language_cubit.dart';
import 'package:flutter_aigun/cubits/language/language_state.dart';
import 'package:flutter_aigun/widgets/card/agent.dart';
import 'package:flutter_aigun/widgets/card/agent_desc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

import 'push_to_refresh_header.dart';

// 模拟AI特工数据
// GetIt.instance<TrendingApi>().getAiAgents()
class LoadMoreListSource extends LoadingMoreBase<AiAgent> {
  bool _hasLoaded = false;

  LoadMoreListSource() {
    loadData();
  }

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    try {
      // 如果是下拉刷新，重置状态
      if (!isloadMoreAction) {
        clear();
        _hasLoaded = false;
      }

      // 如果已经加载过且是加载更多操作，则不再加载
      if (_hasLoaded && isloadMoreAction) {
        return false;
      }

      final aiAgents = await GetIt.instance<TrendingApi>().getAiAgents();
      print('aiAgents: $aiAgents');

      for (var agent in aiAgents) {
        add(agent);
      }

      _hasLoaded = true;
      return false; // 没有更多数据
    } catch (e) {
      print('Error loading AI agents: $e');
      return false;
    }
  }

  @override
  Future<bool> refresh([bool notifyStateChanged = false]) async {
    _hasLoaded = false;
    return super.refresh(notifyStateChanged);
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
  final ScrollController _scrollController = ScrollController();
  double _lastShrinkRatio = -1.0;
  late final LoadMoreListSource _source = LoadMoreListSource();

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
    return PullToRefreshNotification(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 2));
          return true;
        },
        maxDragOffset: 110.h,
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
                ],
            body: ExtendedVisibilityDetector(
                uniqueKey: const Key('ai_agent'),
                child: BlocBuilder<LanguageCubit, LanguageState>(
                    builder: (context, languageState) {
                  final currentLanguageCode = languageState.locale.languageCode;
                  return LoadingMoreList(
                    ListConfig(
                      cacheExtent: 50,
                      sourceList: _source,
                      itemBuilder: (context, item, index) => CardAgentDesc(
                        name: currentLanguageCode == 'zh'
                            ? item.name.zh!
                            : item.name.en!,
                        avatarPath: item.avatar,
                        isFollowed: item.isFollowed,
                        desc: currentLanguageCode == 'zh'
                            ? item.description.zh!
                            : item.description.en!,
                        onFollowTap: () {},
                      ),
                    ),
                  );
                }))));
  }

  @override
  bool get wantKeepAlive => true;
}

// 方案二：支持分页的 LoadMoreListSource
// 使用时替换上面的 LoadMoreListSource 类
/*
class LoadMoreListSource extends LoadingMoreBase<AiAgent> {
  int _currentPage = 0;
  final int _pageSize = 20;
  bool _hasMore = true;

  LoadMoreListSource() {
    loadData();
  }

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    try {
      // 如果是下拉刷新，重置分页状态
      if (!isloadMoreAction) {
        clear();
        _currentPage = 0;
        _hasMore = true;
      }

      // 如果没有更多数据，直接返回
      if (!_hasMore) return false;

      final aiAgents = await GetIt.instance<TrendingApi>()
          .getAiAgents(page: _currentPage, pageSize: _pageSize);

      print('aiAgents page $_currentPage: ${aiAgents.length}');

      // 如果返回的数据少于页面大小，说明没有更多数据
      if (aiAgents.length < _pageSize) {
        _hasMore = false;
      }

      // 添加数据到列表
      for (var agent in aiAgents) {
        add(agent);
      }

      _currentPage++;
      return _hasMore;
    } catch (e) {
      print('Error loading AI agents: $e');
      return false;
    }
  }

  @override
  Future<bool> refresh([bool notifyStateChanged = false]) async {
    _hasMore = true;
    _currentPage = 0;
    return super.refresh(notifyStateChanged);
  }
}
*/
