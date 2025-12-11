import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'timeframe_selector.dart';

class AIGunCandlestick extends StatefulWidget {
  const AIGunCandlestick({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  State<AIGunCandlestick> createState() => _AIGunCandlestickState();
}

class _AIGunCandlestickState extends State<AIGunCandlestick> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: TimeframeSelector(
              onSettingsPressed: () {
                // TODO: Implement settings functionality
              },
            ),
          ),
          const Expanded(
            child: Center(
              child: Text('Candlestick Chart'),
            ),
          ),
        ],
      ),
    );
  }
}
