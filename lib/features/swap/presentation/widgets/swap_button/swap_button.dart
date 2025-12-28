import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../themes/themes.dart';
import '../../../../../widgets/button/primary.dart';
import '../../../../../widgets/lotties/index.dart';
import 'swap_button_config.dart';

///
///
/// ```dart
/// TradeButton(
///   config: TradeButtonConfig(
///     text: S.of(context).tradeNow,
///     isEnabled: state.isValid,
///     isQuoteLoading: state.isQuoteLoading,
///     onPressed: () => cubit.trade(),
///   ),
/// )
/// ```
class TradeButton extends StatelessWidget {
  const TradeButton({super.key, required this.config});

  final TradeButtonConfig config;

  @override
  Widget build(BuildContext context) {
    final style = _TradeButtonStyle.fromConfig(config, context);

    return PrimaryButton(
      disabledBackgroundColor: style.disabledBackgroundColor,
      onPressed: _canTap ? config.onPressed : null,
      borderRadius: style.borderRadius,
      width: config.width ?? double.infinity,
      height: config.height ?? 50.w,
      cutSize: style.cutSize,
      backgroundColor: style.backgroundColor,
      textColor: Colors.black,
      fontSize: 16,
      icon: _buildIcon(style.iconColor),
      label: _buildContent(context, style.textColor),
    );
  }

  bool get _canTap =>
      config.isEnabled && !config.isLoading && !config.isQuoteLoading;

  Widget _buildContent(BuildContext context, Color textColor) {
    if (config.customContent != null) {
      return config.customContent!;
    }

    if (config.isQuoteLoading) {
      return config.loadingContent ?? const _LoadingAnimation();
    }

    return Text(
      config.text,
      style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
    );
  }

  Widget? _buildIcon(Color iconColor) {
    if (config.icon != null) return config.icon;
    if (config.isQuoteLoading) return null;

    return SvgPicture.asset(
      Assets.images.icons.aimOutline,
      width: 20.w,
      height: 20.w,
      colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
    );
  }
}

///
class _TradeButtonStyle {
  const _TradeButtonStyle({
    required this.backgroundColor,
    required this.disabledBackgroundColor,
    required this.textColor,
    required this.iconColor,
    required this.borderRadius,
    required this.cutSize,
  });

  factory _TradeButtonStyle.fromConfig(
    TradeButtonConfig config,
    BuildContext context,
  ) {
    final isDisabled = config.shouldShowDisabled;
    final defaultDisabledBg =
        config.disabledBackgroundColor ?? AppColors.quinary;

    return _TradeButtonStyle(
      backgroundColor: isDisabled
          ? defaultDisabledBg
          : (config.backgroundColor ?? AppColors.buttonPrimary(context)),
      disabledBackgroundColor: defaultDisabledBg,
      textColor: isDisabled
          ? (config.textColor ?? AppColors.textTertiary(context))
          : (config.textColor ?? Colors.black),
      iconColor: isDisabled
          ? (config.iconColor ?? AppColors.textTertiary(context))
          : (config.iconColor ?? Colors.black),
      borderRadius:
          config.borderRadius ??
          (config.isBuyMode ? BorderRadius.circular(50) : BorderRadius.zero),
      cutSize: config.isBuyMode ? 0.0 : config.cutSize,
    );
  }

  final Color backgroundColor;
  final Color disabledBackgroundColor;
  final Color textColor;
  final Color iconColor;
  final BorderRadius borderRadius;
  final double cutSize;
}

class _LoadingAnimation extends StatelessWidget {
  const _LoadingAnimation();

  @override
  Widget build(BuildContext context) {
    return LottieAsset(
      const $AssetsLottieGen().aim,
      config: LottieConfig(
        width: 24.w,
        height: 24.h,
        repeat: true,
        animate: true,
      ),
    );
  }
}

extension TradeButtonConfigExtension on TradeButtonConfig {
  static TradeButtonConfig fromStateBuilder({
    required TradeButtonStateBuilder stateBuilder,
    required String defaultText,
    required String balanceNotEnoughText,
    required String feeNotEnoughText,
    VoidCallback? onPressed,
    bool isBuyMode = false,
    Color? backgroundColor,
    Color? disabledBackgroundColor,
  }) {
    final errorText = stateBuilder.getErrorText(
      balanceNotEnoughText: balanceNotEnoughText,
      feeNotEnoughText: feeNotEnoughText,
    );

    return TradeButtonConfig(
      text: errorText ?? defaultText,
      isEnabled: stateBuilder.isEnabled,
      isLoading: stateBuilder.isTrading,
      isQuoteLoading: stateBuilder.isQuoteLoading,
      onPressed: onPressed,
      isBuyMode: isBuyMode,
      backgroundColor: backgroundColor,
      disabledBackgroundColor: disabledBackgroundColor,
    );
  }
}
