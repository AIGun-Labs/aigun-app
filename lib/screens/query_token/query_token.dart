import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../core/service_locator.dart';
import '../../cubits/query_token/query_token.dart';
import '../../cubits/query_token/query_token_state.dart';
import '../../gen/assets.gen.dart';
import '../../l10n/l10n.dart';
import '../../themes/themes.dart';
import '../../widgets/image.dart';
import 'widgets/query_token_card_item.dart';
import 'widgets/query_token_item.dart';
import 'widgets/query_token_loading.dart';
import 'widgets/search_bar.dart';

class QueryTokenScreen extends StatelessWidget {
  const QueryTokenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final queryTokenCubit = getIt<QueryTokenCubit>();
    final routeKeyword = GoRouterState.of(context).extra?.toString() ?? '';

    // 1. 如果 routeKeyword 非空（通过粘贴进入），用它搜索
    // 2. 如果 routeKeyword 为空（直接点击进入），先 reset 清空旧状态
    if (routeKeyword.isNotEmpty) {
      queryTokenCubit.queryTokens(routeKeyword);
    } else {
      // 没有路由参数，如果 cubit 有旧数据就清空
      if (queryTokenCubit.state.keyword != null) {
        queryTokenCubit.reset();
      }
    }

    return PopScope(
        child: Scaffold(
      appBar: AppBar(
        titleSpacing: 20.w,
        automaticallyImplyLeading: false,
        title: SearchInternalSearchBar(
          initialText: routeKeyword,
        ),
        backgroundColor: AppColors.background(context),
      ),
      body: SafeArea(
        child: BlocBuilder<QueryTokenCubit, QueryTokenState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const QueryTokenLoading();
            }

            if (state.noData) {
              return const QueryTokenNoData();
            }
// 小于 4
            if (state.tokens.length < 4) {
              return ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 16.h,
                  );
                },
                padding: EdgeInsets.only(top: 11.h),
                itemBuilder: (context, index) {
                  if (state.tokens[index].name == null) {
                    return const SizedBox.shrink();
                  }

                  return QueryTokenCardItem(token: state.tokens[index]);
                },
                itemCount: state.tokens.length,
              );
            }

            return ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 16.h,
                );
              },
              padding: EdgeInsets.only(top: 16.h),
              itemBuilder: (context, index) {
                if (state.tokens[index].name == null) {
                  return const SizedBox.shrink();
                }

                return QueryTokenItem(token: state.tokens[index]);
              },
              itemCount: state.tokens.length,
            );
          },
        ),
      ),
    ));
  }
}

class QueryTokenNoData extends StatelessWidget {
  const QueryTokenNoData({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        SizedBox(height: 120.h),
        CachedImage(
          imageUrl: $AssetsImagesGen().notMoreSearch.path,
          width: 189.w,
          height: 197.h,
        ),
        SizedBox(height: 16.h),
        Text(
          S.of(context).noTokenFound,
          style: TextStyle(
              fontSize: 16.sp, color: AppColors.textSecondary(context)),
          textAlign: TextAlign.center,
        )
      ],
    ));
  }
}
