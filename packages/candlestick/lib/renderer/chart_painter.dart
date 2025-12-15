import 'dart:async' show StreamSink;
import 'dart:math' as math;

import 'package:candlestick/utils/number_util.dart';
import 'package:flutter/material.dart';

import '../candlestick_widget.dart'
    show PriceFormatter, NowPriceAlignment, CrossPriceAlignment;
import '../entity/info_window_entity.dart';
import '../entity/k_line_entity.dart';
import '../utils/date_format_util.dart';
import 'base_chart_painter.dart';
import 'base_chart_renderer.dart';
import 'base_dimension.dart';
import 'main_renderer.dart';
import 'secondary_renderer.dart';
import 'vol_renderer.dart';

class TrendLine {
  final Offset p1;
  final Offset p2;
  final double maxHeight;
  final double scale;

  TrendLine(this.p1, this.p2, this.maxHeight, this.scale);
}

double? trendLineX;

double getTrendLineX() {
  return trendLineX ?? 0;
}

class ChartPainter extends BaseChartPainter {
  final List<TrendLine> lines;
  final bool isTrendLine;
  bool isrecordingCord = false;
  final double selectY;
  static get maxScrollX => BaseChartPainter.maxScrollX;
  final bool isCrossLocked;
  late BaseChartRenderer mMainRenderer;
  BaseChartRenderer? mVolRenderer;
  Set<BaseChartRenderer> mSecondaryRendererList = {};
  StreamSink<InfoWindowEntity?> sink;
  Color? upColor, dnColor;
  Color? ma5Color, ma10Color, ma30Color;
  Color? volColor;
  Color? macdColor, difColor, deaColor, jColor;
  int fixedLength;
  List<int> maDayList;
  final ChartColors chartColors;
  late Paint selectPointPaint, selectorBorderPaint, nowPricePaint;
  final ChartStyle chartStyle;
  final bool hideGrid;
  final bool showNowPrice;
  final VerticalTextAlignment verticalTextAlignment;
  final BaseDimension baseDimension;
  final PriceFormatter? priceFormatter;
  final NowPriceAlignment? nowPriceAlignment;
  final CrossPriceAlignment crossPriceAlignment;

  ChartPainter(
    this.chartStyle,
    this.chartColors, {
    required this.lines,
    required this.isTrendLine,
    required this.selectY,
    required this.sink,
    required datas,
    required scaleX,
    required scrollX,
    required isLongPass,
    required selectX,
    required xFrontPadding,
    required xBackPadding,
    required this.baseDimension,
    isOnTap,
    isTapShowInfoDialog,
    required this.verticalTextAlignment,
    mainStateLi,
    volHidden,
    secondaryStateLi,
    bool isLine = false,
    this.hideGrid = false,
    this.showNowPrice = true,
    this.fixedLength = 2,
    this.maDayList = const [5, 10, 20],
    this.priceFormatter,
    this.nowPriceAlignment,
    this.crossPriceAlignment = CrossPriceAlignment.auto,
    this.isCrossLocked = false,
  }) : super(chartStyle,
            datas: datas,
            scaleX: scaleX,
            scrollX: scrollX,
            isLongPress: isLongPass,
            baseDimension: baseDimension,
            isOnTap: isOnTap,
            isTapShowInfoDialog: isTapShowInfoDialog,
            selectX: selectX,
            mainStateLi: mainStateLi,
            volHidden: volHidden,
            secondaryStateLi: secondaryStateLi,
            xFrontPadding: xFrontPadding,
            xBackPadding: xBackPadding,
            isLine: isLine) {
    selectPointPaint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 0.5
      ..color = this.chartColors.selectFillColor;
    selectorBorderPaint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke
      ..color = this.chartColors.selectBorderColor;
    nowPricePaint = Paint()
      ..strokeWidth = this.chartStyle.nowPriceLineWidth
      ..isAntiAlias = true;
  }

  String formatPrice(double price) {
    if (priceFormatter != null) {
      return priceFormatter!(price);
    }
    return price.toStringAsFixed(fixedLength);
  }

