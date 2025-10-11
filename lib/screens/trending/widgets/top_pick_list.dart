import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/cubits/token_detail/token_detail_cubit.dart';
import 'package:flutter_aigun/data/models/trending/lastest_token/lastest_token.dart';
import 'package:flutter_aigun/data/services/api/trending_api.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/screens/trending/widgets/token_list_item.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_more_list/loading_more_list.dart';

//最新推荐列表 - 直接使用 API 获取数据
class LoadMoreListSource extends LoadingMoreBase<LatestToken> {
  final TrendingApi _trendingApi = GetIt.instance<TrendingApi>();
  String? _lastQueryTime;

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    try {
      if (!isloadMoreAction) {
        // 刷新数据时清空列表和时间戳
        _lastQueryTime = null;
        clear();
      }

      // 调用 API 获取数据
      final tokens = await _trendingApi.getLastestTokens(
        lastQueryTime: _lastQueryTime ?? '',
      );

      if (tokens.isEmpty) {
        // 没有更多数据
        return false;
      }

      // 更新最后查询时间（用于分页）
      if (tokens.isNotEmpty) {
        _lastQueryTime = tokens.last.displayTime;
      }

      // 添加数据到列表
      addAll(tokens);

      return true;
    } catch (e) {
      return false;
    }
  }
}

class TopPickList extends StatefulWidget {
  const TopPickList({super.key, required this.uniqueKey, this.onSourceCreated});
  final Key uniqueKey;
  final ValueChanged<LoadMoreListSource>? onSourceCreated;

  @override
  State<TopPickList> createState() => _TopPickListState();
}

class _TopPickListState extends State<TopPickList>
    with AutomaticKeepAliveClientMixin {
  late final LoadMoreListSource _source = LoadMoreListSource();

  @override
  void initState() {
    super.initState();
    widget.onSourceCreated?.call(_source);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
              final newToken = Token.fromLastestToken(item);
              context.read<TokenDetailCubit>().updateToken(newToken);

              context.read<QuickTradeCubit>().updateSelectedToken(newToken);
              // 跳转到代币详情页面

              context.push(Routes.tokenDetail, extra: 'intel');
            },
          ),
        ),
      ),
    );
  }
}
