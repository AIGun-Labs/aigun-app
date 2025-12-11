//收藏列表
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

import '../../../../core/router/routes/app_routes.dart';
import '../../../../cubits/quick_trade/quick_trade_cubit.dart';
import '../../../../l10n/l10n.dart';
import '../../../../shared/domain/mappers/token_entity_mapper.dart';
import '../../../../shared/presentation/widgets/no_data_widget.dart';
import '../../../../shared/presentation/widgets/refresher/refresh_header_widget.dart';
import '../../../../shared/presentation/widgets/refresher/refresh_notification.dart';
import '../../../../shared/presentation/widgets/skeleton/token_widget.dart';
import '../../../candlestick/presentation/cubit/candlestick/candlestick_cubit.dart';
import '../cubits/collect_cubit.dart';
import 'collect_token_widget.dart';

class CollectTokensView extends StatefulWidget {
  const CollectTokensView({super.key, required this.pageStorageKey});
  final PageStorageKey pageStorageKey;

  @override
  State<CollectTokensView> createState() => _CollectTokensViewState();
}

class _CollectTokensViewState extends State<CollectTokensView>
    with AutomaticKeepAliveClientMixin {
  late final CollectCubit _collectCubit;

  @override
  void initState() {
    super.initState();
    _collectCubit = BlocProvider.of<CollectCubit>(context)..loadCollectTokens();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ExtendedVisibilityDetector(
      uniqueKey: widget.pageStorageKey,
      child: RefreshNotification(
        onRefresh: () async {
          await _collectCubit.loadCollectTokens();
          await Future.delayed(const Duration(seconds: 1));
          return true;
        },
        child: CustomScrollView(
          slivers: [
            PullToRefreshContainer((PullToRefreshScrollNotificationInfo? info) {
              return SliverToBoxAdapter(child: RefreshHeaderWidget(info));
            }),
            BlocBuilder<CollectCubit, CollectState>(
              bloc: _collectCubit,
              builder: (context, state) {
                if (state.status == CollectStatus.loading ||
                    state.status == CollectStatus.initial) {
                  return SliverList.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) =>
                        const SkeletonTokenWidget(),
                  );
                }

                if (state.status == CollectStatus.error) {
                  return SliverFillRemaining(
                    child: NoDataWidget(
                      onRetry: () => _collectCubit.loadCollectTokens(),
                    ),
                  );
                }

                if (state.status == CollectStatus.noData ||
                    state.tokens.isEmpty) {
                  return SliverFillRemaining(
                    child: NoDataWidget(errorTextDesc: S.of(context).noData),
                  );
                }

                return SliverList.builder(
                  itemCount: state.tokens.length,
                  itemBuilder: (context, index) {
                    final token = state.tokens[index].base;

                    return CollectTokenWidget(
                      index: index,
                      token: token,
                      onTopTap: () {
                        _collectCubit.pinCollectToken(
                          network: token.network,
                          address: token.address,
                        );
                      },
                      onTap: () {
                        final newToken = token.toToken();

                        context.read<QuickTradeCubit>().updateSelectedToken(
                          newToken,
                        );

                        BlocProvider.of<CandlestickCubit>(context).updateToken(
                          network: token.network,
                          address: token.address,
                        );
                        // 跳转到代币详情页面
                        TokenDetailRoute(token, type: 'intel').push(context);
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
