import 'package:flutter/material.dart';

import 'pulse.dart';
import 'rotating_square.dart';
import 'wave.dart';

/// 加载指示器类型
enum LoadingIndicatorType {
  /// 基本圆形加载指示器
  circular,

  /// 脉冲效果加载指示器
  pulse,

  /// 波浪效果加载指示器
  wave,

  /// 旋转方块加载指示器
  rotatingSquare,
}

/// 加载指示器组件
class LoadingIndicator extends StatelessWidget {
  /// 加载指示器的类型
  final LoadingIndicatorType type;

  /// 加载指示器的颜色
  final Color? color;

  /// 加载指示器的大小
  final double size;

  /// 加载指示器下方显示的文本
  final String? text;

  /// 文本的样式
  final TextStyle? textStyle;

  /// 加载指示器与文本之间的间距
  final double spacing;

  /// 创建一个加载指示器组件
  const LoadingIndicator({
    super.key,
    this.type = LoadingIndicatorType.circular,
    this.color,
    this.size = 40.0,
    this.text,
    this.textStyle,
    this.spacing = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final indicatorColor = color ?? theme.colorScheme.primary;
    final defaultTextStyle = TextStyle(
      color: theme.textTheme.bodyMedium?.color,
      fontSize: 14.0,
    );

    Widget indicator;

    switch (type) {
      case LoadingIndicatorType.circular:
        indicator = SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            strokeWidth: size / 10,
            valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
          ),
        );
        break;
      case LoadingIndicatorType.pulse:
        indicator = PulseLoadingIndicator(
          size: size,
          color: indicatorColor,
        );
        break;
      case LoadingIndicatorType.wave:
        indicator = WaveLoadingIndicator(
          size: size,
          color: indicatorColor,
        );
        break;
      case LoadingIndicatorType.rotatingSquare:
        indicator = RotatingSquareLoadingIndicator(
          size: size,
          color: indicatorColor,
        );
        break;
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          indicator,
          if (text != null) ...[
            SizedBox(height: spacing),
            Text(
              text!,
              style: textStyle ?? defaultTextStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
