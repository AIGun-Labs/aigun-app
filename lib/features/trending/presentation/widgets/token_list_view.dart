import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../core/router/routes/app_routes.dart';
import '../../../../cubits/quick_trade/quick_trade_cubit.dart';
import '../../../../l10n/l10n.dart';
import '../../../../shared/domain/entities/base_token_entity.dart';
import '../../../../shared/domain/entities/choice_item_entity.dart';
import '../../../../shared/domain/mappers/token_entity_mapper.dart';
import '../../../../shared/presentation/utils/show_token_actions_popover.dart';
import '../../../../shared/presentation/widgets/no_data_widget.dart';
import '../../../../shared/presentation/widgets/refresher/refresh_header_widget.dart';
import '../../../../shared/presentation/widgets/refresher/refresh_notification.dart';
import '../../../../shared/presentation/widgets/skeleton/token_widget.dart';
import '../../../../shared/presentation/widgets/token/token_list_tile.dart';
import '../../../../utils/toast.dart';
import '../../../collect/presentation/cubits/collect_cubit.dart';
import '../../../dynamic_tabs/domain/entities/option_tab_entity.dart';
import '../../../dynamic_tabs/presentation/widgets/secondary_level_tab_widget.dart';
import '../cubits/top_token_cubit.dart';

class TokenListView extends StatefulWidget {
  const TokenListView({
    super.key,
    this.tabs,
    this.queryParameters,
    this.paginationField,
  });
  final List<OptionTabItemEntity>? tabs;
  final Map<String, dynamic>? queryParameters;
  final String? paginationField;
  @override
  State<TokenListView> createState() => _TokenListViewState();
}

class _TokenListViewState extends State<TokenListView>
    with AutomaticKeepAliveClientMixin {
  late final TopTokenCubit _topTokenCubit;

  late final CollectCubit _collectCubit;

  void _onTokenTap(BaseTokenEntity token) {
    final newToken = token.toToken();
    BlocProvider.of<QuickTradeCubit>(context).updateSelectedToken(newToken);
    // 跳转到代币详情页面
    TokenDetailRoute(token, type: 'intel').push(context);
  }

  Future<void> _onTokenCollect(BaseTokenEntity token, bool isCollected) async {
    await _collectCubit.handleCollect(token: token);
    if (!mounted) return;
    if (isCollected) {
      ToastUtils.showCenterToast(context, S.of(context).cancelTracking);
    } else {
      ToastUtils.showCenterToast(context, S.of(context).trackSuccess);
    }
  }

  @override
  void initState() {
    super.initState();
    _topTokenCubit = BlocProvider.of<TopTokenCubit>(context)
      ..init(
        queryParameters: widget.queryParameters,
        paginationField: widget.paginationField,
      )
      ..startRealtimeTimer();
    _collectCubit = BlocProvider.of<CollectCubit>(context);
  }

  @override
  void dispose() {
    _topTokenCubit.stopRealtimeTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NotificationListener(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.extentAfter < 100) {
          _topTokenCubit.loadMore();
        }
        return false;
      },
      child: RefreshNotification(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          await _topTokenCubit.refresh();
          return true;
        },
        child: CustomScrollView(
          key: widget.key,
          slivers: [
            //二级tab
            if (widget.tabs != null && widget.tabs!.isNotEmpty)
              SecondaryLevelTabWidget(
                items: widget.tabs!
                    .map(
                      (e) => ChoiceItemEntity(
                        name: NameType.multilingual(e.name),
                        label: e.label,
                        value: e.value,
                      ),
                    )
                    .toList(),
                selectedValue: '',
                onChanged: (item) {
                  _topTokenCubit.state.queryParameters?[item.label] =
                      item.value;
                  _topTokenCubit.refresh();
                },
              ),

            //
            PullToRefreshContainer((PullToRefreshScrollNotificationInfo? info) {
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
                      child: NoDataWidget(errorTextDesc: S.of(context).noData),
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
                    final realtime = state.realtimeMap[token.uniqueId];
                    return VisibilityDetector(
                      key: ValueKey('top-token-${token.uniqueId}'),
                      onVisibilityChanged: (VisibilityInfo info) {
                        final isVisible = info.visibleFraction > 0;

                        _topTokenCubit.updateTokenVisibility(token, isVisible);
                      },
                      child: TokenListTile(
                        token: token,
                        realtimeToken: realtime,
                        onTap: () => _onTokenTap(token),
                        onLongPress: (ctx) => showTokenActionsPopover(
                          ctx,
                          onCollect: () => _onTokenCollect(
                            token,
                            _collectCubit.state.isCollected(token),
                          ),
                          isCollected: _collectCubit.state.isCollected(token),
                        ),
                      ),
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
