import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../cubits/index.dart';
import '../../shared/presentation/cubits/new_user/new_user_cubit.dart';
import '../../utils/toast/trade_status_toast.dart';
import '../../widgets/swap/widgets/swap.dart';

class TradeScreen extends StatefulWidget {
  const TradeScreen({super.key});

  @override
  State<TradeScreen> createState() => _TradeScreenState();
}

class _TradeScreenState extends State<TradeScreen> {
  @override
  void dispose() {
    TradeStatusToastUtils.dismissToast();
    context.read<TradeCubit>().pauseTimers();
    super.dispose();
  }

  void _handleVisibilityChanged(bool isVisible) {
    if (!mounted) return;
    final tradeCubit = context.read<TradeCubit>();
    final balanceCubit = context.read<BalanceCubit>();
    final tradeSettingCubit = context.read<TradeSettingCubit>();

    if (isVisible) {
      tradeCubit.resumeTimers();
      balanceCubit.startPollingBalance();
      final network = tradeCubit.state.fromToken?.network;
      if (network != null && network.isNotEmpty) {
        tradeSettingCubit.updateNetwork(network);
      }
    } else {
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
      final isLoggedIn = context.select(
        (NewUserCubit cubit) => cubit.state.isAuthenticated,
      );

      if (!isLoggedIn) {
        return const Center(child: Text('Please login first'));
      }
    }

    return Scaffold(
      body: VisibilityDetector(
        key: const Key('trade'),
        child: const TradeSwap(),
        onVisibilityChanged: (visibilityInfo) {
          _handleVisibilityChanged(visibilityInfo.visibleFraction > 0);
        },
      ),
    );
  }
}
