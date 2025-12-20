//收藏列表
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

import '../../../../core/router/routes/app_routes.dart';
import '../../../../cubits/quick_trade/quick_trade_cubit.dart';
import '../../../../l10n/l10n.dart';
import '../../../../shared/domain/entities/base_token_entity.dart';
import '../../../../shared/domain/mappers/token_entity_mapper.dart';
import '../../../../shared/presentation/utils/show_token_actions_popover.dart';
import '../../../../shared/presentation/widgets/no_data_widget.dart';
import '../../../../shared/presentation/widgets/refresher/refresh_header_widget.dart';
import '../../../../shared/presentation/widgets/refresher/refresh_notification.dart';
import '../../../../shared/presentation/widgets/skeleton/token_list_tile_skeleton.dart';
import '../../../../shared/presentation/widgets/token/token_list_tile.dart';
import '../cubits/collect_cubit.dart';

class CollectTokensView extends StatefulWidget {
  const CollectTokensView({super.key, required this.index});
  final int index;

  @override
  State<CollectTokensView> createState() => _CollectTokensViewState();
}

class _CollectTokensViewState extends State<CollectTokensView>
    with AutomaticKeepAliveClientMixin {
  late final CollectCubit _collectCubit;
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _collectCubit = BlocProvider.of<CollectCubit>(context)..loadCollectTokens();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tabController ??= DefaultTabController.of(context);
  }

  void _onTokenTap(BaseTokenEntity token) {
    final newToken = token.toToken();
    BlocProvider.of<QuickTradeCubit>(context).updateSelectedToken(newToken);
    // 跳转到代币详情页面
    TokenDetailRoute(token).push(context);
  }

  Future<void> _onTokenPin(BaseTokenEntity token) async {
    await _collectCubit.pinCollectToken(
      network: token.network,
      address: token.address,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshNotification(
      onRefresh: () async {
        if (_tabController?.index == widget.index) {
          await _collectCubit.loadCollectTokens();
          await Future.delayed(const Duration(seconds: 1));
          return true;
        }
        return true;
      },
      child: CustomScrollView(
        key: PageStorageKey(widget.key),
        restorationId: widget.key.toString(),
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
                      const TokenListTileSkeleton(),
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
                  final token = state.tokens[index];

                  return TokenListTile(
                    token: token,
                    onTap: () => _onTokenTap(token),
                    onLongPress: (ctx) => showTokenActionsPopover(
                      ctx,
                      onTransfer: () => _onTokenPin(token),
                      onCollect: () =>
                          _collectCubit.handleCollect(token: token),
                      isCollected: state.isCollected(token),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
