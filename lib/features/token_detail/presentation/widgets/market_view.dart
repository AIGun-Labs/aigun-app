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
  bool _blockScroll = false;
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
          AIGunCandlestick(
            onGestureStateChanged: _onCandlestickGestureStateChanged,
          ),

          Divider(height: 1, color: AppColors.border(context)),
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

class _HorizontalDragBlocker extends StatelessWidget {
  const _HorizontalDragBlocker({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: <Type, GestureRecognizerFactory>{
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

class _AlwaysWinPanRecognizer extends PanGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}
