import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/token_detail/token_detail_cubit.dart';
import 'package:flutter_aigun/cubits/token_detail/token_detail_state.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/screens/token_detail/widgets/k_line.dart';
import 'package:flutter_aigun/screens/token_detail/widgets/token_header_bar.dart';
import 'package:flutter_aigun/screens/token_detail/widgets/token_info_display.dart';
import 'package:flutter_aigun/screens/token_detail/widgets/token_tab_section.dart';
import 'package:flutter_aigun/screens/token_detail/widgets/my_holdings_section.dart';
import 'package:flutter_aigun/screens/token_detail/widgets/ai_news_section.dart';
import 'package:flutter_aigun/screens/token_detail/widgets/ai_narrative_section.dart';
import 'package:flutter_aigun/screens/token_detail/widgets/basic_info_section.dart';
import 'package:flutter_aigun/screens/token_detail/widgets/community_section.dart';
import 'package:flutter_aigun/screens/token_detail/widgets/trade_buttons.dart';
import 'package:flutter_aigun/screens/token_detail/widgets/risk_tab_content.dart';
import 'package:flutter_aigun/screens/token_detail/widgets/ai_tab_content.dart';
import 'package:flutter_aigun/widgets/button/primary.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class TokenDetailScreen extends StatefulWidget {
  const TokenDetailScreen({super.key});

  @override
  State<TokenDetailScreen> createState() => _TokenDetailScreenState();
}

class _TokenDetailScreenState extends State<TokenDetailScreen> {
  int _selectedTab = 0;

  Widget _buildTabContent(Token? token) {
    switch (_selectedTab) {
      case 0: // 行情 tab
        return SingleChildScrollView(
          child: Column(
            children: [
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
              const MyHoldingsSection(
                value: 12.11,
                profit: 12.11,
                holdings: 1234123,
                profitPercent: 25,
              ),
              const Divider(height: 1, color: Color(0xFFDDE3E1)),
              const AINarrativeSection(),
              const Divider(height: 2, color: Color(0xFFDDE3E1)),
              const BasicInfoSection(
                contractAddress: 'pump123456789abcdef2344',
                blockchain: 'Solana',
              ),
              const Divider(height: 2, color: Color(0xFFDDE3E1)),
              const CommunitySection(),
              SizedBox(height: 70.h),
            ],
          ),
        );
      case 1: // AI tab
        return Padding(
          padding: EdgeInsets.only(bottom: 70.h),
          child: const AITabContent(),
        );
      case 2: // 风险 tab
        return Padding(
          padding: EdgeInsets.only(bottom: 70.h),
          child: const RiskTabContent(),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TokenHeaderBar(),
      body: BlocBuilder<TokenDetailCubit, TokenDetailState>(
          builder: (context, state) {
        final token = state.token;

        return Stack(
          children: [
            Column(
              children: [
                TokenTabSection(
                  selectedIndex: _selectedTab,
                  onTabChanged: (index) {
                    setState(() {
                      _selectedTab = index;
                    });
                  },
                ),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: KeyedSubtree(
                      key: ValueKey<int>(_selectedTab),
                      child: _buildTabContent(token),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      }),
      bottomNavigationBar: BlocBuilder<TokenDetailCubit, TokenDetailState>(
          builder: (context, state) {
        return SafeArea(
            child: Padding(
                padding: EdgeInsets.only(top: 8.h, left: 16.w, right: 16.w),
                child: const TradeButtons()));
      }),
    );
  }
}
