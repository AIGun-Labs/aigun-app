import 'dart:async';

import 'package:extended_sliver/extended_sliver.dart';
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
import '../../../../shared/presentation/widgets/skeleton/token_grid_card_skeleton.dart';
import '../../../../shared/presentation/widgets/token/token_grid_card.dart';
import '../../../collect/presentation/cubits/collect_cubit.dart';
import '../../../dynamic_tabs/domain/entities/option_tab_entity.dart';
import '../../../dynamic_tabs/presentation/widgets/secondary_level_tab_widget.dart';
import '../cubits/tokens/tokens_cubit.dart';

class TokenGridView extends StatefulWidget {
  const TokenGridView({super.key, required this.index, this.tabs});
  final int index;
  final List<OptionTabItemEntity>? tabs;

  @override
  State<TokenGridView> createState() => _TokenGridViewState();
}

class _TokenGridViewState extends State<TokenGridView>
    with AutomaticKeepAliveClientMixin {
  late final TokensCubit _tokensCubit;
  late final CollectCubit _collectCubit;
  TabController? _tabController;

  void _onTokenTap(BaseTokenEntity token) {
    final newToken = token.toToken();
    BlocProvider.of<QuickTradeCubit>(context).updateSelectedToken(newToken);
    TokenDetailRoute(token).push(context);
  }

  @override
  void initState() {
    super.initState();
    _tokensCubit = BlocProvider.of<TokensCubit>(context)..init();
    // ..startRealtimeTimer();
    _collectCubit = BlocProvider.of<CollectCubit>(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tabController ??= DefaultTabController.of(context);
  }

  @override
  void dispose() {
    // _tokensCubit.stopRealtimeTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final SliverGridDelegate sliverGridDelegate =
        SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          childAspectRatio: 0.62,
          crossAxisSpacing: 8.w,
          mainAxisSpacing: 13.h,
        );

    return NotificationListener(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo is ScrollUpdateNotification &&
            (scrollInfo.scrollDelta ?? 0) > 0 &&
            scrollInfo.metrics.extentAfter < 200) {
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
          slivers: [
            if (widget.tabs != null && widget.tabs!.isNotEmpty)
              SliverPinnedToBoxAdapter(
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
            PullToRefreshContainer((PullToRefreshScrollNotificationInfo? info) {
              return SliverToBoxAdapter(child: RefreshHeaderWidget(info));
            }),
            SliverPadding(
              padding: .symmetric(horizontal: 15.w),
              sliver: BlocBuilder<TokensCubit, TokensState>(
                builder: (context, state) {
                  if (state.status == TokensStatus.loading ||
                      state.status == TokensStatus.initial) {
                    return SliverGrid.builder(
                      gridDelegate: sliverGridDelegate,
                      itemBuilder: (context, index) =>
                          const TokenGridCardSkeleton(),
                      itemCount: 35,
                    );
                  }

                  if (state.status == TokensStatus.failure) {
                    if (state.tokens.isEmpty) {
                      return SliverFillRemaining(
                        child: NoDataWidget(
                          errorTextDesc: S.of(context).noData,
                        ),
                      );
                    } else {
                      return SliverFillRemaining(
                        child: NoDataWidget(
                          onRetry: () => _tokensCubit.refresh(),
                        ),
                      );
                    }
                  }

                  return SliverGrid.builder(
                    gridDelegate: sliverGridDelegate,
                    itemCount:
                        state.tokens.length + (state.isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == state.tokens.length) {
                        return const TokenGridCardSkeleton();
                      }

                      final token = state.tokens[index];
                      final realtime = state.realtimeMap[token.uniqueId];
                      return VisibilityDetector(
                        key: ValueKey('${widget.key}:${token.uniqueId}'),
                        onVisibilityChanged: (VisibilityInfo info) {
                          final isVisible = info.visibleFraction > 0;
                          _tokensCubit.updateTokenVisibility(token, isVisible);
                        },
                        child: TokenGridCard(
                          token: token,
                          realtimeToken: realtime,
                          onTap: () => _onTokenTap(token),
                          onLongPress: (context) => showTokenActionsPopover(
                            context,
                            onCollect: () =>
                                _collectCubit.handleCollect(token: token),
                            isCollected: _collectCubit.state.isCollected(token),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
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
