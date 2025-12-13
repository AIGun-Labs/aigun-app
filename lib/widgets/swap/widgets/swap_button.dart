import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../cubits/sound_effect/sound_effect_cubit.dart';
import '../../../cubits/trade/trade_cubit.dart';
import '../../../cubits/trade/trade_state.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../shared/trade/trade_button_state.dart';
import '../../button/primary.dart';
import '../../lotties/index.dart';

class SwapButton extends StatelessWidget {
  const SwapButton({
    super.key,
    required this.isBuyToken,
    this.padding = EdgeInsets.zero,
  });

  final bool isBuyToken;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TradeCubit, TradeState>(
      builder: (context, state) {
        final tradeCubit = context.read<TradeCubit>();
        final buttonState = tradeCubit.buttonState;

        final defaultLabel = isBuyToken
            ? S.of(context).buyNow
            : S.of(context).tradeNow;

        final Widget content = buttonState.when(
          disabled: (reason) => Text(
            reason.getLabel(context),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: buttonState.getLabelColor(context),
            ),
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
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          ready: () => Text(
            defaultLabel,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        );

        final Widget? icon = buttonState.maybeWhen(
          disabled: (_) => SvgPicture.asset(
            width: 20.w,
            height: 20.w,
            Assets.images.icons.aimOutline,
            colorFilter: ColorFilter.mode(
              buttonState.getIconColor(context),
              BlendMode.srcIn,
            ),
          ),
          ready: () => SvgPicture.asset(
            Assets.images.icons.aimOutline,
            width: 20.w,
            height: 20.w,
            colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
          orElse: () => null,
        );

        return Padding(
          padding: padding,
          child: PrimaryButton(
            disabledBackgroundColor: buttonState.getBackgroundColor(context),
            backgroundColor: buttonState.getBackgroundColor(context),
            onPressed: buttonState.isEnabled
                ? () async {
                    context.read<SoundEffectCubit>().playGunLoad();
                    await tradeCubit.swap(context);
                  }
                : null,
            borderRadius: isBuyToken
                ? BorderRadius.circular(50.r)
                : BorderRadius.zero,
            width: double.infinity,
            height: 50.w,
            cutSize: isBuyToken ? 0 : 20.0,
            textColor: Colors.black,
            fontSize: 16,
            icon: icon,
            label: content,
          ),
        );
      },
    );
  }
}
