import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/favorite_token/favorite_token_cubit.dart';
import 'package:flutter_aigun/cubits/favorite_token/favorite_token_state.dart';
import 'package:flutter_aigun/cubits/quick_trade/quick_trade_cubit.dart';
import 'package:flutter_aigun/cubits/token_detail/token_detail_cubit.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/screens/trending/widgets/token_list_item.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:flutter_aigun/widgets/token_skeleton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

//收藏列表
class CollectionList extends StatefulWidget {
  const CollectionList({super.key, required this.uniqueKey});
  final Key uniqueKey;

  @override
  State<CollectionList> createState() => _CollectionListState();
}

class _CollectionListState extends State<CollectionList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<FavoriteTokenCubit, FavoriteTokenState>(
      buildWhen: (previous, current) {
        // 当 tokens 列表变化时重建，确保添加和删除操作后能及时更新
        return previous.tokens != current.tokens ||
            previous.listStatus != current.listStatus;
      },
      builder: (context, state) {
        if (state.listStatus == const FavoriteTokenListStatus.loading()) {
          return ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: const TokenSkeleton(),
            ),
          );
        }

        return ExtendedVisibilityDetector(
          uniqueKey: widget.uniqueKey,
          child: state.tokens.isEmpty &&
                  state.listStatus != const FavoriteTokenListStatus.loading()
              ? _buildEmptyState()
              : ListView.builder(
                  itemCount: state.tokens.length,
                  itemBuilder: (context, index) => TrendingTokenListItem(
                    index: index,
                    token: Token.fromFavoriteToken(state.tokens[index]),
                  ),
                ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            S.of(context).noData,
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
