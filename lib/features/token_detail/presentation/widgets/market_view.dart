import 'package:flutter/material.dart';

import '../../../../screens/token_detail/widgets/candlestick.dart';
import '../../../../themes/themes.dart';
import 'ai_narrative_widget.dart';
import 'basic_info_widget.dart';
import 'community_widget.dart';
import 'latest_intel_widget.dart';
import 'my_holdings_widget.dart';
import 'token_info_widget.dart';

class MarketView extends StatefulWidget {
  const MarketView({super.key, required this.type});
  final String type;

  @override
  State<MarketView> createState() => _MarketViewState();
}

class _MarketViewState extends State<MarketView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          // 如果是
          // 从钱包进入的则显示我的持仓在前面
          if (widget.type == 'wallet') ...[
            const MyHoldingsWidget(),
            Divider(height: 1, color: AppColors.border(context)),
          ],
          const TokenInfoWidget(),

          const LatestIntelWidget(),

          const Candlestick(),

          Divider(height: 1, color: AppColors.border(context)),
          // 如果不是从钱包进入，则显示我的持仓在这个位置
          if (widget.type != 'wallet') ...[
            const MyHoldingsWidget(),
            Divider(height: 1, color: AppColors.border(context)),
          ],
          // if (state.tokenDetailInfo?.narrative?.isNotEmpty ?? false) ...[
          const AINarrativeWidget(),
          Divider(height: 2, color: AppColors.border(context)),
          // ],
          const BasicInfoWidget(),
          // Divider(height: 2, color: AppColors.border(context)),
          const CommunityWidget(),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
