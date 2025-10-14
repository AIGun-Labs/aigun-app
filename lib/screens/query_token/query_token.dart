import 'package:flutter/material.dart';
import 'package:flutter_aigun/core/service_locator.dart';
import 'package:flutter_aigun/cubits/query_token/query_token.dart';
import 'package:flutter_aigun/cubits/query_token/query_token_state.dart';
import 'package:flutter_aigun/screens/query_token/widgets/query_token_card_item.dart';
import 'package:flutter_aigun/screens/query_token/widgets/query_token_item.dart';
import 'package:flutter_aigun/screens/query_token/widgets/search_bar.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/widgets/image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class QueryTokenScreen extends StatelessWidget {
  const QueryTokenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String keyworkd = '';
    final queryTokenCubit = getIt<QueryTokenCubit>();
    try {
      keyworkd = GoRouterState.of(context).extra?.toString() ?? '';
      queryTokenCubit.queryToken(keyworkd);
    } catch (e) {
      debugPrint('GoRouterState.of failed in QueryTokenScreen: $e');
    }
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20.w,
        automaticallyImplyLeading: false,
        title: SearchInternalSearchBar(
          initialText: keyworkd,
        ),
        backgroundColor: AppColors.background(context),
      ),
      body: BlocBuilder<QueryTokenCubit, QueryTokenState>(
          builder: (context, state) {
        return SafeArea(
            child: state.status.when(
                initial: () => const SizedBox.shrink(),
                loading: () => const Center(child: CircularProgressIndicator()),
                success: (tokens) {
                  return ListView.separated(
                    padding: EdgeInsets.only(top: 16.h),
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 16.h,
                      );
                    },
                    itemBuilder: (context, index) {
                      final token = tokens[index];

                      return QueryTokenCardItem(queryToken: token);
                    },
                    itemCount: tokens.length,
                  );
                },
                error: (message) => const QueryTokenNoData(),
                noData: () => const QueryTokenNoData()));
      }),
    );
  }
}

class QueryTokenLoading extends StatelessWidget {
  const QueryTokenLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}

class QueryTokenNoData extends StatelessWidget {
  const QueryTokenNoData({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        SizedBox(height: 100.h),
        CachedImage(
          imageUrl: "assets/images/not-more-search.png",
          width: 189.w,
          height: 197.h,
        ),
        SizedBox(height: 16.h),
        Text(
          "没有找到对应的代币\n请检查后重新输入",
          style: TextStyle(
              fontSize: 16.sp, color: AppColors.textSecondary(context)),
          textAlign: TextAlign.center,
        )
      ],
    ));
  }
}
