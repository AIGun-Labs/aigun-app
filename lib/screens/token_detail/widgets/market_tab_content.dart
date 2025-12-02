import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../cubits/token_detail/token_detail_cubit.dart';
import '../../../cubits/token_detail/token_detail_state.dart';
import '../../../themes/themes.dart';
import 'ai_narrative_section.dart';
import 'ai_news_section.dart';
import 'basic_info_section.dart';
import 'candlestick.dart';
import 'community_section.dart';
import 'my_holdings_section.dart';
import 'token_info_display.dart';

class MarketTabContent extends StatefulWidget {
  const MarketTabContent({super.key, required this.tabController});

  final TabController tabController;

  @override
  State<MarketTabContent> createState() => _MarketTabContentState();
}

class _MarketTabContentState extends State<MarketTabContent> {
  late final ScrollController scrollController;
  final bool _enableParentScroll = true;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String from = 'other';
    try {
      final extra = GoRouterState.of(context).extra;
      from = extra is String ? extra : 'other';
    } catch (_) {}
    return BlocBuilder<TokenDetailCubit, TokenDetailState>(
      builder: (context, state) {
        return SingleChildScrollView(
          controller: scrollController,
          physics: _enableParentScroll
              ? const AlwaysScrollableScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              // 如果是
              // 从钱包进入的则显示我的持仓在前面
              if (from == 'wallet') ...[
                const MarketTabHoldingsSection(),
                Divider(height: 1, color: AppColors.border(context)),
              ],
              const TokenInfoDisplay(),
              AINewsSection(
                onTap: () {
                  widget.tabController.animateTo(1);
                },
              ),
              const Candlestick(),

              Divider(height: 1, color: AppColors.border(context)),
              // 如果不是从钱包进入，则显示我的持仓在这个位置
              if (from != 'wallet') ...[
                const MarketTabHoldingsSection(),
                Divider(height: 1, color: AppColors.border(context)),
              ],
              // if (state.tokenDetailInfo?.narrative?.isNotEmpty ?? false) ...[
              AINarrativeSection(
                isLoading: false,
                contents: state.tokenDetailInfo?.narrative,
              ),
              Divider(height: 2, color: AppColors.border(context)),
              // ],
              BasicInfoSection(
                contractAddress: state.token?.address ?? '',
                blockchain: state.token?.chainName ?? '',
              ),
              // Divider(height: 2, color: AppColors.border(context)),
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
    return BlocBuilder<TokenDetailCubit, TokenDetailState>(
      buildWhen: (previous, current) {
        return previous.tokenProfit != current.tokenProfit ||
            previous.tokenDetailInfo != current.tokenDetailInfo;
      },
      builder: (context, state) {
        final isLoadingProfit = state.tokenProfitState.maybeWhen(
          orElse: () => false,
          loading: () => true,
        );
        return MyHoldingsSection(
          value: state.value,
          holdings: state.holdings,
          changePrecent: state.changePrecent,
          profit: state.profit,
          isLoading: isLoadingProfit && state.tokenProfit == null,
        );
      },
    );
  }
}
