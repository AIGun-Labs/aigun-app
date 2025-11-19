//收藏列表
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/constants.dart';
import '../../../../cubits/quick_trade/quick_trade_cubit.dart';
import '../../../../cubits/token_detail/token_detail_cubit.dart';
import '../../../../l10n/l10n.dart';
import '../../../../shared/presentation/widgets/skeleton/token_widget.dart';
import '../../../../themes/colors.dart';
import '../../domain/mappers/collect_token_mapper.dart';
import '../cubits/collect_cubit.dart';
import 'collect_token_widget.dart';

class CollectView extends StatefulWidget {
  const CollectView({super.key});

  @override
  State<CollectView> createState() => _CollectViewState();
}

class _CollectViewState extends State<CollectView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    context.read<CollectCubit>().loadCollectTokens();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<CollectCubit, CollectState>(
      buildWhen: (previous, current) {
        // 当 tokens 列表变化时重建，确保添加和删除操作后能及时更新
        return previous.tokens != current.tokens ||
            previous.status != current.status;
      },
      builder: (context, state) {
        if (state.status == CollectStatus.loading) {
          return ListView.builder(
            itemCount: 12,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: const SkeletonTokenWidget(),
            ),
          );
        }

        if (state.status == CollectStatus.noData || state.tokens.isEmpty) {
          return _buildEmptyState();
        }
        return ListView.builder(
          itemCount: state.tokens.length,
          itemBuilder: (context, index) => CollectTokenWidget(
            index: index,
            token: state.tokens[index],
            onTopTap: () {
              context
                  .read<CollectCubit>()
                  .pinCollectToken(token: state.tokens[index]);
            },
            onTap: () {
              final newToken = state.tokens[index].toToken();

              context.read<TokenDetailCubit>().updateToken(newToken);

              context.read<QuickTradeCubit>().updateSelectedToken(newToken);
              // 跳转到代币详情页面

              context.pushNamed(RouteNames.tokenDetail, extra: 'intel');
            },
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
