import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../cubits/balance/balance_cubit.dart';
import '../../../../cubits/user/user_cubit.dart';
import '../../../../utils/toast/trade_status_toast.dart';
import '../cubit/swap/swap_cubit.dart';
import '../cubit/swap/swap_event.dart';
import '../cubit/swap/swap_state.dart';
import '../widgets/swap.dart';

/// Swap 页面
///
/// 使用新的 SwapCubit 协调器架构
class SwapScreen extends StatefulWidget {
  const SwapScreen({super.key});

  @override
  State<SwapScreen> createState() => _SwapScreenState();
}

class _SwapScreenState extends State<SwapScreen> {
  // 缓存 cubit 引用，用于 dispose 时访问
  SwapCubit? _swapCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _swapCubit ??= context.read<SwapCubit>();
  }

  @override
  void dispose() {
    // 在页面销毁时关闭 toast
    TradeStatusToastUtils.dismissToast();
    // 使用缓存的引用暂停定时器
    _swapCubit?.pauseTimers();
    super.dispose();
  }

  /// 处理可见性变化
  void _handleVisibilityChanged(bool isVisible) {
    if (!mounted) return;

    final swapCubit = context.read<SwapCubit>();
    final balanceCubit = context.read<BalanceCubit>();

    if (isVisible) {
      // 页面可见时恢复定时器和轮询
      swapCubit.resumeTimers();
      balanceCubit.startPollingBalance();
    } else {
      // 页面不可见时清理资源
      TradeStatusToastUtils.dismissToast();
      swapCubit
        ..resetAll()
        ..pauseTimers();
      balanceCubit.stopPollingBalance();
    }
  }

  /// 处理 SwapEvent 事件
  void _handleSwapEvent(BuildContext context, SwapState state) {
    final event = state.event;
    if (event == null) return;

    // 立即清除事件，防止重复触发
    context.read<SwapCubit>().clearEvent();

    // 使用 switch 模式匹配处理事件
    switch (event) {
      case SwapEventShowLoading():
        // 显示加载中（可选：可以显示 loading indicator）
        break;
      case SwapEventDismissLoading():
        TradeStatusToastUtils.dismissToast();
        break;
      case SwapEventShowParamsInvalid():
        TradeStatusToastUtils.showParamsInvalidToast();
        break;
      case SwapEventShowError(:final message):
        TradeStatusToastUtils.showFailedToast(message: message);
        break;
      case SwapEventShowSuccess(:final symbol, :final amount, :final txUrl):
        TradeStatusToastUtils.showSuccessToast(
          symbol: symbol,
          amount: amount,
          txUrl: txUrl,
        );
        break;
      case SwapEventNavigateToReceive():
        // 导航到接收地址页面（由 SwapCubit 内部处理）
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // 非调试模式下检查登录状态
    if (!kDebugMode) {
      final isLoggedIn = context.select(
        (UserCubit cubit) => cubit.state.isLoggedIn,
      );

      if (!isLoggedIn) {
        return const Center(child: Text('Please login first'));
      }
    }

    return Scaffold(
      body: BlocListener<SwapCubit, SwapState>(
        listenWhen: (previous, current) =>
            previous.event != current.event && current.event != null,
        listener: _handleSwapEvent,
        child: VisibilityDetector(
          key: const Key('swap'),
          onVisibilityChanged: (visibilityInfo) {
            _handleVisibilityChanged(visibilityInfo.visibleFraction > 0);
          },
          child: const SwapWidget(),
        ),
      ),
    );
  }
}
