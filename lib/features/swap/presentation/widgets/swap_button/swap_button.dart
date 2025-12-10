import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../themes/themes.dart';
import '../../../../../widgets/button/primary.dart';
import '../../../../../widgets/lotties/index.dart';
import 'swap_button_config.dart';

/// 通用交易按钮组件
///
/// 纯 UI 组件，不依赖任何特定的 Cubit
/// 通过 [TradeButtonConfig] 配置所有状态和行为
///
/// 使用示例：
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

  /// 按钮配置
  final TradeButtonConfig config;

  @override
  Widget build(BuildContext context) {
    final isDisabled = config.shouldShowDisabled;

    // 计算颜色
    final backgroundColor = isDisabled
        ? (config.disabledBackgroundColor ?? AppColors.quinary)
        : (config.backgroundColor ?? AppColors.buttonPrimary(context));

    final textColor = isDisabled
        ? (config.textColor ?? AppColors.textTertiary(context))
        : (config.textColor ?? Colors.black);

    final iconColor = isDisabled
        ? (config.iconColor ?? AppColors.textTertiary(context))
        : (config.iconColor ?? Colors.black);

    // 构建内容
    final content = _buildContent(context, textColor);
    final icon = _buildIcon(iconColor);

    // 计算按钮样式
    final borderRadius =
        config.borderRadius ??
        (config.isBuyMode ? BorderRadius.circular(50) : BorderRadius.zero);
    final cutSize = config.isBuyMode ? 0.0 : config.cutSize;

    return PrimaryButton(
      disabledBackgroundColor:
          config.disabledBackgroundColor ?? AppColors.quinary,
      onPressed: config.isEnabled && !config.isLoading && !config.isQuoteLoading
          ? config.onPressed
          : null,
      borderRadius: borderRadius,
      width: config.width ?? double.infinity,
      height: config.height ?? 50.w,
      cutSize: cutSize,
      backgroundColor: backgroundColor,
      textColor: Colors.black,
      fontSize: 16,
      icon: icon,
      label: content,
    );
  }

  /// 构建按钮内容
  Widget _buildContent(BuildContext context, Color textColor) {
    // 自定义内容优先
    if (config.customContent != null) {
      return config.customContent!;
    }

    // 询价加载中显示动画
    if (config.isQuoteLoading) {
      return config.loadingContent ??
          LottieAsset(
            const $AssetsLottieGen().aim,
            config: LottieConfig(
              width: 24.w,
              height: 24.h,
              repeat: true,
              animate: true,
            ),
          );
    }

    // 默认文本
    return Text(
      config.text,
      style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
    );
  }

  /// 构建图标
  Widget? _buildIcon(Color iconColor) {
    // 自定义图标优先
    if (config.icon != null) {
      return config.icon;
    }

    // 询价加载中不显示图标
    if (config.isQuoteLoading) {
      return null;
    }

    // 默认图标
    return SvgPicture.asset(
      width: 13.w,
      height: 13.w,
      const $AssetsImagesIconsGen().aimOutline,
      colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
    );
  }
}

/// 便捷构造器扩展
extension TradeButtonConfigExtension on TradeButtonConfig {
  /// 从状态构建器创建配置
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
