import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../cubits/token_detail/token_detail_cubit.dart';
import '../../../../cubits/token_detail/token_detail_state.dart';
import '../../../../screens/token_detail/widgets/ai_narrative_section.dart';
import '../../../../screens/token_detail/widgets/ai_news_section.dart';
import '../../../../screens/token_detail/widgets/basic_info_section.dart';
import '../../../../screens/token_detail/widgets/candlestick.dart';
import '../../../../screens/token_detail/widgets/community_section.dart';
import '../../../../screens/token_detail/widgets/my_holdings_section.dart';
import '../../../../themes/themes.dart';
import 'token_info_widget.dart';

class MarketView extends StatelessWidget {
  const MarketView({super.key});

  @override
  Widget build(BuildContext context) {
    final tabController = DefaultTabController.of(context);
    String from = 'other';
    try {
      final extra = GoRouterState.of(context).extra;
      from = extra is String ? extra : 'other';
    } catch (_) {}
    return BlocBuilder<TokenDetailCubit, TokenDetailState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              // 如果是
              // 从钱包进入的则显示我的持仓在前面
              if (from == 'wallet') ...[
                const MarketTabHoldingsSection(),
                Divider(height: 1, color: AppColors.border(context)),
              ],
              const TokenInfoWidget(),
              AINewsSection(
                onTap: () {
                  tabController.animateTo(1);
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