  @override
  void initChartRenderer() {
    if (datas != null && datas!.isNotEmpty) {
      var t = datas![0];
      fixedLength =
          NumberUtil.getMaxDecimalLength(t.open, t.close, t.high, t.low);
    }
    mMainRenderer = MainRenderer(
      mMainRect,
      mMainMaxValue,
      mMainMinValue,
      mTopPadding,
      mainStateLi.toList(),
      isLine,
      fixedLength,
      this.chartStyle,
      this.chartColors,
      this.scaleX,
      verticalTextAlignment,
      maDayList,
      priceFormatter,
    );
    if (mVolRect != null) {
      mVolRenderer = VolRenderer(
          mVolRect!,
          mVolMaxValue,
          mVolMinValue,
          mChildPadding,
          fixedLength,
          this.chartStyle,
          this.chartColors,
          priceFormatter);
    }
    mSecondaryRendererList.clear();
    for (int i = 0; i < mSecondaryRectList.length; ++i) {
      mSecondaryRendererList.add(SecondaryRenderer(
        mSecondaryRectList[i].mRect,
        mSecondaryRectList[i].mMaxValue,
        mSecondaryRectList[i].mMinValue,
        mChildPadding,
        secondaryStateLi.elementAt(i),
        fixedLength,
        chartStyle,
        chartColors,
        scaleX,
        priceFormatter,
      ));
    }
  }

  @override
  void drawBg(Canvas canvas, Size size) {
    Paint mBgPaint = Paint()..color = chartColors.bgColor;
    Rect mainRect =
        Rect.fromLTRB(0, 0, mMainRect.width, mMainRect.height + mTopPadding);
    canvas.drawRect(mainRect, mBgPaint);


    Rect dateRect = Rect.fromLTRB(
        0, mMainRect.bottom, size.width, mMainRect.bottom + mDateRowHeight);
    canvas.drawRect(dateRect, mBgPaint);

    if (mVolRect != null) {
      Rect volRect = Rect.fromLTRB(
          0, mVolRect!.top - mChildPadding, mVolRect!.width, mVolRect!.bottom);
      canvas.drawRect(volRect, mBgPaint);
    }

    for (int i = 0; i < mSecondaryRectList.length; ++i) {
      Rect? mSecondaryRect = mSecondaryRectList[i].mRect;
      Rect secondaryRect = Rect.fromLTRB(0, mSecondaryRect.top - mChildPadding,
          mSecondaryRect.width, mSecondaryRect.bottom);
      canvas.drawRect(secondaryRect, mBgPaint);
    }
  }

  @override
  void drawGrid(canvas) {
    if (!hideGrid) {
      mMainRenderer.drawGrid(canvas, mGridRows, mGridColumns);
      mVolRenderer?.drawGrid(canvas, mGridRows, mGridColumns);
      mSecondaryRendererList.forEach((element) {
        element.drawGrid(canvas, mGridRows, mGridColumns);
      });
    }
  }

  @override
  void drawChart(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(mTranslateX * scaleX, 0.0);
    canvas.scale(scaleX, 1.0);
    for (int i = mStartIndex; datas != null && i <= mStopIndex; i++) {
      KLineEntity? curPoint = datas?[i];
      if (curPoint == null) continue;
      KLineEntity lastPoint = i == 0 ? curPoint : datas![i - 1];
      double curX = getX(i);
      double lastX = i == 0 ? curX : getX(i - 1);

      mMainRenderer.drawChart(lastPoint, curPoint, lastX, curX, size, canvas);
      mVolRenderer?.drawChart(lastPoint, curPoint, lastX, curX, size, canvas);
      mSecondaryRendererList.forEach((element) {
        element.drawChart(lastPoint, curPoint, lastX, curX, size, canvas);
      });
    }

    if ((isLongPress == true || isCrossLocked || (isTapShowInfoDialog && isOnTap)) &&
        isTrendLine == false) {
      drawCrossLine(canvas, size);
    }
    if (isTrendLine == true) drawTrendLines(canvas, size);
    canvas.restore();
  }

  @override
  void drawVerticalText(canvas) {
    var textStyle = getTextStyle(this.chartColors.defaultTextColor);
    if (!hideGrid) {
      mMainRenderer.drawVerticalText(canvas, textStyle, mGridRows);
    }
    mVolRenderer?.drawVerticalText(canvas, textStyle, mGridRows);
    mSecondaryRendererList.forEach((element) {
      element.drawVerticalText(canvas, textStyle, mGridRows);
    });
  }

