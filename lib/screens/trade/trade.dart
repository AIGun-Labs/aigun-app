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

  /// 处理可见性变化
  void _handleVisibilityChanged(bool isVisible) {
    if (!mounted) return;

    // 缓存 cubit 实例，避免多次读取
    final tradeCubit = context.read<TradeCubit>();
    final balanceCubit = context.read<BalanceCubit>();
    final tradeSettingCubit = context.read<TradeSettingCubit>();

    if (isVisible) {
      // 页面可见时恢复定时器和轮询
      tradeCubit.resumeTimers();
      balanceCubit.startPollingBalance();

      // 更新网络设置（只在有 fromToken 时更新）
      final network = tradeCubit.state.fromToken?.network;
      if (network != null && network.isNotEmpty) {
        tradeSettingCubit.updateNetwork(network);
      }
    } else {
      // 页面不可见时清理资源
      TradeStatusToastUtils.dismissToast();
      tradeCubit
        ..resetAll()
        ..pauseTimers();
      balanceCubit.stopPollingBalance();
    }
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
          _handleVisibilityChanged(visibilityInfo.visibleFraction > 0);
        },
      ),
    );
  }
}
