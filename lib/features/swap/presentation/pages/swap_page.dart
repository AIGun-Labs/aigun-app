import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../cubits/balance/balance_cubit.dart';
import '../../../../shared/presentation/cubits/new_user/new_user_cubit.dart';
import '../../../../utils/error_handler_utils.dart';
import '../../../../utils/logger.dart';
import '../../../../utils/toast/trade_status_toast.dart';
import '../cubit/swap/swap_cubit.dart';
import '../cubit/swap/swap_event.dart';
import '../cubit/swap/swap_state.dart';
import '../widgets/sol_insufficient_dialog.dart';
import '../widgets/swap.dart';

///
class SwapScreen extends StatefulWidget {
  const SwapScreen({super.key});

  @override
  State<SwapScreen> createState() => _SwapScreenState();
}

class _SwapScreenState extends State<SwapScreen> {
  SwapCubit? _swapCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _swapCubit ??= context.read<SwapCubit>();
  }

  @override
  void dispose() {
    TradeStatusToastUtils.dismissToast();
    _swapCubit?.pauseTimers();
    super.dispose();
  }

  void _handleVisibilityChanged(bool isVisible) {
    if (!mounted) return;

    final swapCubit = context.read<SwapCubit>();
    final balanceCubit = context.read<BalanceCubit>();

    if (isVisible) {
      swapCubit.resumeTimers();
      balanceCubit.startPollingBalance();
      swapCubit.getBalanceSelectedToken();
    } else {
      TradeStatusToastUtils.dismissToast();
      swapCubit
        ..resetAll()
        ..pauseTimers();
      balanceCubit.stopPollingBalance();
    }
  }

  void _handleSwapEvent(BuildContext context, SwapState state) {
    final event = state.event;
    if (event == null) return;
    context.read<SwapCubit>().clearEvent();
    switch (event) {
      case SwapEventShowLoading():
        TradeStatusToastUtils.showTrainingToast();
        break;
      case SwapEventDismissLoading():
        TradeStatusToastUtils.dismissToast();
        break;
      case SwapEventShowParamsInvalid():
        TradeStatusToastUtils.showParamsInvalidToast();
        break;
      case SwapEventShowError(:final message, :final code):
        final errorText = ErrorHandlerUtils.getErrorMessageFromCode(
          code,
          context,
        );
        Logger.error('SwapEventShowError: $errorText');
        TradeStatusToastUtils.showFailedToast(message: errorText);
        break;
      case SwapEventShowSuccess(:final symbol, :final amount, :final txUrl):
        TradeStatusToastUtils.showSuccessToast(
          symbol: symbol,
          amount: amount,
          txUrl: txUrl,
        );
        break;
      case SwapEventNavigateToReceive():
        break;
      case SwapEventShowSolMinimumWarning():
        SOLInsufficientDialog.show(
          context,
          onDismiss: () {}, // ， DialogAction
          // onCheckboxChanged: (checked) async {
          //   if (checked) {
          //     await getIt<SettingsStorage>().setHideSolMinimumWarning(true);
          //   }
          // },
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) {
      final isLoggedIn = context.select(
        (NewUserCubit cubit) =>
            cubit.state.authStatus == AuthStatus.authenticated,
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