  @override
  void drawDate(Canvas canvas, Size size) {
    if (datas == null) return;

    double columnSpace = size.width / mGridColumns;
    double startX = getX(mStartIndex) - mPointWidth / 2;
    double stopX = getX(mStopIndex) + mPointWidth / 2;
    double x = 0.0;
    double y = 0.0;
    for (var i = 0; i <= mGridColumns; ++i) {
      double translateX = xToTranslateX(columnSpace * i);

      if (translateX >= startX && translateX <= stopX) {
        int index = indexOfTranslateX(translateX);

        if (datas?[index] == null) continue;
        TextPainter tp = getTextPainter(getDate(datas![index].time), null);

        y = mMainRect.bottom + (mDateRowHeight - tp.height) / 2;
        x = columnSpace * i - tp.width / 2;

        if (x < 0) x = 0;
        if (x > size.width - tp.width) x = size.width - tp.width;
        tp.paint(canvas, Offset(x, y));
      }
    }











  }


  @override
  void drawCrossLineText(Canvas canvas, Size size) {
    var index = calculateSelectedX(selectX);
    KLineEntity point = getItem(index);

    TextPainter tp =
        getTextPainter(formatPrice(point.close), chartColors.crossTextColor);
    double textHeight = tp.height;
    double textWidth = tp.width;

    double w1 = 5;
    double w2 = 3;
    double r = textHeight / 2 + w2;
    double y = getMainY(point.close);
    double x;

    bool infoWindowIsLeft = translateXtoX(getX(index)) >= mWidth / 2;

    bool priceTagOnLeft;
    if (crossPriceAlignment == CrossPriceAlignment.left) {
      priceTagOnLeft = true;
    } else if (crossPriceAlignment == CrossPriceAlignment.right) {
      priceTagOnLeft = false;
    } else {
      priceTagOnLeft = infoWindowIsLeft;
    }
    if (priceTagOnLeft) {
      x = 1;
      Path path = new Path();
      path.moveTo(x, y - r);
      path.lineTo(x, y + r);
      path.lineTo(textWidth + 2 * w1, y + r);
      path.lineTo(textWidth + 2 * w1 + w2, y);
      path.lineTo(textWidth + 2 * w1, y - r);
      path.close();
      canvas.drawPath(path, selectPointPaint);
      canvas.drawPath(path, selectorBorderPaint);
      tp.paint(canvas, Offset(x + w1, y - textHeight / 2));
    } else {
      x = mWidth - textWidth - 1 - 2 * w1 - w2;
      Path path = new Path();
      path.moveTo(x, y);
      path.lineTo(x + w2, y + r);
      path.lineTo(mWidth - 2, y + r);
      path.lineTo(mWidth - 2, y - r);
      path.lineTo(x + w2, y - r);
      path.close();
      canvas.drawPath(path, selectPointPaint);
      canvas.drawPath(path, selectorBorderPaint);
      tp.paint(canvas, Offset(x + w1 + w2, y - textHeight / 2));
    }

    TextPainter dateTp =
        getTextPainter(getDate(point.time), chartColors.crossTextColor);
    textWidth = dateTp.width;
    r = textHeight / 2;
    x = translateXtoX(getX(index));

    y = mMainRect.bottom;

    if (x < textWidth + 2 * w1) {
      x = 1 + textWidth / 2 + w1;
    } else if (mWidth - x < textWidth + 2 * w1) {
      x = mWidth - 1 - textWidth / 2 - w1;
    }
    double baseLine = textHeight / 2;
    canvas.drawRect(
        Rect.fromLTRB(x - textWidth / 2 - w1, y, x + textWidth / 2 + w1,
            y + baseLine + r),
        selectPointPaint);
    canvas.drawRect(
        Rect.fromLTRB(x - textWidth / 2 - w1, y, x + textWidth / 2 + w1,
            y + baseLine + r),
        selectorBorderPaint);

    dateTp.paint(canvas, Offset(x - textWidth / 2, y));

    sink.add(InfoWindowEntity(point, isLeft: infoWindowIsLeft));
  }

  @override
  void drawText(Canvas canvas, KLineEntity data, double x) {

    if (isLongPress || isCrossLocked || (isTapShowInfoDialog && isOnTap)) {
      var index = calculateSelectedX(selectX);
      data = getItem(index);
    }

    mMainRenderer.drawText(canvas, data, x);
    mVolRenderer?.drawText(canvas, data, x);
    mSecondaryRendererList.forEach((element) {
      element.drawText(canvas, data, x);
    });
  }

