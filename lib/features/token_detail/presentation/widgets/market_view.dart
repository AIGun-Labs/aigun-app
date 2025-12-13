import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../themes/themes.dart';
import '../../../candlestick/presentation/widgets/candlestick.dart';
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

          // const Candlestick(),
          // 阻止 TabBarView 拦截水平滑动，同时让 candlestick 内部手势正常工作
          _HorizontalDragBlocker(
            child: AIGunCandlestick(),
          ),

          // 阻止 TabBarView 拦截水平滑动，同时让 candlestick 内部手势正常工作
          // _HorizontalDragBlocker(child: AIGunCandlestick()),
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

/// 阻止水平拖动冒泡到 TabBarView，同时让子组件的手势正常工作
class _HorizontalDragBlocker extends StatelessWidget {
  final Widget child;
  const _HorizontalDragBlocker({required this.child});

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: <Type, GestureRecognizerFactory>{
        // 阻止水平拖动手势冒泡到 TabBarView
        _AlwaysWinPanRecognizer:
            GestureRecognizerFactoryWithHandlers<_AlwaysWinPanRecognizer>(
              () => _AlwaysWinPanRecognizer(),
              (_) {},
            ),
      },
      behavior: HitTestBehavior.translucent,
      child: child,
    );
  }
}

/// 使用 PanGestureRecognizer 代替 HorizontalDragGestureRecognizer
/// PanGestureRecognizer 可以同时处理水平和垂直拖动，与 ScaleGestureRecognizer 更好地共存
class _AlwaysWinPanRecognizer extends PanGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    // 不拒绝，改为接受，这样 TabBarView 就无法拦截
    acceptGesture(pointer);
  }
}
