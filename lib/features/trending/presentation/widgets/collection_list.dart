//收藏列表
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/constants.dart';
import '../../../../core/service_locator.dart';
import '../../../../cubits/favorite_token/favorite_token_cubit.dart';
import '../../../../cubits/favorite_token/favorite_token_state.dart';
import '../../../../cubits/quick_trade/quick_trade_cubit.dart';
import '../../../../cubits/token_detail/token_detail_cubit.dart';
import '../../../../l10n/l10n.dart';
import '../../../../themes/colors.dart';
import '../../../../widgets/token/models/token.dart';
import '../../../../widgets/token_skeleton.dart';
import 'token_item.dart';

class CollectionList extends StatefulWidget {
  const CollectionList({super.key});

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
          uniqueKey: const Key('collection_list'),
          child: state.tokens.isEmpty &&
                  state.listStatus != const FavoriteTokenListStatus.loading()
              ? _buildEmptyState()
              : ListView.builder(
                  key: const PageStorageKey<String>('collection_list_scroll'),
                  itemCount: state.tokens.length,
                  itemBuilder: (context, index) => TokenItem(
                    index: index,
                    token: Token.fromFavoriteToken(state.tokens[index]),
                    onTopTap: () {
                      getIt<FavoriteTokenCubit>().pinToken(
                        Token.fromFavoriteToken(state.tokens[index]),
                      );
                    },
                    onTap: () {
                      final newToken =
                          Token.fromFavoriteToken(state.tokens[index]);
                      getIt<TokenDetailCubit>().updateToken(newToken);

                      getIt<QuickTradeCubit>().updateSelectedToken(newToken);
                      // 跳转到代币详情页面

                      context.pushNamed(RouteNames.tokenDetail, extra: 'intel');
                    },
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