  @override
  void drawMaxAndMin(Canvas canvas) {
    if (isLine == true) return;

    double x = translateXtoX(getX(mMainMinIndex));
    double y = getMainY(mMainLowMinValue);
    if (x < mWidth / 2) {

      TextPainter tp = getTextPainter(
          "── " + formatPrice(mMainLowMinValue), chartColors.minColor);
      tp.paint(canvas, Offset(x, y - tp.height / 2));
    } else {
      TextPainter tp = getTextPainter(
          formatPrice(mMainLowMinValue) + " ──", chartColors.minColor);
      tp.paint(canvas, Offset(x - tp.width, y - tp.height / 2));
    }
    x = translateXtoX(getX(mMainMaxIndex));
    y = getMainY(mMainHighMaxValue);
    if (x < mWidth / 2) {

      TextPainter tp = getTextPainter(
          "── " + formatPrice(mMainHighMaxValue), chartColors.maxColor);
      tp.paint(canvas, Offset(x, y - tp.height / 2));
    } else {
      TextPainter tp = getTextPainter(
          formatPrice(mMainHighMaxValue) + " ──", chartColors.maxColor);
      tp.paint(canvas, Offset(x - tp.width, y - tp.height / 2));
    }
  }

  @override
  void drawNowPrice(Canvas canvas) {
    if (!this.showNowPrice) {
      return;
    }

    if (datas == null) {
      return;
    }

    double value = datas!.last.close;
    double y = getMainY(value);


    if (y > getMainY(mMainLowMinValue)) {
      y = getMainY(mMainLowMinValue);
    }

    if (y < getMainY(mMainHighMaxValue)) {
      y = getMainY(mMainHighMaxValue);
    }

    nowPricePaint
      ..color = value >= datas!.last.open
          ? this.chartColors.nowPriceUpColor
          : this.chartColors.nowPriceDnColor;

    double startX = 0;
    final max = -mTranslateX + mWidth / scaleX;
    final space =
        this.chartStyle.nowPriceLineSpan + this.chartStyle.nowPriceLineLength;
    while (startX < max) {
      canvas.drawLine(
          Offset(startX, y),
          Offset(startX + this.chartStyle.nowPriceLineLength, y),
          nowPricePaint);
      startX += space;
    }

    TextPainter tp = getTextPainter(
      formatPrice(value),
      this.chartColors.nowPriceTextColor,
    );

    double offsetX;

    if (nowPriceAlignment != null) {
      switch (nowPriceAlignment!) {
        case NowPriceAlignment.left:
          offsetX = 0;
          break;
        case NowPriceAlignment.right:
          offsetX = mWidth - tp.width;
          break;
      }
    } else {

      switch (verticalTextAlignment) {
        case VerticalTextAlignment.left:
          offsetX = mWidth - tp.width;
          break;
        case VerticalTextAlignment.right:
          offsetX = 0;
          break;
      }
    }

    double top = y - tp.height / 2;
    canvas.drawRect(
        Rect.fromLTRB(offsetX, top, offsetX + tp.width, top + tp.height),
        nowPricePaint);
    tp.paint(canvas, Offset(offsetX, top));
  }


