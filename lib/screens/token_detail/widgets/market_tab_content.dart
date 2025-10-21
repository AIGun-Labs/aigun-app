import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/intel/intel_cubit.dart';
import 'package:flutter_aigun/cubits/token_detail/token_detail_cubit.dart';
import 'package:flutter_aigun/cubits/token_detail/token_detail_state.dart';
import 'package:flutter_aigun/screens/token_detail/widgets/ai_narrative_section.dart';
import 'package:flutter_aigun/screens/token_detail/widgets/ai_news_section.dart';
import 'package:flutter_aigun/screens/token_detail/widgets/basic_info_section.dart';
import 'package:flutter_aigun/screens/token_detail/widgets/community_section.dart';
import 'package:flutter_aigun/screens/token_detail/widgets/candlestick.dart';
import 'package:flutter_aigun/screens/token_detail/widgets/my_holdings_section.dart';
import 'package:flutter_aigun/screens/token_detail/widgets/token_info_display.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MarketTabContent extends StatelessWidget {
  const MarketTabContent({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    String from = 'other';
    try {
      final extra = GoRouterState.of(context).extra;
      from = extra is String ? extra : 'other';
    } catch (_) {}
    return BlocBuilder<TokenDetailCubit, TokenDetailState>(
      builder: (context, state) {
        final token = state.token;

        final isLoading = state.tokenDetailInfoState.maybeWhen(
          orElse: () => false,
          loading: () => true,
        );

        final firstIntel =
            context.watch<IntelCubit>().state.allMessages?.firstOrNull;

        return SingleChildScrollView(
          child: Column(
            children: [
              // 如果是从钱包进入的则显示我的持仓在前面
              if (from == 'wallet') ...[
                const MarketTabHoldingsSection(),
                Divider(height: 1, color: AppColors.border(context)),
              ],
              TokenInfoDisplay(
                priceUsd: state.tokenDetailInfo?.priceUsd ?? 0.0,
                marketCap: state.tokenDetailInfo?.marketCap ?? 0.0,
                liquidity: state.tokenDetailInfo?.liquidity ?? 0.0,
                volume24h: state.tokenDetailInfo?.volume24h ?? 0.0,
                holders: state.tokenDetailInfo?.holders ?? 0,
                priceChange24h: state.tokenDetailInfo?.priceChange24h ?? 0.0,
                highestPriceUsd: state.tokenDetailInfo?.highestIncreaseRate ??
                    '0', // 暂时没有最高价格 先等后端返回数据结构
                latestTime: state.tokenAssociatedIntels?.isNotEmpty == true
                    ? state.tokenAssociatedIntels!.first.publishedAt
                    : null,
              ),
              GestureDetector(
                onTap: () {
                  tabController.animateTo(1);
                },
                child: AINewsSection(
                  time: firstIntel?.publishedAt,
                  // TODO： 记得根据用户语言切换
                  content: firstIntel?.analyzed?.zh,
                ),
              ),
              Candlestick(
                key: ValueKey(
                  'candlestick_${token?.address}_${token?.network}',
                ),
                height: 300.h,
                address: token?.address ?? '',
                network: token?.network ?? '',
                symbol: token?.symbol ?? '',
              ),

              Divider(height: 1, color: AppColors.border(context)),
              // 如果不是从钱包进入，则显示我的持仓在这个位置
              if (from != 'wallet') ...[
                const MarketTabHoldingsSection(),
                Divider(height: 1, color: AppColors.border(context)),
              ],
              // if (state.tokenDetailInfo?.narrative?.isNotEmpty ?? false) ...[
              AINarrativeSection(
                isLoading: isLoading,
                content: state.tokenDetailInfo?.narrative ?? "",
              ),
              Divider(height: 2, color: AppColors.border(context)),
              // ],
              BasicInfoSection(
                contractAddress: state.token?.address ?? '',
                blockchain: state.token?.chainName ?? '',
              ),
              Divider(height: 2, color: AppColors.border(context)),
              const CommunitySection(),
            ],
          ),
        );
      },
    );
  }
}

class MarketTabHoldingsSection extends StatelessWidget {
  const MarketTabHoldingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<TokenDetailCubit>().state;
    final isLoadingProfit = state.tokenProfitState.maybeWhen(
      orElse: () => false,
      loading: () => true,
    );

    return MyHoldingsSection(
      value: double.parse(state.tokenProfit?.value ?? '0'),
      profit: double.parse(state.tokenProfit?.profit ?? '0'),
      holdings: int.parse(state.tokenProfit?.balance ?? '0'),
      profitPercent: double.parse(state.tokenProfit?.riseFall ?? '0'),
      isLoading: isLoadingProfit,
    );
  }
}
