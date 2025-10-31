import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/utils/toast/trade_status_toast.dart';
import 'package:flutter_aigun/widgets/swap/widgets/swap.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visibility_detector/visibility_detector.dart';

class TradeScreen extends StatefulWidget {
  const TradeScreen({super.key});

  @override
  State<TradeScreen> createState() => _TradeScreenState();
}

class _TradeScreenState extends State<TradeScreen> {
  @override
  void dispose() {
    // 在页面销毁时关闭 toast
    TradeStatusToastUtils.dismissToast();
    // 在页面销毁时取消所有定时器，防止内存泄漏和崩溃
    context.read<TradeCubit>().pauseTimers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) {
      final isLoggedIn =
          context.select((UserCubit cubit) => cubit.state.isLoggedIn);

      if (!isLoggedIn) {
        return const Center(child: Text("Please login first"));
      }
    }

    return Scaffold(
      body: VisibilityDetector(
        key: const Key("trade"),
        child: const TradeSwap(),
        onVisibilityChanged: (visibilityInfo) {
          if (visibilityInfo.visibleFraction > 0) {
            context.read<TradeCubit>().resumeTimers();
            context.read<BalanceCubit>().startPollingBalance();
          } else {
            TradeStatusToastUtils.dismissToast();
            context.read<TradeCubit>().resetAll();
            context.read<TradeCubit>().pauseTimers();
            context.read<BalanceCubit>().stopPollingBalance();
          }
        },
      ),
    );
  }
}
