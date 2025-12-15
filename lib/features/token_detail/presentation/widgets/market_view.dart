import 'package:candlestick/candlestick.dart' show ChartGestureState;
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
  const MarketView({super.key, this.type});
  final String? type;

  @override
  State<MarketView> createState() => _MarketViewState();
}

class _MarketViewState extends State<MarketView>
    with AutomaticKeepAliveClientMixin {
  /// 是否阻止父级滚动
  /// 当 K 线图正在缩放或水平拖动时，阻止父级滚动
  bool _blockScroll = false;

  /// 处理 K 线图手势状态变化
  void _onCandlestickGestureStateChanged(ChartGestureState state) {
    final shouldBlock =
        state == ChartGestureState.scaling ||
        state == ChartGestureState.horizontalDragging;

    if (_blockScroll != shouldBlock) {
      setState(() {
        _blockScroll = shouldBlock;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      // 根据 K 线图手势状态动态切换滚动物理
      physics: _blockScroll
          ? const NeverScrollableScrollPhysics()
          : const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          if (widget.type == 'wallet') ...[
            const MyHoldingsWidget(),
            Divider(height: 1, color: AppColors.border(context)),
          ],
          const TokenInfoWidget(),

          const LatestIntelWidget(),

          // K 线图组件，通过回调通知手势状态变化
          AIGunCandlestick(
            onGestureStateChanged: _onCandlestickGestureStateChanged,
          ),

          Divider(height: 1, color: AppColors.border(context)),
          // 如果不是从钱包进入，则显示我的持仓在这个位置
          if (widget.type != 'wallet') ...[
            const MyHoldingsWidget(),
            Divider(height: 1, color: AppColors.border(context)),
          ],
          const AINarrativeWidget(),
          Divider(height: 1, color: AppColors.border(context)),
          const BasicInfoWidget(),
          Divider(height: 1, color: AppColors.border(context)),
          const CommunityWidget(),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

/// 阻止水平拖动冒泡到 TabBarView，同时让子组件的手势正常工作
class _HorizontalDragBlocker extends StatelessWidget {
  const _HorizontalDragBlocker({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: <Type, GestureRecognizerFactory>{
        // 阻止水平拖动手势冒泡到 TabBarView
        _AlwaysWinPanRecognizer:
            GestureRecognizerFactoryWithHandlers<_AlwaysWinPanRecognizer>(
              _AlwaysWinPanRecognizer.new,
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