  void drawTrendLines(Canvas canvas, Size size) {
    var index = calculateSelectedX(selectX);
    Paint paintY = Paint()
      ..color = chartColors.trendLineColor
      ..strokeWidth = 1
      ..isAntiAlias = true;
    double x = getX(index);
    trendLineX = x;

    double y = selectY;



    canvas.drawLine(Offset(x, mTopPadding),
        Offset(x, size.height - mBottomPadding), paintY);
    Paint paintX = Paint()
      ..color = chartColors.trendLineColor
      ..strokeWidth = 1
      ..isAntiAlias = true;
    Paint paint = Paint()
      ..color = chartColors.trendLineColor
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(-mTranslateX, y),
        Offset(-mTranslateX + mWidth / scaleX, y), paintX);
    if (scaleX >= 1) {
      canvas.drawOval(
        Rect.fromCenter(
            center: Offset(x, y), height: 15.0 * scaleX, width: 15.0),
        paint,
      );
    } else {
      canvas.drawOval(
        Rect.fromCenter(
            center: Offset(x, y), height: 10.0, width: 10.0 / scaleX),
        paint,
      );
    }
    if (lines.isNotEmpty) {
      lines.forEach((element) {
        var y1 = -((element.p1.dy - 35) / element.scale) + element.maxHeight;
        var y2 = -((element.p2.dy - 35) / element.scale) + element.maxHeight;
        var a = (trendLineMax! - y1) * trendLineScale! + trendLineContentRec!;
        var b = (trendLineMax! - y2) * trendLineScale! + trendLineContentRec!;
        var p1 = Offset(element.p1.dx, a);
        var p2 = Offset(element.p2.dx, b);
        canvas.drawLine(
            p1,
            element.p2 == Offset(-1, -1) ? Offset(x, y) : p2,
            Paint()
              ..color = Colors.yellow
              ..strokeWidth = 2);
      });
    }
  }


  void drawCrossLine(Canvas canvas, Size size) {
    var index = calculateSelectedX(selectX);
    KLineEntity point = getItem(index);
    double x = getX(index);
    double y = getMainY(point.close);


    Paint paintY = Paint()
      ..color = this.chartColors.vCrossColor
      ..strokeWidth = this.chartStyle.vCrossWidth / scaleX
      ..isAntiAlias = true;


    Paint paintX = Paint()
      ..color = this.chartColors.hCrossColor
      ..strokeWidth = this.chartStyle.hCrossWidth
      ..isAntiAlias = true;

    if (chartStyle.crossLineDash) {

      _drawDashedLineCompensated(
        canvas,
        Offset(x, mTopPadding),
        Offset(x, size.height - mBottomPadding),
        paintY,
        scaleX,
      );

      _drawDashedLineHorizontalCompensated(canvas, Offset(-mTranslateX, y),
          Offset(-mTranslateX + mWidth / scaleX, y), paintX, scaleX);
    } else {

      canvas.drawLine(Offset(x, mTopPadding),
          Offset(x, size.height - mBottomPadding), paintY);
      canvas.drawLine(Offset(-mTranslateX, y),
          Offset(-mTranslateX + mWidth / scaleX, y), paintX);
    }


    Paint paintDot = Paint()
      ..color = this.chartColors.hCrossColor
      ..style = PaintingStyle.fill;
    double radius = 3.0;

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(x, y),
        width: radius * 2 / scaleX,
        height: radius * 2,
      ),
      paintDot,
    );
  }




  void _drawDashedLineCompensated(
      Canvas canvas, Offset start, Offset end, Paint paint, double scaleX) {

    final dashLength = chartStyle.crossLineDashLength;
    final dashSpace = chartStyle.crossLineDashSpace;

    final dx = end.dx - start.dx;
    final dy = end.dy - start.dy;
    final distance = math.sqrt(dx * dx + dy * dy);
    final unitX = dx / distance;
    final unitY = dy / distance;

    double currentDistance = 0;
    while (currentDistance < distance) {
      final segmentEnd = (currentDistance + dashLength).clamp(0.0, distance);
      canvas.drawLine(
        Offset(start.dx + unitX * currentDistance,
            start.dy + unitY * currentDistance),
        Offset(start.dx + unitX * segmentEnd, start.dy + unitY * segmentEnd),
        paint,
      );
      currentDistance += dashLength + dashSpace;
    }
  }




  void _drawDashedLineHorizontalCompensated(
      Canvas canvas, Offset start, Offset end, Paint paint, double scaleX) {

    final dashLength = chartStyle.crossLineDashLength / scaleX;
    final dashSpace = chartStyle.crossLineDashSpace / scaleX;

    final dx = end.dx - start.dx;
    final dy = end.dy - start.dy;
    final distance = math.sqrt(dx * dx + dy * dy);
    final unitX = dx / distance;
    final unitY = dy / distance;

    double currentDistance = 0;
    while (currentDistance < distance) {
      final segmentEnd = (currentDistance + dashLength).clamp(0.0, distance);
      canvas.drawLine(
        Offset(start.dx + unitX * currentDistance,
            start.dy + unitY * currentDistance),
        Offset(start.dx + unitX * segmentEnd, start.dy + unitY * segmentEnd),
        paint,
      );
      currentDistance += dashLength + dashSpace;
    }
  }

  TextPainter getTextPainter(text, color) {
    if (color == null) {
      color = this.chartColors.defaultTextColor;
    }
    TextSpan span = TextSpan(text: "$text", style: getTextStyle(color));
    TextPainter tp = TextPainter(text: span, textDirection: TextDirection.ltr);
    tp.layout();
    return tp;
  }

  String getDate(int? date) => dateFormat(
        DateTime.fromMillisecondsSinceEpoch(
            date ?? DateTime.now().millisecondsSinceEpoch),
        mFormats,
      );

  double getMainY(double y) => mMainRenderer.getY(y);








  bool isInMainRect(Offset point) {
    return mMainRect.contains(point);
  }
}
