
>  Flutter K、， Flutter 。

1. [](#1-)
2. [](#2-)
3. [](#3-)
4. [](#4-)
5. [](#5-)
6. [](#6-)
7. [](#7-)
8. [](#8-)

---

```
┌─────────────────────────────────────────────────────────────────┐
│                     CandlestickWidget                          │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │                  (Gestures)                     │   │
│  │  ┌─────────────┐ ┌─────────────┐ ┌─────────────────┐    │   │
│  │  │ ScaleGesture│ │ TapGesture  │ │LongPressGesture │    │   │
│  │  └─────────────┘ └─────────────┘ └─────────────────┘    │   │
│  └─────────────────────────────────────────────────────────┘   │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │                  (CustomPaint)                      │   │
│  │  ┌─────────────────────────────────────────────────────┐│   │
│  │  │                  ChartPainter                       ││   │
│  │  │  ┌────────────┐ ┌────────────┐ ┌────────────────┐  ││   │
│  │  │  │MainRenderer│ │VolRenderer │ │SecondaryRenderer│  ││   │
│  │  │  │ (K/MA) │ │  ()  │ │ (MACD/KDJ)    │  ││   │
│  │  │  └────────────┘ └────────────┘ └────────────────┘  ││   │
│  │  └─────────────────────────────────────────────────────┘│   │
│  └─────────────────────────────────────────────────────────┘   │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │                  (Entity + DataUtil)               │   │
│  │  ┌────────────┐ ┌────────────┐ ┌──────────────────────┐ │   │
│  │  │KLineEntity │ │ Indicators │ │   DataUtil           │ │   │
│  │  │(OHLCV) │ │  (Mixins)  │ │ ()        │ │   │
│  │  └────────────┘ └────────────┘ └──────────────────────┘ │   │
│  └─────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────┘
```

|            |     |                            |
| ---------- | --- | -------------------------- |
| **Mixin ** |     | `KEntity`  Mixin           |
| ****       |     | `SecondaryRenderer`        |
| ****       |     | `StreamController`         |
| ****       |     | `BaseChartPainter.paint()` |
| ****       |     | `GestureRecognizerFactory` |

```
candlestick/lib/
├── candlestick_widget.dart      # Widget (858) - +
├── chart_style.dart             #  (276)
├── entity/                      # 
│   ├── k_line_entity.dart      # K ()
│   ├── k_entity.dart           # Mixin
│   ├── candle_entity.dart      #  (OHLC + MA + BOLL)
│   ├── volume_entity.dart      # 
│   ├── macd_entity.dart        # MACD 
│   ├── kdj_entity.dart         # KDJ 
│   ├── rsi_entity.dart         # RSI 
│   └── ...
├── renderer/                    # 
│   ├── base_chart_painter.dart #  (~530)
│   ├── chart_painter.dart      #  (~690)
│   ├── main_renderer.dart      #  (/MA/BOLL/SAR)
│   ├── vol_renderer.dart       # 
│   └── secondary_renderer.dart #  (MACD/KDJ/RSI/WR/CCI)
└── utils/
    └── data_util.dart          #  (327)
```

---

```dart
mixin CandleEntity {
  late double open, high, low, close;  // OHLC 
  List<double>? maValueList;            // MA 
  double? sar;                          // SAR 
  double? up, mb, dn;                   // BOLL //
}

mixin VolumeEntity {
  late double vol;                      // 
  double? MA5Volume, MA10Volume;        // 
}

mixin MACDEntity {
  double? dif, dea, macd;              // MACD 
}
abstract class KEntity
    with CandleEntity, VolumeEntity, KDJEntity, MACDEntity, RSIEntity, WREntity, CCIEntity {}
class KLineEntity extends KEntity {
  late double open, high, low, close, vol;
  double? amount, change, ratio;
  int? time;  // 
  KLineEntity.fromJson(Map<String, dynamic> json) { ... }
}
```

**:**
- ****: ，
- ****: Mixin
- ****: Dart 

```
API → KLineEntity.fromJson() → DataUtil.calculate() → 
              ↓                           ↓
         OHLCV               MA/MACD/KDJ
```

---

 `DataUtil.calculate()` :

```dart
static void calculate(List<KLineEntity> dataList,
    [List<int> maDayList = const [5, 10, 20], int n = 20, k = 2]) {
  calcMA(dataList, maDayList);     // 
  calcBOLL(dataList, n, k);        // 
  calcSAR(dataList);               // 
  calcVolumeMA(dataList);          // 
  calcKDJ(dataList);               // KDJ 
  calcMACD(dataList);              // MACD
  calcRSI(dataList);               // RSI 
  calcWR(dataList);                // 
  calcCCI(dataList);               // CCI 
}
```

```dart
static void calcMA(List<KLineEntity> dataList, List<int> maDayList) {
  List<double> ma = List<double>.filled(maDayList.length, 0);

  for (int i = 0; i < dataList.length; i++) {
    KLineEntity entity = dataList[i];
    final closePrice = entity.close;
    entity.maValueList = List<double>.filled(maDayList.length, 0);

    for (int j = 0; j < maDayList.length; j++) {
      ma[j] += closePrice;  // 

      if (i == maDayList[j] - 1) {
        entity.maValueList?[j] = ma[j] / maDayList[j];
      } else if (i >= maDayList[j]) {
        ma[j] -= dataList[i - maDayList[j]].close;
        entity.maValueList?[j] = ma[j] / maDayList[j];
      }
    }
  }
}
```

****: O(n) - 

```dart
static void calcMACD(List<KLineEntity> dataList) {
  double ema12 = 0, ema26 = 0;
  double dif = 0, dea = 0, macd = 0;

  for (int i = 0; i < dataList.length; i++) {
    final closePrice = dataList[i].close;

    if (i == 0) {
      ema12 = ema26 = closePrice;  // 
    } else {
      // EMA12 = EMA12 × 11/13 + Close × 2/13
      ema12 = ema12 * 11 / 13 + closePrice * 2 / 13;
      // EMA26 = EMA26 × 25/27 + Close × 2/27
      ema26 = ema26 * 25 / 27 + closePrice * 2 / 27;
    }

    dif = ema12 - ema26;                    // DIF = EMA12 - EMA26
    dea = dea * 8 / 10 + dif * 2 / 10;     // DEA = 9EMA(DIF)
    macd = (dif - dea) * 2;                 // MACD = 2 × (DIF - DEA)

    dataList[i]
      ..dif = dif
      ..dea = dea
      ..macd = macd;
  }
}
```

**:**
- EMA () 
- DIF () 
- MACD  DIF-DEA 

```dart
static void calcKDJ(List<KLineEntity> dataList) {
  var preK = 50.0, preD = 50.0;  // 

  for (int i = 1; i < dataList.length; i++) {
    final entity = dataList[i];
    final n = max(0, i - 8);  // 9
    var low = entity.low, high = entity.high;
    for (int j = n; j < i; j++) {
      low = min(low, dataList[j].low);
      high = max(high, dataList[j].high);
    }
    var rsv = (entity.close - low) * 100.0 / (high - low);
    rsv = rsv.isNaN ? 0 : rsv;
    final k = (2 * preK + rsv) / 3.0;
    final d = (2 * preD + k) / 3.0;
    // J = 3K - 2D
    final j = 3 * k - 2 * d;

    preK = k; preD = d;
    entity..k = k..d = d..j = j;
  }
}
```

```dart
static void calcBOLL(List<KLineEntity> dataList, int n, int k) {
  _calcBOLLMA(n, dataList);  //  (NMA)

  for (int i = 0; i < dataList.length; i++) {
    if (i >= n) {
      double md = 0;
      for (int j = i - n + 1; j <= i; j++) {
        double value = dataList[j].close - dataList[i].BOLLMA!;
        md += value * value;
      }
      md = sqrt(md / (n - 1));  // 

      dataList[i]
        ..mb = dataList[i].BOLLMA!             //  = MA20
        ..up = dataList[i].mb! + k * md        //  = MA + 2σ
        ..dn = dataList[i].mb! - k * md;       //  = MA - 2σ
    }
  }
}
```

---

```
CustomPainter
    ↓
BaseChartPainter ()
    │
    ├─  (paint )
    ├─ 
    ├─ 
    └─ 
    ↓
ChartPainter ()
    │
    ├─ 
    ├─ 
    └─ 

BaseChartRenderer<T> ()
    │
    ├── MainRenderer<CandleEntity>    ()
    ├── VolRenderer<VolumeEntity>     ()
    └── SecondaryRenderer<MACDEntity> ()
```

```dart
@override
void paint(Canvas canvas, Size size) {
  canvas.clipRect(Rect.fromLTRB(0, 0, size.width, size.height));

  initRect(size);           // 1. 
  calculateValue();         // 2. 
  initChartRenderer();      // 3. 

  canvas.save();
  drawBg(canvas, size);     // 4. 
  drawGrid(canvas);         // 5. 

  if (datas != null && datas!.isNotEmpty) {
    drawChart(canvas, size);       // 6. 
    drawVerticalText(canvas);      // 7. Y
    drawDate(canvas, size);        // 8. 
    drawText(canvas, datas!.last, 5);  // 9. 
    drawMaxAndMin(canvas);         // 10. 
    drawNowPrice(canvas);          // 11. 

    if (isLongPress || isOnTap) {
      drawCrossLineText(canvas, size);  // 12. 
    }
  }
  canvas.restore();
}
```

```dart
// MainRenderer.drawCandle()
void drawCandle(CandleEntity curPoint, Canvas canvas, double curX) {
  var high = getY(curPoint.high);
  var low = getY(curPoint.low);
  var open = getY(curPoint.open);
  var close = getY(curPoint.close);

  double r = mCandleWidth / 2;        // 
  double lineR = _calculateDynamicShadowWidth() / 2;  // 
  if (open >= close) {
    if (open - close < mCandleLineWidth) {
      open = close + mCandleLineWidth;  // 
    }
    chartPaint.color = chartColors.upColor;
    canvas.drawRect(
      Rect.fromLTRB(curX - r, close, curX + r, open),
      chartPaint
    );
    canvas.drawRect(
      Rect.fromLTRB(curX - lineR, high, curX + lineR, low),
      chartPaint
    );
  }
  else if (close > open) {
    chartPaint.color = chartColors.dnColor;
    canvas.drawRect(
      Rect.fromLTRB(curX - r, open, curX + r, close),
      chartPaint
    );
    canvas.drawRect(
      Rect.fromLTRB(curX - lineR, high, curX + lineR, low),
      chartPaint
    );
  }
}
```

**:**
- Y: Y，Y
- : ()()
-  (high → low)

```dart
void drawPolyline(double lastPrice, double curPrice, Canvas canvas,
                  double lastX, double curX) {
  mLinePath ??= Path();
  mLinePath!.moveTo(lastX, getY(lastPrice));
  mLinePath!.cubicTo(
    (lastX + curX) / 2, getY(lastPrice),  // 1
    (lastX + curX) / 2, getY(curPrice),   // 2
    curX, getY(curPrice)                   // 
  );
  mLineFillShader ??= LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [chartColors.lineFillColor, chartColors.lineFillInsideColor],
  ).createShader(chartRect);

  mLineFillPath!.moveTo(lastX, chartRect.height + chartRect.top);
  mLineFillPath!.lineTo(lastX, getY(lastPrice));
  mLineFillPath!.lineTo(curX, chartRect.height + chartRect.top);
  mLineFillPath!.close();

  canvas.drawPath(mLineFillPath!, mLineFillPaint);
  canvas.drawPath(mLinePath!, mLinePaint);
}
```

---

```
 (Index) ──────────────────>  (LogicX)
        getX(index)                      │
                                         │ 
                                         ↓
              <───────────────────  (ScreenX)
                 translateXtoX()

 (Price) ────────────────────> Y
                 getY(price)
```

```dart
double getX(int position) => position * mPointWidth + mPointWidth / 2;
double xToTranslateX(double x) => -mTranslateX + x / scaleX;
double translateXtoX(double translateX) => (translateX + mTranslateX) * scaleX;
double getY(double y) => (maxValue - y) * scaleY + _contentRect.top;
```

```dart
void setTranslateXFromScrollX(double scrollX) =>
    mTranslateX = scrollX + getMinTranslateX();
double getMinTranslateX() {
  var x = -mDataLen + mWidth / scaleX - mPointWidth / 2 - xFrontPadding / scaleX;
  return x >= 0 ? 0.0 : x;
}
void drawChart(Canvas canvas, Size size) {
  canvas.save();
  canvas.translate(mTranslateX * scaleX, 0.0);  // 
  canvas.scale(scaleX, 1.0);                    // 
  for (int i = mStartIndex; i <= mStopIndex; i++) {
  }
  canvas.restore();
}
```

:

```dart
final anchorLogicX = painter.getX(_anchorIndex);  // X
final newTranslateX = _anchorScreenX / newScaleX - anchorLogicX;
final minTranslateX = -dataLen + mWidth / newScaleX - pointWidth / 2;
mScrollX = (newTranslateX - minTranslateX).clamp(0.0, maxScrollX);
```

---

```dart
enum ChartGestureState {
  idle,               // 
  scaling,            // 
  horizontalDragging, //  ()
  verticalDragging,   //  ()
}
```

```dart
Listener(
  onPointerDown: (event) {
    _pointerCount++;
    if (_pointerCount >= 2) {
      _updateGestureState(ChartGestureState.scaling);
    }
  },
  onPointerUp: (_) {
    _pointerCount--;
    if (_pointerCount <= 0) {
      _updateGestureState(ChartGestureState.idle);
    }
  },
  child: RawGestureDetector(
    gestures: {
      ScaleGestureRecognizer: GestureRecognizerFactoryWithHandlers<ScaleGestureRecognizer>(
        ScaleGestureRecognizer.new,
        (instance) {
          instance
            ..onStart = (details) { /*  */ }
            ..onUpdate = (details) {
              if (_pointerCount >= 2) {
                final relativeScale = details.scale / _scaleBase;
                mScaleX = (_scaleXBase * relativeScale).clamp(0.2, 4.0);
              } else {
                if (!_dragDirectionDetermined) {
                  final delta = details.focalPoint - _initialPointerPosition!;
                  if (delta.dx.abs() > delta.dy.abs()) {
                    _updateGestureState(ChartGestureState.horizontalDragging);
                  } else {
                    _updateGestureState(ChartGestureState.verticalDragging);
                  }
                }
                mScrollX = (mScrollX + details.focalPointDelta.dx / mScaleX)
                    .clamp(0.0, maxScrollX);
              }
            };
        },
      ),
      LongPressGestureRecognizer: /*  */,
      TapGestureRecognizer: /*  */,
    },
  ),
)
```

```dart
void _onFling(double velocity) {
  _controller = AnimationController(
    duration: Duration(milliseconds: widget.flingTime),
    vsync: this,
  );

  aniX = Tween<double>(
    begin: mScrollX,
    end: velocity * widget.flingRatio + mScrollX,
  ).animate(CurvedAnimation(
    parent: _controller!,
    curve: widget.flingCurve,  //  Curves.decelerate
  ));

  aniX!.addListener(() {
    mScrollX = aniX!.value;
    if (mScrollX <= 0 || mScrollX >= maxScrollX) {
      _stopAnimation();
      _triggerBoundaryCallback(mScrollX >= maxScrollX);
    }

    notifyChanged();  // 
  });

  _controller!.forward();
}
```

---

```dart
mStartIndex = indexOfTranslateX(xToTranslateX(0));
mStopIndex = indexOfTranslateX(xToTranslateX(mWidth));

for (int i = mStartIndex; i <= mStopIndex; i++) {
}
```

```dart
int _indexOfTranslateX(double translateX, int start, int end) {
  if (end - start == 1) {
    return (translateX - getX(start)).abs() < (translateX - getX(end)).abs()
        ? start : end;
  }

  int mid = start + (end - start) ~/ 2;
  double midValue = getX(mid);

  if (translateX < midValue) {
    return _indexOfTranslateX(translateX, start, mid);
  } else {
    return _indexOfTranslateX(translateX, mid, end);
  }
}
```

****: O(log n)

，:

```dart
double _calculateMainIndicatorWidth() {
  if (!chartStyle.enableDynamicMainIndicatorWidth) {
    return chartStyle.mainIndicatorBaseWidth;
  }
  final baseWidth = chartStyle.mainIndicatorBaseWidth / scaleX;
  final maxWidth = min(chartStyle.mainIndicatorMaxWidth, mCandleWidth);

  return baseWidth.clamp(0.5, maxWidth);
}
```

```dart
Path? mLinePath, mLineFillPath;  //  Path 

void drawPolyline(...) {
  mLinePath ??= Path();  // 
  mLinePath!.reset();     // 
}
```

---

1. ** Mixin**:
```dart
mixin MyIndicatorEntity {
  double? myValue;
}
```

2. ** KEntity**:
```dart
abstract class KEntity with CandleEntity, ..., MyIndicatorEntity {}
```

3. ****:
```dart
static void calcMyIndicator(List<KLineEntity> dataList) {
  for (var entity in dataList) {
    entity.myValue = /*  */;
  }
}
```

4. ****:
```dart
void drawMyIndicator(Canvas canvas, ...) {
}
```

```dart
CandlestickWidget(
  datas,
  ChartStyle(
    candleWidth: 8.0,
    candleLineWidth: 1.5,
    gridRows: 5,
    gridColumns: 5,
  ),
  ChartColors(
    upColor: Colors.green,
    dnColor: Colors.red,
    ma5Color: Colors.blue,
  ),
  // ...
)
```

```dart
CandlestickWidget(
  // ...
  onGestureStateChanged: (state) {
    if (state == ChartGestureState.horizontalDragging ||
        state == ChartGestureState.scaling) {
      _parentScrollPhysics = NeverScrollableScrollPhysics();
    } else {
      _parentScrollPhysics = AlwaysScrollableScrollPhysics();
    }
  },
)
```

---

 K  Flutter :

|     |                      |
| --- | -------------------- |
|     | Mixin                |
|     | + EMA                |
|     | +                    |
|     | Canvas               |
|     | RawGestureDetector + |
|     | +                    |

****:
1.  `CustomPainter` 
2.  Canvas  (translate, scale)
3.  (`GestureRecognizer`)
4. 

---

*: 2025-12-21*
