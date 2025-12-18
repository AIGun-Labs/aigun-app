import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../shared/trade/trade_button_state.dart';
import '../../../button/primary.dart';
import '../../../lotties/index.dart';

class QuickSwapButton extends StatelessWidget {
  const QuickSwapButton({
    super.key,
    required this.buttonState,
    required this.defaultLabel,
    required this.onPressed,
  });

  final TradeButtonState buttonState;
  final String defaultLabel;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final Widget? icon = buttonState.maybeWhen(
      quoteLoading: () => null, // No icon during loading≈
      trading: () => null, // No icon during trading
      orElse: () => SvgPicture.asset(
        width: 13.w,
        height: 13.w,
        Assets.images.icons.aimOutline,
        colorFilter: ColorFilter.mode(
          buttonState.getIconColor(context),
          BlendMode.srcIn,
        ),
      ),
    );

    // Determine content based on state
    final Widget content = buttonState.when(
      disabled: (reason) => Text(
        reason.getLabel(context),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      quoteLoading: () => LottieAsset(
        Assets.lottie.aim,
        config: LottieConfig(
          width: 24.w,
          height: 24.w,
          repeat: true,
          animate: true,
        ),
      ),
      trading: () => Text(
        defaultLabel,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      ready: () => Text(
        defaultLabel,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );

    return PrimaryButton(
      onPressed: buttonState.isLoading ? null : onPressed,
      height: 50.w,
      width: double.infinity,
      backgroundColor: buttonState.getBackgroundColor(context),
      disabledBackgroundColor: buttonState.getBackgroundColor(context),
      textColor: buttonState.getLabelColor(context),
      fontSize: 16,
      isLoading: buttonState is TradeButtonTrading,
      icon: icon,
      label: content,
    );
  }
}
