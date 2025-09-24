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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MarketTabContent extends StatelessWidget {
  const MarketTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    final from = GoRouterState.of(context).extra as String;
    return BlocBuilder<TokenDetailCubit, TokenDetailState>(
        builder: (context, state) {
      final token = state.token;
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
              const Divider(height: 1, color: Color(0xFFDDE3E1)),
            ],
            const TokenInfoDisplay(
              price: 0.015047,
              priceChangePercent: 25.2,
              marketCap: 80200,
              liquidity: 5200,
              volume24h: 768200,
              holders: 1921,
              multiplier: 299,
              lastUpdateTime: '9.6 12:12',
            ),
            const Divider(height: 1, color: Color(0xFFDDE3E1)),
            const AINewsSection(),
            KLine(
              height: 509.h,
              address: token?.address ?? '',
              chainName: token?.chainName.toLowerCase() ?? '',
            ),
            const Divider(height: 1, color: Color(0xFFDDE3E1)),
            // 如果不是从钱包进入，则显示我的持仓在这个位置
            if (from != 'wallet') ...[
              const MyHoldingsSection(
                value: 12.11,
                profit: 12.11,
                holdings: 1234123,
                profitPercent: 25,
              ),
              const Divider(height: 1, color: Color(0xFFDDE3E1)),
            ],
            const AINarrativeSection(),
            const Divider(height: 2, color: Color(0xFFDDE3E1)),
            const BasicInfoSection(
              contractAddress: 'pump123456789abcdef2344',
              blockchain: 'Solana',
            ),
            const Divider(height: 2, color: Color(0xFFDDE3E1)),
            const CommunitySection(),
          ],
        ),
      );
    });
  }
}
