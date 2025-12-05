import 'package:flutter/material.dart';

import 'pulse.dart';
import 'rotating_square.dart';
import 'wave.dart';

enum LoadingIndicatorType { circular, pulse, wave, rotatingSquare }

class LoadingIndicator extends StatelessWidget {
  final LoadingIndicatorType type;

  final Color? color;

  final double size;

  final String? text;

  final TextStyle? textStyle;

  final double spacing;

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
        indicator = PulseLoadingIndicator(size: size, color: indicatorColor);
        break;
      case LoadingIndicatorType.wave:
        indicator = WaveLoadingIndicator(size: size, color: indicatorColor);
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
