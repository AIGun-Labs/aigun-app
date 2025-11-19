import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_more_list/loading_more_list.dart';

import '../../../../core/router/constants.dart';
import '../../../../core/service_locator.dart';
import '../../../../cubits/quick_trade/quick_trade_cubit.dart';
import '../../../../cubits/token_detail/token_detail_cubit.dart';
import '../../../../data/models/trending/lastest_token/lastest_token.dart';
import '../../../../data/services/api/trending_api.dart';
import '../../../../widgets/token/models/token.dart';
import 'top_token_widget.dart';

//最新推荐列表 - 直接使用 API 获取数据
class TopPickListSource extends LoadingMoreBase<LatestToken> {
  final TrendingApi _trendingApi = getIt<TrendingApi>();
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
  const TopPickList({super.key, this.onSourceCreated});
  final ValueChanged<TopPickListSource>? onSourceCreated;

  @override
  State<TopPickList> createState() => _TopPickListState();
}

class _TopPickListState extends State<TopPickList>
    with AutomaticKeepAliveClientMixin {
  late final TopPickListSource _source = TopPickListSource();

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
    return LoadingMoreList(
      ListConfig<LatestToken>(
        autoLoadMore: true,
        autoRefresh: true,
        showGlowLeading: false,
        cacheExtent: 100,
        sourceList: _source,
        itemBuilder: (context, item, index) => TopTokenWidget(
          index: index,
          token: item,
          onTap: () {
            final newToken = Token.fromLastestToken(item);
            getIt<TokenDetailCubit>().updateToken(newToken);

            getIt<QuickTradeCubit>().updateSelectedToken(newToken);
            // 跳转到代币详情页面
            context.pushNamed(RouteNames.tokenDetail, extra: 'trending');
          },
        ),
      ),
    );
  }
}
