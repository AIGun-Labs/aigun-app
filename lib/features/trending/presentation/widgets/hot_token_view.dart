import 'dart:async';

import 'package:extended_sliver/extended_sliver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../core/router/constants.dart';
import '../../../../core/service_locator.dart';
import '../../../../cubits/quick_trade/quick_trade_cubit.dart';
import '../../../../cubits/token_detail/token_detail_cubit.dart';
import '../../../../l10n/l10n.dart';
import '../../../../widgets/token/models/token.dart';
import '../../domain/entities/hot_token_entity.dart';
import '../cubits/hot_token_cubit.dart';
import '../cubits/hot_token_state.dart';
import 'hot_token_card.dart';
import 'hot_token_card_skeleton.dart';
import 'hot_token_filter_header.dart';

class HotTokenView extends StatefulWidget {
  const HotTokenView({super.key});

  @override
  State<HotTokenView> createState() => _HotTokenViewState();
}

class _HotTokenViewState extends State<HotTokenView>
    with AutomaticKeepAliveClientMixin {
  late final HotTokenCubit _cubit;
  Map<String, String> _networks = {};
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<HotTokenCubit>();

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
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<HotTokenCubit, HotTokenState>(
      bloc: _cubit,
      builder: (context, state) {
        return VisibilityDetector(
          key: const Key('hot_token_list'),
          onVisibilityChanged: (visibilityInfo) {
            // 监听可见性变化
            if (visibilityInfo.visibleFraction > 0) {
              _startAutoRefresh();
            } else {
              _stopAutoRefresh();
            }
          },
          child: CustomScrollView(
            slivers: [
              // 粘性筛选头部
              SliverPinnedToBoxAdapter(
                child: HotTokenFilterHeader(
                  selectedNetwork: _cubit.selectedNetwork,
                  networks: _networks,
                  onNetworkSelected: (network) {
                    _cubit.selectNetwork(network);
                  },
                ),
              ),

              // 内容区域
              state.maybeWhen(
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
                  child: Center(
                    child: Text(S.of(context).noData),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoadingSliver() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
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
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          childAspectRatio: 0.62,
          crossAxisSpacing: 8.w,
          mainAxisSpacing: 13.h,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final item = tokens[index];
            return HotTokenCard(
                token: tokens[index],
                onTap: () => _toTokenDetail(context, item));
          },
          childCount: tokens.length,
        ),
      ),
    );
  }

  void _toTokenDetail(BuildContext context, HotTokenEntity item) {
    final newToken = Token.fromHotTokenEntity(item);
    final tokenDetailCubit = getIt<TokenDetailCubit>();
    tokenDetailCubit.updateToken(newToken);
    tokenDetailCubit.updateType("top");
    getIt<QuickTradeCubit>().updateSelectedToken(newToken);
    context.pushNamed(RouteNames.tokenDetail, extra: 'trending');
  }
}
