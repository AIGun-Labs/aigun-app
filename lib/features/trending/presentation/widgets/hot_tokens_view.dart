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

class _HotTokensViewState extends State<HotTokensView> {
  late final HotTokenCubit _cubit;
  Map<String, String> _networks = {};
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<HotTokenCubit>();

    // 加载网络列表和初始数据
    _initializeData();
    _startAutoRefresh();
  }

  Future<void> _initializeData() async {
    // 获取支持的网络列表
    final networks = await _cubit.getSupportedNetworks();
    if (mounted) {
      setState(() {
        _networks = networks;
      });
    }

    // 加载初始数据
    await _cubit.loadInitial();
  }

  void _startAutoRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        _cubit.refresh();
      }
    });
  }

  void _stopAutoRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = null;
  }

  @override
  void dispose() {
    _stopAutoRefresh();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExtendedVisibilityDetector(
      uniqueKey: widget.pageStorageKey,
      child: RefreshNotification(
        onRefresh: () async {
          await _cubit.refresh();
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
              bloc: _cubit,
              builder: (context, state) {
                return state.maybeWhen(
                  initial: () => _buildLoadingSliver(),
                  loading: (previousTokens, selectedNetwork) {
                    // 如果有旧数据，继续显示旧数据；否则显示骨架屏
                    if (previousTokens != null && previousTokens.isNotEmpty) {
                      return _buildTokenGrid(previousTokens);
                    }
                    return _buildLoadingSliver();
                  },
                  loaded: (tokens, selectedNetwork) => _buildTokenGrid(tokens),
                  orElse: () => SliverFillRemaining(
                    child: Center(child: Text(S.of(context).noData)),
                  ),
                );
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
      selectedValue: _cubit.selectedNetwork,
      onSelected: (value) {
        _cubit.selectNetwork(value);
      },
      items: [
        ChoiceItem(label: S.of(context).all, value: 'all'),
        ..._networks.entries.map(
          (e) => ChoiceItem(label: e.key, value: e.value),
        ),
      ],
    );
  }

  void _toTokenDetail(BuildContext context, HotTokenEntity item) {
    final newToken = Token.fromHotTokenEntity(item);
    // final tokenDetailCubit = getIt<TokenDetailCubit>();
    // tokenDetailCubit.updateToken(newToken);
    // tokenDetailCubit.updateType('top');
    getIt<QuickTradeCubit>().updateSelectedToken(newToken);
    TokenDetailRoute(
      item.toTokenEntity(),
      type: 'trending',
      tokenType: 'top',
    ).push(context);
  }
}
