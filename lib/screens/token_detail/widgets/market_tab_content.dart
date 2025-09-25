import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/token_detail/token_detail_cubit.dart';
import 'package:flutter_aigun/cubits/token_detail/token_detail_state.dart';
import 'package:flutter_aigun/screens/token_detail/widgets/ai_narrative_section.dart';
import 'package:flutter_aigun/screens/token_detail/widgets/ai_news_section.dart';
import 'package:flutter_aigun/screens/token_detail/widgets/basic_info_section.dart';
import 'package:flutter_aigun/screens/token_detail/widgets/community_section.dart';
import 'package:flutter_aigun/screens/token_detail/widgets/k_line.dart';
import 'package:flutter_aigun/screens/token_detail/widgets/my_holdings_section.dart';
import 'package:flutter_aigun/screens/token_detail/widgets/token_info_display.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MarketTabContent extends StatelessWidget {
  const MarketTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra;
    final from = extra is String ? extra : 'other';
    return BlocBuilder<TokenDetailCubit, TokenDetailState>(
        builder: (context, state) {
      final token = state.token;
      return BlocBuilder<TokenDetailCubit, TokenDetailState>(
          builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              // 如果是从钱包进入的则显示我的持仓在前面
              if (from == 'wallet') ...[
                const MyHoldingsSection(
                  value: 12.11,
                  profit: 12.11,
                  holdings: 1234123,
                  profitPercent: 25,
                ),
                Divider(height: 1, color: AppColors.border(context)),
              ],
              TokenInfoDisplay(
                price: state.tokenDetailInfo?.priceUsd ?? 0.0,
                priceChangePercent: 25.2,
                marketCap: state.tokenDetailInfo?.marketCap ?? 0.0,
                liquidity: state.tokenDetailInfo?.liquidity ?? 0.0,
                volume24h: state.tokenDetailInfo?.volume24h ?? 0.0,
                holders: state.tokenDetailInfo?.holders ?? 0,
                multiplier: state.tokenDetailInfo?.highestPriceUsd ?? 0,
                highestPriceUsd: state.tokenDetailInfo?.highestPriceUsd ?? 0,
                lastUpdateTime: '9.6 12:12',
              ),
              Divider(height: 1, color: AppColors.border(context)),
              const AINewsSection(),
              Padding(
                padding: EdgeInsets.all(16.w),
                child: KLine(
                  height: 509.h,
                  address: token?.address ?? '',
                  chainName: token?.chainName.toLowerCase() ?? '',
                ),
              ),
              Divider(height: 1, color: AppColors.border(context)),
              // 如果不是从钱包进入，则显示我的持仓在这个位置
              if (from != 'wallet') ...[
                const MyHoldingsSection(
                  value: 12.11,
                  profit: 12.11,
                  holdings: 1234123,
                  profitPercent: 25,
                ),
                Divider(height: 1, color: AppColors.border(context)),
              ],
              const AINarrativeSection(),
              Divider(height: 2, color: AppColors.border(context)),
              BasicInfoSection(
                contractAddress: state.token?.address ?? '',
                blockchain: state.token?.chainName ?? '',
              ),
              Divider(height: 2, color: AppColors.border(context)),
              const CommunitySection(),
            ],
          ),
        );
      });
    });
  }
}
