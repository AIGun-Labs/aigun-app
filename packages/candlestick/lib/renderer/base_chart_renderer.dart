import 'package:flutter/material.dart';
import '../candlestick_widget.dart' show PriceFormatter;

export '../chart_style.dart';

abstract class BaseChartRenderer<T> {
  double maxValue, minValue;
  late double scaleY;
  double topPadding;
  Rect chartRect;
  int fixedLength;
  PriceFormatter? priceFormatter;
  Paint chartPaint = Paint()
    ..isAntiAlias = true
    ..filterQuality = FilterQuality.high
    ..strokeWidth = 1.0
    ..color = Colors.red;
  Paint gridPaint = Paint()
    ..isAntiAlias = true
    ..filterQuality = FilterQuality.high
    ..strokeWidth = 0.5
    ..color = Color(0xff4c5c74);

  BaseChartRenderer({
    required this.chartRect,
    required this.maxValue,
    required this.minValue,
    required this.topPadding,
    required this.fixedLength,
    required Color gridColor,
    this.priceFormatter,
  }) {
    if (maxValue == minValue) {
      maxValue *= 1.5;
      minValue /= 2;
    }
    scaleY = chartRect.height / (maxValue - minValue);
    gridPaint.color = gridColor;

  }

  double getY(double y) => (maxValue - y) * scaleY + chartRect.top;

  String format(double? n) {
    if (n == null || n.isNaN) {
      return "0.00";
    }
    if (priceFormatter != null) {
      return priceFormatter!(n);
    }
    return n.toStringAsFixed(fixedLength);
  }

  void drawGrid(Canvas canvas, int gridRows, int gridColumns);

  void drawText(Canvas canvas, T data, double x);

  void drawVerticalText(canvas, textStyle, int gridRows);

  void drawChart(T lastPoint, T curPoint, double lastX, double curX, Size size,
      Canvas canvas);

  void drawLine(double? lastPrice, double? curPrice, Canvas canvas,
      double lastX, double curX, Color color, {double? lineWidth}) {
    if (lastPrice == null || curPrice == null) {
      return;
    }
    double lastY = getY(lastPrice);
    double curY = getY(curPrice);
    canvas.drawLine(
        Offset(lastX, lastY),
        Offset(curX, curY),
        chartPaint
          ..color = color
          ..strokeWidth = lineWidth ?? 1.0);
  }

  void drawCircle(Canvas canvas, double curX, double curY, Color color,
      {double? radius, double? strokeWidth}) {
    canvas.drawCircle(
      Offset(curX, getY(curY)),
      radius ?? 2.0,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth ?? 0.8
        ..color = color,
    );
  }

  TextStyle getTextStyle(Color color) {
    return TextStyle(fontSize: 10.0, color: color);
  }
}
