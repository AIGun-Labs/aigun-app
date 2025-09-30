import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/favorite_token/favorite_token_cubit.dart';
import 'package:flutter_aigun/cubits/favorite_token/favorite_token_state.dart';
import 'package:flutter_aigun/data/models/token_detail/token/favorite_token.dart';
import 'package:flutter_aigun/screens/trending/widgets/token_list_item.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/widgets/custom_popup.dart';
import 'package:flutter_aigun/widgets/image.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_more_list/loading_more_list.dart';

//收藏列表
class LoadMoreListSource extends LoadingMoreBase<FavoriteToken> {
  final FavoriteTokenCubit favoriteTokenCubit;

  LoadMoreListSource(this.favoriteTokenCubit);

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    try {
      if (!isloadMoreAction) {
        // 首次加载，清空数据并重新获取收藏列表
        clear();
        await favoriteTokenCubit.getFavoriteTokens();
      }

      final favoriteTokens = favoriteTokenCubit.state.tokens;

      // 将收藏的 FavoriteToken 转换为 Token 对象
      for (final favoriteToken in favoriteTokens) {
        add(favoriteToken);
      }

      return true;
    } catch (e) {
      return false;
    }
  }
}

//收藏列表
class CollectionList extends StatefulWidget {
  const CollectionList({super.key, required this.uniqueKey});
  final Key uniqueKey;

  @override
  State<CollectionList> createState() => _CollectionListState();
}

class _CollectionListState extends State<CollectionList>
    with AutomaticKeepAliveClientMixin {
  late final LoadMoreListSource _source;

  @override
  void initState() {
    super.initState();
    _source = LoadMoreListSource(context.read<FavoriteTokenCubit>());
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<FavoriteTokenCubit, FavoriteTokenState>(
      listener: (context, state) {
        // 当收藏状态改变时，刷新列表
        if (state.status is FavoriteTokenStatus) {
          _source.refresh(true);
        }
      },
      child: BlocBuilder<FavoriteTokenCubit, FavoriteTokenState>(
        builder: (context, state) {
          return ExtendedVisibilityDetector(
            uniqueKey: widget.uniqueKey,
            child: state.tokens.isEmpty &&
                    state.status != const FavoriteTokenStatus.loading()
                ? _buildEmptyState()
                : LoadingMoreList(
                    ListConfig(
                        showGlowLeading: true,
                        cacheExtent: 100,
                        sourceList: _source,
                        itemBuilder: (context, item, index) =>
                            TrendingTokenListItem(
                                index: index,
                                token: Token.fromFavoriteToken(item))),
                  ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '暂无收藏的代币',
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.textSecondary(context),
            ),
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}
