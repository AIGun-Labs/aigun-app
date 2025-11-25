import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/constants.dart';
import '../../../../cubits/quick_trade/quick_trade_cubit.dart';
import '../../../../cubits/token_detail/token_detail_cubit.dart';
import '../../../../l10n/l10n.dart';
import '../../../../shared/presentation/widgets/no_data_widget.dart';
import '../../../../shared/presentation/widgets/skeleton/token_widget.dart';
import '../../../collect/domain/mappers/collect_token_mapper.dart';
import '../../../collect/domain/mappers/top_token_mapper.dart';
import '../../../collect/presentation/cubits/collect_cubit.dart';
import '../cubits/top_token_cubit.dart';
import 'top_Token_list_tile.dart';

class TopTokensView extends StatefulWidget {
  const TopTokensView({super.key});

  @override
  State<TopTokensView> createState() => _TopTokensViewState();
}

class _TopTokensViewState extends State<TopTokensView>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<TopTokenCubit>().refresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<TopTokenCubit, TopTokenState>(
      builder: (context, state) {
        if (state.status == TopTokenStatus.loading ||
            state.status == TopTokenStatus.initial) {
          return ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) => const SkeletonTokenWidget(),
          );
        }

        if (state.status == TopTokenStatus.failure) {
          if (state.tokens.isEmpty) {
            return NoDataWidget(
              errorTextDesc: S.of(context).noData,
              onRetry: () => context.read<TopTokenCubit>().refresh(),
            );
          } else {
            return NoDataWidget(
              errorTextDesc: S.of(context).noData,
              onRetry: () => context.read<TopTokenCubit>().refresh(),
            );
          }
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels >=
                scrollInfo.metrics.maxScrollExtent - 200) {
              context.read<TopTokenCubit>().loadMore();
            }
            return false;
          },
          child: ListView.builder(
            key: UniqueKey(),
            itemCount: state.tokens.length + (state.hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == state.tokens.length) {
                return const SkeletonTokenWidget();
              }

              final token = state.tokens[index];
              return TopTokenWidget(
                index: index,
                token: token,
                onTopTap: () {
                  context
                      .read<CollectCubit>()
                      .pinCollectToken(token: token.toCollectToken());
                },
                onTap: () {
                  final newToken = token.toCollectToken().toToken();

                  context.read<TokenDetailCubit>().updateToken(newToken);

                  context.read<QuickTradeCubit>().updateSelectedToken(newToken);
                  // 跳转到代币详情页面

                  context.pushNamed(RouteNames.tokenDetail, extra: 'trending');
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
