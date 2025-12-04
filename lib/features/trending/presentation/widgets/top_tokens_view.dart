import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

import '../../../../core/router/routes/app_routes.dart';
import '../../../../cubits/quick_trade/quick_trade_cubit.dart';
import '../../../../l10n/l10n.dart';
import '../../../../shared/presentation/widgets/no_data_widget.dart';
import '../../../../shared/presentation/widgets/refresher/refresh_header_widget.dart';
import '../../../../shared/presentation/widgets/refresher/refresh_notification.dart';
import '../../../../shared/presentation/widgets/skeleton/token_widget.dart';
import '../../../collect/domain/mappers/collect_token_entity_mapper.dart';
import '../../domain/mappers/top_token_entity_mapper.dart';
import '../cubits/top_token_cubit.dart';
import 'top_token_widget.dart';

class TopTokensView extends StatefulWidget {
  const TopTokensView({super.key, required this.pageStorageKey});
  final PageStorageKey pageStorageKey;

  @override
  State<TopTokensView> createState() => _TopTokensViewState();
}

class _TopTokensViewState extends State<TopTokensView>
    with AutomaticKeepAliveClientMixin {
  late final TopTokenCubit _topTokenCubit;

  @override
  void initState() {
    super.initState();
    _topTokenCubit = context.read<TopTokenCubit>()..refresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ExtendedVisibilityDetector(
      uniqueKey: widget.pageStorageKey,
      child: NotificationListener(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.extentAfter < 100) {
            _topTokenCubit.loadMore();
          }
          return false;
        },
        child: RefreshNotification(
          onRefresh: () async {
            await _topTokenCubit.refresh();
            return true;
          },
          child: CustomScrollView(
            slivers: [
              PullToRefreshContainer((
                PullToRefreshScrollNotificationInfo? info,
              ) {
                return SliverToBoxAdapter(child: RefreshHeaderWidget(info));
              }),
              BlocBuilder<TopTokenCubit, TopTokenState>(
                bloc: _topTokenCubit,
                builder: (context, state) {
                  if (state.status == TopTokenStatus.loading ||
                      state.status == TopTokenStatus.initial) {
                    return SliverList.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) =>
                          const SkeletonTokenWidget(),
                    );
                  }

                  if (state.status == TopTokenStatus.failure) {
                    if (state.tokens.isEmpty) {
                      return SliverFillRemaining(
                        child: NoDataWidget(
                          errorTextDesc: S.of(context).noData,
                        ),
                      );
                    } else {
                      return SliverFillRemaining(
                        child: NoDataWidget(
                          onRetry: () => _topTokenCubit.refresh(),
                        ),
                      );
                    }
                  }

                  return SliverList.builder(
                    itemCount: state.tokens.length + (state.hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == state.tokens.length) {
                        return const SkeletonTokenWidget();
                      }

                      final token = state.tokens[index];
                      return TopTokenWidget(
                        index: index,
                        token: token,
                        onTap: () {
                          final newToken = token.toCollectToken().toToken();

                          // context.read<TokenDetailCubit>().updateToken(
                          //   newToken,
                          // );

                          context.read<QuickTradeCubit>().updateSelectedToken(
                            newToken,
                          );
                          // 跳转到代币详情页面
                          TokenDetailRoute(
                            token.toTokenEntity(),
                            type: 'trending',
                          ).push(context);
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
