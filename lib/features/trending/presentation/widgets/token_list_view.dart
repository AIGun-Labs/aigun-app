import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import '../../../../shared/presentation/widgets/skeleton/token_list_tile_skeleton.dart';
import '../../../../shared/presentation/widgets/token/token_list_tile.dart';
import '../../../../themes/colors.dart';
import '../../../../utils/toast.dart';
import '../../../collect/presentation/cubits/collect_cubit.dart';
import '../../../dynamic_tabs/domain/entities/option_tab_entity.dart';
import '../../../dynamic_tabs/presentation/widgets/secondary_level_tab_widget.dart';
import '../cubits/tokens/tokens_cubit.dart';

class TokenListView extends StatefulWidget {
  final int index;
  const TokenListView({super.key, required this.index, this.tabs});
  final List<OptionTabItemEntity>? tabs;
  @override
  State<TokenListView> createState() => _TokenListViewState();
}

class _TokenListViewState extends State<TokenListView>
    with AutomaticKeepAliveClientMixin {
  late final TokensCubit _tokensCubit;
  TabController? _tabController;
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
    _tokensCubit = BlocProvider.of<TokensCubit>(context)
      ..init()
      ..startRealtimeTimer();
    _collectCubit = BlocProvider.of<CollectCubit>(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tabController ??= DefaultTabController.of(context);
  }

  @override
  void dispose() {
    _tokensCubit.stopRealtimeTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NotificationListener(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.extentAfter < 100) {
          _tokensCubit.loadMore();
        }
        return false;
      },
      child: RefreshNotification(
        onRefresh: () async {
          if (_tabController?.index == widget.index) {
            await Future.delayed(const Duration(seconds: 1));
            await _tokensCubit.refresh();
            return true;
          }
          return true;
        },
        child: CustomScrollView(
          key: PageStorageKey(widget.key),
          restorationId: widget.key.toString(),
          slivers: [
            if (widget.tabs != null && widget.tabs!.isNotEmpty)
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverTabbarDelegate(
                  PreferredSize(
                    preferredSize: Size.fromHeight(40.h),
                    child: SecondaryLevelTabWidget(
                      items: widget.tabs!
                          .map(
                            (e) => ChoiceItemEntity(
                              name: NameType.multilingual(e.name),
                              label: e.label,
                              value: e.value,
                            ),
                          )
                          .toList(),
                      selectedValue: widget.tabs!.first.value,
                      onChanged: (item) {
                        _tokensCubit.state.queryParameters?[item.label] =
                            item.value;
                        _tokensCubit.refresh();
                      },
                    ),
                  ),
                ),
              ),

            PullToRefreshContainer((PullToRefreshScrollNotificationInfo? info) {
              return SliverToBoxAdapter(child: RefreshHeaderWidget(info));
            }),
            BlocBuilder<TokensCubit, TokensState>(
              builder: (context, state) {
                if (state.status == TokensStatus.loading ||
                    state.status == TokensStatus.initial) {
                  return SliverList.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) =>
                        const TokenListTileSkeleton(),
                  );
                }

                if (state.status == TokensStatus.failure) {
                  if (state.tokens.isEmpty) {
                    return SliverFillRemaining(
                      child: NoDataWidget(errorTextDesc: S.of(context).noData),
                    );
                  } else {
                    return SliverFillRemaining(
                      child: NoDataWidget(
                        onRetry: () => _tokensCubit.refresh(),
                      ),
                    );
                  }
                }

                return SliverList.builder(
                  itemCount: state.tokens.length + (state.hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == state.tokens.length) {
                      return const TokenListTileSkeleton();
                    }

                    final token = state.tokens[index];
                    final realtime = state.realtimeMap[token.uniqueId];
                    return VisibilityDetector(
                      key: ValueKey('${widget.key}:${token.uniqueId}'),
                      onVisibilityChanged: (VisibilityInfo info) {
                        final isVisible = info.visibleFraction > 0;

                        _tokensCubit.updateTokenVisibility(token, isVisible);
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
  bool get wantKeepAlive => true;
}

class _SliverTabbarDelegate extends SliverPersistentHeaderDelegate {
  const _SliverTabbarDelegate(this.tabBar);

  final PreferredSizeWidget tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: AppColors.background(context), child: tabBar);
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
