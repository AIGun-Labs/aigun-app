import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../cubits/intel/intel_cubit.dart';
import '../../../cubits/token_detail/token_detail_cubit.dart';
import '../../../cubits/token_detail/token_detail_state.dart';
import '../../../themes/themes.dart';
import '../../../utils/language_utils.dart';
import 'ai_narrative_section.dart';
import 'ai_news_section.dart';
import 'basic_info_section.dart';
import 'candlestick.dart';
import 'community_section.dart';
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
        final firstIntel = context
            .watch<IntelCubit>()
            .state
            .allMessages
            ?.firstOrNull;

        return SingleChildScrollView(
          controller: scrollController,
          physics: _enableParentScroll
              ? const AlwaysScrollableScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              
              
              // if (from == 'wallet') ...[
              //   const MarketTabHoldingsSection(),
              //   Divider(height: 1, color: AppColors.border(context)),
              // ],
              TokenInfoDisplay(
                priceUsd: state.tokenDetailInfo?.priceUsd ?? 0.0,
                marketCap: state.tokenDetailInfo?.marketCap ?? 0.0,
                liquidity: state.tokenDetailInfo?.liquidity ?? 0.0,
                volume24h: state.tokenDetailInfo?.volume24h ?? 0.0,
                holders: state.tokenDetailInfo?.holders ?? 0,
                priceChange24h: state.tokenDetailInfo?.priceChange24h ?? 0.0,
                highestPriceUsd:
                    state.tokenDetailInfo?.highestIncreaseRate ??
                    '0', 
                latestTime: !state.tokenAssociatedIntelsIsEmpty
                    ? state.tokenAssociatedIntels!.first.publishedAtLocal(
                        context,
                      )
                    : null,
                isMainStream: state.tokenDetailInfo?.isMainStream ?? true,
              ),
              if (firstIntel != null)
                GestureDetector(
                  onTap: () {
                    widget.tabController.animateTo(1);
                  },
                  child: AINewsSection(
                    time: firstIntel.publishedAtLocal(context),
                    content: LanguageUtils.getAnalyzedText(
                      context,
                      firstIntel.analyzed,
                    ),
                  ),
                ),
              const Candlestick(),

              Divider(height: 1, color: AppColors.border(context)),
              
              // if (from != 'wallet') ...[
              //   const MarketTabHoldingsSection(),
              //   Divider(height: 1, color: AppColors.border(context)),
              // ],
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

// class MarketTabHoldingsSection extends StatelessWidget {
//   const MarketTabHoldingsSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<TokenDetailCubit, TokenDetailState>(
//         builder: (context, state) {
//       final isLoadingProfit = state.tokenProfitState.maybeWhen(
//         orElse: () => false,
//         loading: () => true,
//       );
//       return MyHoldingsSection(
//         value: state.tokenProfitValue,
//         profit: double.tryParse(state.tokenProfit?.profit ?? '0') ?? 0.0,
//         holdings: double.tryParse(state.tokenProfit?.balance ?? '0') ?? 0.0,
//         profitPercent:
//             double.tryParse(state.tokenProfit?.riseFall ?? '0') ?? 0.0,
//         isLoading: isLoadingProfit && state.tokenProfit == null,
//       );
//     });
//   }
// }
