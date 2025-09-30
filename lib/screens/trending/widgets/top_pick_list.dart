import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/latest_token/latest_token_cubit.dart';
import 'package:flutter_aigun/cubits/latest_token/latest_token_state.dart';
import 'package:flutter_aigun/data/models/trending/lastest_token/lastest_token.dart';
import 'package:flutter_aigun/screens/trending/widgets/token_list_item.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_more_list/loading_more_list.dart';

//最新推荐列表 - 使用 LatestTokenCubit 管理状态
class LoadMoreListSource extends LoadingMoreBase<LatestToken> {
  final LatestTokenCubit _latestTokenCubit;

  LoadMoreListSource(this._latestTokenCubit) {
    // 监听 Cubit 状态变化
    _latestTokenCubit.stream.listen((state) {
      _updateListFromState(state);
    });

    // 初始化时同步当前状态
    _updateListFromState(_latestTokenCubit.state);
  }

  void _updateListFromState(LatestTokenState state) {
    // 清空当前列表
    clear();

    // 添加新数据
    if (state.tokens.isNotEmpty) {
      addAll(state.tokens);
    }

    // 通知列表更新
    refresh(true);
  }

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    try {
      if (isloadMoreAction) {
        // 加载更多
        await _latestTokenCubit.loadMoreTokens();
      } else {
        // 刷新数据
        await _latestTokenCubit.refreshTokens();
      }

      final state = _latestTokenCubit.state;

      // 根据状态判断是否成功加载
      return state.status.when(
        initial: () => false,
        loading: () => true,
        loadingMore: () => true,
        success: (_) => true,
        error: (_) => false,
      );
    } catch (e) {
      return false;
    }
  }
}

class TopPickList extends StatefulWidget {
  const TopPickList({super.key, required this.uniqueKey});
  final Key uniqueKey;

  @override
  State<TopPickList> createState() => _TopPickListState();
}

class _TopPickListState extends State<TopPickList>
    with AutomaticKeepAliveClientMixin {
  late final LoadMoreListSource _source;

  @override
  void initState() {
    super.initState();
    // 初始化时获取 LatestTokenCubit 实例
    _source = LoadMoreListSource(context.read<LatestTokenCubit>());
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<LatestTokenCubit, LatestTokenState>(
      listener: (context, state) {
        _source.refresh(true);
      },
      child: BlocBuilder<LatestTokenCubit, LatestTokenState>(
        builder: (context, state) {
          return ExtendedVisibilityDetector(
            uniqueKey: widget.uniqueKey,
            child: LoadingMoreList(
              ListConfig<LatestToken>(
                autoLoadMore: true,
                autoRefresh: true,
                showGlowLeading: false,
                cacheExtent: 100,
                sourceList: _source,
                itemBuilder: (context, item, index) => TrendingTokenListItem(
                  index: index,
                  token: Token.fromLastestToken(item),
                  onTap: () {
                    // TODO: 导航到代币详情页面
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
