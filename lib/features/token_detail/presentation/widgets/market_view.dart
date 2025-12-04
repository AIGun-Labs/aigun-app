import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubits/token_detail/token_detail_cubit.dart';
import '../../../../cubits/token_detail/token_detail_state.dart';
import '../../../../screens/token_detail/widgets/candlestick.dart';
import '../../../../themes/themes.dart';
import 'ai_narrative_widget.dart';
import 'basic_info_widget.dart';
import 'community_widget.dart';
import 'latest_intel_widget.dart';
import 'my_holdings_widget.dart';
import 'token_info_widget.dart';

class MarketView extends StatelessWidget {
  const MarketView({super.key, required this.type});
  final String type;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TokenDetailCubit, TokenDetailState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              // 如果是
              // 从钱包进入的则显示我的持仓在前面
              if (type == 'wallet') ...[
                const MyHoldingsWidget(),
                Divider(height: 1, color: AppColors.border(context)),
              ],
              const TokenInfoWidget(),

              const LatestIntelWidget(),

              const Candlestick(),

              Divider(height: 1, color: AppColors.border(context)),
              // 如果不是从钱包进入，则显示我的持仓在这个位置
              if (type != 'wallet') ...[
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
      },
    );
  }
}
