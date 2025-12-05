import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../core/router/routes/app_routes.dart';
import '../../../../cubits/quick_trade/quick_trade_cubit.dart';
import '../../../../l10n/l10n.dart';
import '../../../../shared/domain/mappers/token_entity_mapper.dart';
import '../../../../shared/presentation/widgets/no_data_widget.dart';
import '../../../../shared/presentation/widgets/refresher/refresh_header_widget.dart';
import '../../../../shared/presentation/widgets/refresher/refresh_notification.dart';
import '../../../../shared/presentation/widgets/skeleton/token_widget.dart';
import '../cubits/top_token_cubit.dart';
import 'top_token_widget.dart';

class TopTokensView extends StatefulWidget {
  const TopTokensView({super.key, required this.pageStorageKey});
  final PageStorageKey pageStorageKey;

  @override
  State<TopTokensView> createState() => _TopTokensViewState();
}

class _TopTokensViewState extends State<TopTokensView> {
  late final TopTokenCubit _topTokenCubit;

  @override
  void initState() {
    super.initState();
    _topTokenCubit = BlocProvider.of<TopTokenCubit>(context)
      ..init()
      ..startRealtimeTimer();
  }

  @override
  void dispose() {
    _topTokenCubit.stopRealtimeTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      final key = '${token.network}-${token.address}';
                      final realtime = state.realtimeMap[key];
                      return VisibilityDetector(
                        key: ValueKey('top-token-$key'),
                        onVisibilityChanged: (VisibilityInfo info) {
                          final isVisible = info.visibleFraction > 0;

                          _topTokenCubit.updateTokenVisibility(
                            token,
                            isVisible,
                          );
                        },
                        child: TopTokenWidget(
                          index: index,
                          token: token,
                          realtime: realtime,
                          onTap: () {
                            final newToken = token.toToken();
                            context.read<QuickTradeCubit>().updateSelectedToken(
                              newToken,
                            );
                            // 跳转到代币详情页面
                            TokenDetailRoute(
                              token,
                              type: 'trending',
                            ).push(context);
                          },
                        ),
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
}
