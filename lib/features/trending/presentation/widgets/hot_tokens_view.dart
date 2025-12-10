import 'dart:async';

import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:extended_sliver/extended_sliver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

import '../../../../core/router/routes/app_routes.dart';
import '../../../../core/service_locator.dart';
import '../../../../cubits/quick_trade/quick_trade_cubit.dart';
import '../../../../l10n/l10n.dart';
import '../../../../shared/presentation/widgets/multiple_choice.dart';
import '../../../../shared/presentation/widgets/no_data_widget.dart';
import '../../../../shared/presentation/widgets/refresher/refresh_header_widget.dart';
import '../../../../shared/presentation/widgets/refresher/refresh_notification.dart';
import '../../../../shared/presentation/widgets/skeleton/hot_token_card_skeleton.dart';
import '../../../../themes/colors.dart';
import '../../../../widgets/token/models/token.dart';
import '../../domain/entities/hot_token_entity.dart';
import '../../domain/mappers/hot_token_entity_mapper.dart';
import '../cubits/hot_token_cubit.dart';
import 'hot_token_card.dart';

class HotTokensView extends StatefulWidget {
  const HotTokensView({super.key, required this.pageStorageKey});
  final PageStorageKey pageStorageKey;

  @override
  State<HotTokensView> createState() => _HotTokensViewState();
}

class _HotTokensViewState extends State<HotTokensView>
    with AutomaticKeepAliveClientMixin {
  late final HotTokenCubit _hotTokenCubit;

  @override
  void initState() {
    super.initState();
    _hotTokenCubit = BlocProvider.of<HotTokenCubit>(context)
      ..init()
      ..startPolling();
  }

  @override
  void dispose() {
    _hotTokenCubit.stopPolling();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExtendedVisibilityDetector(
      uniqueKey: widget.pageStorageKey,

      child: RefreshNotification(
        onRefresh: () async {
          await BlocProvider.of<HotTokenCubit>(context).refresh();
          await Future.delayed(const Duration(seconds: 1));
          return true;
        },
        child: CustomScrollView(
          slivers: [
            SliverPinnedToBoxAdapter(child: _buildSignTypeChoice(context)),
            PullToRefreshContainer((PullToRefreshScrollNotificationInfo? info) {
              return SliverToBoxAdapter(child: RefreshHeaderWidget(info));
            }),
            // 内容区域
            BlocBuilder<HotTokenCubit, HotTokenState>(
              builder: (context, state) {
                if (state.status == HotTokenStatus.loading ||
                    state.status == HotTokenStatus.initial) {
                  return _buildLoadingSliver();
                }
                if (state.status == HotTokenStatus.failure) {
                  return SliverFillRemaining(
                    child: NoDataWidget(
                      onRetry: () =>
                          BlocProvider.of<HotTokenCubit>(context).init(),
                    ),
                  );
                }
                if (state.status == HotTokenStatus.empty) {
                  return SliverFillRemaining(
                    child: NoDataWidget(errorTextDesc: S.of(context).noData),
                  );
                }

                return _buildTokenGrid(state.tokens);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingSliver() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          childAspectRatio: 0.62,
          crossAxisSpacing: 8.w,
          mainAxisSpacing: 13.h,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => const HotTokenCardSkeleton(),
          childCount: 30, // 显示20个骨架卡片
        ),
      ),
    );
  }

  Widget _buildTokenGrid(List<HotTokenEntity> tokens) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          childAspectRatio: 0.62,
          crossAxisSpacing: 8.w,
          mainAxisSpacing: 13.h,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          final item = tokens[index];
          return HotTokenCard(
            token: tokens[index],
            onTap: () => _toTokenDetail(context, item),
          );
        }, childCount: tokens.length),
      ),
    );
  }

  Widget _buildSignTypeChoice(BuildContext context) {
    return BlocBuilder<HotTokenCubit, HotTokenState>(
      builder: (context, state) {
        return ExpandableScrollableWrap(
          backgroundColor: AppColors.background(context),
          spacing: 10.w,
          runSpacing: 10.h,
          padding: EdgeInsetsGeometry.only(
            left: 12.w,
            right: 12.w,
            top: 10.h,
            bottom: 6.h,
          ),
          selectedValue: state.selectedNetwork,
          onSelected: (value) {
            BlocProvider.of<HotTokenCubit>(context).switchNetwork(value);
          },
          items: [
            ChoiceItem(label: S.of(context).all, value: 'all'),
            ...state.supportedNetworks.entries.map(
              (e) => ChoiceItem(label: e.key, value: e.value),
            ),
          ],
        );
      },
    );
  }

  void _toTokenDetail(BuildContext context, HotTokenEntity item) {
    final newToken = Token.fromHotTokenEntity(item);
    getIt<QuickTradeCubit>().updateSelectedToken(newToken);
    TokenDetailRoute(
      item.toTokenEntity(),
      type: 'trending',
      tokenType: 'top',
    ).push(context);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
