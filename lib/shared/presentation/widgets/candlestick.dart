import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:k_chart/flutter_k_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../core/enums/timeframe.dart';
import '../../../themes/chart.dart';
import '../../../utils/format/currency.dart';
import '../../../utils/logger.dart';

class CandlestickChartWidget extends StatefulWidget {
  final List<KLineEntity> data;
  final String title;
  final Timeframe timeframe;

  const CandlestickChartWidget({
    super.key,
    required this.data,
    this.title = 'BTC/USDT',
    this.timeframe = Timeframe.h1,
  });

  @override
  State<CandlestickChartWidget> createState() => _CandlestickChartWidgetState();
}

class _CandlestickChartWidgetState extends State<CandlestickChartWidget> {
  static const double _minXFactor = 0.01;
  static const double _maxXFactor = 0.8;

  static const int _longPressMs = 350;
  static const double _tapMaxMove = 8.0;
  static const int _tapMaxMs = 250;

  late final ZoomPanBehavior _priceZoom;
  late final ZoomPanBehavior _volZoom;

  late final DateTimeAxis _priceXAxis;
  late final DateTimeAxis _volXAxis;
  late NumericAxis _priceYAxis;

  late final TrackballBehavior _trackballBehavior;
  late final CrosshairBehavior _crosshairBehavior;

  static const double _animMs = 200.0;

  bool _syncingFromPrice = false;
  bool _syncingFromVol = false;

  bool _isPinned = false;
  bool _isPointerDown = false;
  bool _longPressActive = false;
  Offset? _downPos;
  DateTime? _downAt;
  Timer? _longPressTimer;

  double _currentZoomFactor = 1.0;
  double _currentZoomPosition = 0.0;
  Offset? _lastCrosshairPosition;

  double? _visibleMinY;
  double? _visibleMaxY;

  ChartSeriesController? _seriesController;
  Offset? _latestPointPixel;

  void _initializeAxes(ChartTheme chartTheme) {
    _priceXAxis = DateTimeAxis(
      name: 'x',
      isVisible: true,
      dateFormat: DateFormat(widget.timeframe.dateFormat),
      intervalType: DateTimeIntervalType.auto,
      onRendererCreated: (DateTimeAxisController controller) {
        _priceXAxisController = controller;
      },
      labelStyle: const TextStyle(color: Colors.transparent, fontSize: 10),
      enableAutoIntervalOnZooming: false,
      majorGridLines: MajorGridLines(width: 0.5, color: chartTheme.gridColor),
      minorGridLines: MinorGridLines(
        width: 0.25,
        color: chartTheme.gridColor.withValues(alpha: 0.5),
      ),
      axisLine: const AxisLine(width: 0),
      majorTickLines: const MajorTickLines(width: 0),
      minorTickLines: const MinorTickLines(width: 0),
      rangePadding: ChartRangePadding.auto,
      // enableAutoIntervalOnZooming: true,
      labelIntersectAction: AxisLabelIntersectAction.hide,
    );

    _volXAxis = DateTimeAxis(
      name: 'vol_x',
      isVisible: true,
      dateFormat: DateFormat(widget.timeframe.dateFormat),
      intervalType: DateTimeIntervalType.auto,
      enableAutoIntervalOnZooming: false,
      onRendererCreated: (DateTimeAxisController controller) {
        _volXAxisController = controller;
      },
      majorGridLines: MajorGridLines(width: 0.5, color: chartTheme.gridColor),
      minorGridLines: MinorGridLines(
        width: 0.25,
        color: chartTheme.gridColor.withValues(alpha: .5),
      ),
      majorTickLines: const MajorTickLines(width: 0, size: 0),
      axisLine: const AxisLine(width: 0),
      labelStyle: TextStyle(color: chartTheme.secondaryTextColor, fontSize: 10),
      labelIntersectAction: AxisLabelIntersectAction.hide,
      maximumLabels: 6,
      rangePadding: ChartRangePadding.additional,
    );

    _priceYAxis = NumericAxis(
      opposedPosition: true,
      enableAutoIntervalOnZooming: true,
      majorGridLines: MajorGridLines(width: 0.5, color: chartTheme.gridColor),
      minorGridLines: MinorGridLines(
        width: 0.25,
        color: chartTheme.gridColor.withValues(alpha: 0.5),
      ),
      axisLine: const AxisLine(width: 0),
      majorTickLines: const MajorTickLines(width: 0),
      minorTickLines: const MinorTickLines(width: 0),
      labelStyle: TextStyle(color: chartTheme.secondaryTextColor, fontSize: 10),
      numberFormat: NumberFormat.currency(symbol: '\$', decimalDigits: 4),
      decimalPlaces: 4,
      rangePadding: ChartRangePadding.auto,
    );
  }

  @override
  void initState() {
    super.initState();

    if (widget.data.isNotEmpty) {
      final prices = widget.data.expand((d) => [d.high, d.low]).toList();
      if (prices.isNotEmpty) {
        final minPrice = prices.reduce((a, b) => a < b ? a : b);
        final maxPrice = prices.reduce((a, b) => a > b ? a : b);
        Logger.error(
          '📊 K: Min=$minPrice, Max=$maxPrice, Count=${widget.data.length}',
        );

        if (maxPrice == 0 || (maxPrice - minPrice).abs() < 0.0000001) {
          Logger.error('⚠️ : ,0!');
        }
      }
    }

    _priceZoom = ZoomPanBehavior(
      enablePinching: true,
      enableDoubleTapZooming: true,
      enablePanning: true,
      enableSelectionZooming: false,
      enableMouseWheelZooming: true,
      zoomMode: ZoomMode.x,
      maximumZoomLevel: _minXFactor,
    );

    _volZoom = ZoomPanBehavior(
      enablePinching: true,
      enableDoubleTapZooming: true,
      enablePanning: true,
      enableSelectionZooming: false,
      enableMouseWheelZooming: true,
      zoomMode: ZoomMode.x,
      maximumZoomLevel: _minXFactor,
    );
  }

  KLineEntity _nearestRealCandle(int xMs) {
    final data = widget.data;
    if (data.isEmpty) {
      return KLineEntity.fromCustom(
        time: xMs,
        open: 0,
        high: 0,
        low: 0,
        close: 0,
        vol: 0,
      );
    }

    int lo = 0, hi = data.length - 1;
    if (xMs <= (data.first.time ?? 0)) return data.first;
    if (xMs >= (data.last.time ?? 0)) return data.last;
    while (lo <= hi) {
      final mid = (lo + hi) >> 1;
      final t = data[mid].time ?? 0;
      if (t == xMs) return data[mid];
      if (t < xMs) {
        lo = mid + 1;
      } else {
        hi = mid - 1;
      }
    }
    return data[lo - 1];
  }

  void _initializeBehaviors(ChartTheme chartTheme) {
    _trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.none,
      shouldAlwaysShow: true,
      lineType: TrackballLineType.none,
      tooltipDisplayMode: TrackballDisplayMode.nearestPoint,
      tooltipSettings: InteractiveTooltip(
        enable: true,
        color: Colors.black.withValues(alpha: 0.8),
        // borderColor: Colors.white.withValues(alpha: 0.8),
        borderWidth: 0.5,
        textStyle: TextStyle(color: chartTheme.textColor, fontSize: 10),
      ),
      builder: (BuildContext context, TrackballDetails details) {
        final dt = (details.point?.x is DateTime)
            ? details.point!.x as DateTime
            : (widget.data.isNotEmpty
                  ? DateTime.fromMillisecondsSinceEpoch(
                      widget.data.last.time ?? 0,
                    )
                  : DateTime.now());

        final k = _nearestRealCandle(dt.millisecondsSinceEpoch);

        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'High:  ${CurrencyFormatter.abbreviateTokenPrice(k.high.toDouble(), fixedDecimals: 4)}',
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
              Text(
                'Low:   ${CurrencyFormatter.abbreviateTokenPrice(k.low.toDouble(), fixedDecimals: 4)}',
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
              Text(
                'Open:  ${CurrencyFormatter.abbreviateTokenPrice(k.open.toDouble(), fixedDecimals: 4)}',
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
              Text(
                'Close: ${CurrencyFormatter.abbreviateTokenPrice(k.close.toDouble(), fixedDecimals: 4)}',
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            ],
          ),
        );
      },
    );

    _crosshairBehavior = CrosshairBehavior(
      enable: true,
      activationMode: ActivationMode.none,
      shouldAlwaysShow: true,
      lineType: CrosshairLineType.both,
      lineColor: chartTheme.crosshairColor,
      lineWidth: 2,
      lineDashArray: const [5, 5],
    );
  }

  int _getInitialDisplayCount() {
    switch (widget.timeframe) {
      case Timeframe.m1:
        return 60;
      case Timeframe.m5:
        return 48;
      case Timeframe.m10:
        return 36;
      case Timeframe.m15:
        return 32;
      case Timeframe.m30:
        return 48;
      case Timeframe.h1:
        return 48;
      case Timeframe.h4:
        return 42;
      case Timeframe.d1:
        return 30;
      case Timeframe.w1:
        return 26;
    }
  }

  void _applyInitialViewByLastN(int lastN) {
    if (widget.data.isEmpty) return;
    final int len = widget.data.length;

    double factor;
    double position;
    if (len <= 1) {
      factor = 1.0;
      position = 1.0 - factor;
      if (position < 0) position = 0;
    } else {
      if (len <= 5) {
        factor = 0.5;
      } else {
        factor = (lastN / len).clamp(0.0, 1.0);
      }
      position = (1.0 - factor).clamp(0.0, 1.0);
    }

    _currentZoomFactor = factor;
    _currentZoomPosition = position;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _priceZoom.zoomToSingleAxis(_priceXAxis, position, factor);
      _volZoom.zoomToSingleAxis(_volXAxis, position, factor);
    });
  }

  void _scrollToDataEnd({int showLastN = 30, int rightPadSteps = 3}) {
    if (widget.data.isEmpty) return;

    final stepMs = _getTimeframeStepMs(widget.timeframe);

    final padded = _appendEmptyTail(widget.data, widget.timeframe);
    final int minTime = padded.first.time ?? widget.data.first.time ?? 0;
    final int maxTime = padded.last.time ?? widget.data.last.time ?? 0;
    final double totalRange = (maxTime - minTime).toDouble();
    if (totalRange <= 0) {
      _priceZoom.zoomToSingleAxis(_priceXAxis, 0.0, 1.0);
      _volZoom.zoomToSingleAxis(_volXAxis, 0.0, 1.0);
      return;
    }

    final int lastReal = widget.data.last.time ?? maxTime;
    final int rightEdge = (lastReal + rightPadSteps * stepMs).clamp(
      minTime,
      maxTime,
    );

    final double visibleWidthTime = (showLastN * stepMs).toDouble();

    double factor = (visibleWidthTime / totalRange).clamp(
      _minXFactor,
      _maxXFactor,
    );
    double pos = ((rightEdge - minTime) / totalRange) - factor;
    if (!pos.isFinite) pos = 0;
    pos = pos.clamp(0.0, 1.0 - factor);

    _currentZoomFactor = factor;
    _currentZoomPosition = pos;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _priceZoom.zoomToSingleAxis(_priceXAxis, pos, factor);
      _volZoom.zoomToSingleAxis(_volXAxis, pos, factor);
    });
  }

  int _calcPaddingCount() {
    const int maxPad = 10;

    int count = (maxPad * _currentZoomFactor).round();

    if (count < 1) count = 1;
    if (count > maxPad) count = maxPad;
    return count;
  }

  @override
  void didUpdateWidget(covariant CandlestickChartWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.data != oldWidget.data && _initialized) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (widget.data.length < 20) {
          final showCount = widget.data.length + 4;
          _scrollToDataEnd(
            showLastN: showCount > 10 ? showCount : 10,
            rightPadSteps: 2,
          );
        } else if (_currentZoomFactor != 1.0 || _currentZoomPosition != 0.0) {
          _priceZoom.zoomToSingleAxis(
            _priceXAxis,
            _currentZoomPosition,
            _currentZoomFactor,
          );
          _volZoom.zoomToSingleAxis(
            _volXAxis,
            _currentZoomPosition,
            _currentZoomFactor,
          );
        }

        if (_isPinned && _lastCrosshairPosition != null) {
          _showAt(_lastCrosshairPosition!);
        }

        _updateLatestPixel();
      });
    }
  }

  @override
  void dispose() {
    _longPressTimer?.cancel();
    super.dispose();
  }

  void _onPriceZooming(ZoomPanArgs args) {
    if (_syncingFromVol) return;
    if (args.axis?.name != 'x') return;

    _syncingFromPrice = true;

    final factor = args.currentZoomFactor
        .clamp(_minXFactor, _maxXFactor)
        .toDouble();
    final position = args.currentZoomPosition
        .clamp(0.0, 1.0 - factor)
        .toDouble();

    _currentZoomFactor = factor;
    _currentZoomPosition = position;

    _volXAxisController?.zoomFactor = factor;
    _volXAxisController?.zoomPosition = position;

    _volZoom.zoomToSingleAxis(_volXAxis, position, factor);

    _syncingFromPrice = false;

    setState(() {});
  }

  void _onVolZooming(ZoomPanArgs args) {
    if (_syncingFromPrice) return;
    if (args.axis?.name != 'vol_x') return;

    _syncingFromVol = true;

    final factor = args.currentZoomFactor
        .clamp(_minXFactor, _maxXFactor)
        .toDouble();
    final position = args.currentZoomPosition
        .clamp(0.0, 1.0 - factor)
        .toDouble();

    _currentZoomFactor = factor;
    _currentZoomPosition = position;

    _priceXAxisController?.zoomFactor = factor;
    _priceXAxisController?.zoomPosition = position;

    _priceZoom.zoomToSingleAxis(_priceXAxis, position, factor);

    _syncingFromVol = false;
  }

  void _updateLatestPixel() {
    if (_seriesController == null || widget.data.isEmpty) return;

    final last = widget.data.last;
    final DateTime xTime = DateTime.fromMillisecondsSinceEpoch(last.time ?? 0);
    final double yPrice = last.close;

    final offset = _seriesController!.pointToPixel(
      CartesianChartPoint<DateTime>(x: xTime, y: yPrice),
    );

    if (mounted) {
      setState(() {
        _latestPointPixel = offset;
      });
    }
  }

  void _showAt(Offset p) {
    _trackballBehavior.show(p.dx, p.dy, 'pixel');
    _crosshairBehavior.show(p.dx, p.dy, 'pixel');
    _isPinned = true;
    _lastCrosshairPosition = p;
  }

  void _hideAll() {
    _trackballBehavior.hide();
    _crosshairBehavior.hide();
    _isPinned = false;
    _lastCrosshairPosition = null;
  }

  void _onDown(ChartTouchInteractionArgs args) {
    _isPointerDown = true;
    _longPressActive = false;
    _downPos = args.position;
    _downAt = DateTime.now();

    _longPressTimer?.cancel();
    _longPressTimer = Timer(const Duration(milliseconds: _longPressMs), () {
      if (!_isPointerDown || _downPos == null) return;

      _longPressActive = true;
      _showAt(_downPos!);
    });
  }

  DateTimeAxisController? _priceXAxisController;
  DateTimeAxisController? _volXAxisController;

  void _onMove(ChartTouchInteractionArgs args) {
    if (!_isPointerDown) return;

    if (_longPressActive) {
      _showAt(args.position);
    } else {
      if (_downPos != null &&
          (args.position - _downPos!).distance > _tapMaxMove) {
        _longPressTimer?.cancel();
      }
    }
  }

  void _onUp(ChartTouchInteractionArgs args) {
    _longPressTimer?.cancel();

    final wasLong = _longPressActive;
    final pressDurationMs = _downAt == null
        ? 9999
        : DateTime.now().difference(_downAt!).inMilliseconds;
    final movedFar = _downPos == null
        ? true
        : (args.position - _downPos!).distance > _tapMaxMove;
    final isTap = !wasLong && !movedFar && pressDurationMs <= _tapMaxMs;

    if (wasLong) {
      _isPinned = true;
    } else if (isTap) {
      if (_isPinned) {
        _hideAll();
      } else {
        _showAt(args.position);
      }
    }
    _isPointerDown = false;
    _longPressActive = false;
    _downPos = null;
    _downAt = null;
  }

  @override
  Widget build(BuildContext context) {
    const chartTheme = ChartTheme.light;

    if (!_initialized) {
      _initializeAxes(chartTheme);
      _initializeBehaviors(chartTheme);
      _initialized = true;

      final initialDisplayCount = _getInitialDisplayCount();
      _scrollToDataEnd(showLastN: initialDisplayCount, rightPadSteps: 2);
    }

    return Container(
      decoration: BoxDecoration(
        color: chartTheme.backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Expanded(flex: 3, child: _buildCandlestickChart(chartTheme)),
          Expanded(flex: 1, child: _buildVolumeChart(chartTheme)),
        ],
      ),
    );
  }

  int _getTimeframeStepMs(Timeframe tf) {
    switch (tf) {
      case Timeframe.m1:
        return 60 * 1000;
      case Timeframe.m5:
        return 5 * 60 * 1000;
      case Timeframe.m10:
        return 10 * 60 * 1000;
      case Timeframe.m15:
        return 15 * 60 * 1000;
      case Timeframe.m30:
        return 30 * 60 * 1000;
      case Timeframe.h1:
        return 60 * 60 * 1000;
      case Timeframe.h4:
        return 4 * 60 * 60 * 1000;
      case Timeframe.d1:
        return 24 * 60 * 60 * 1000;
      case Timeframe.w1:
        return 7 * 24 * 60 * 60 * 1000;
    }
  }

  List<KLineEntity> _appendEmptyTail(List<KLineEntity> source, Timeframe tf) {
    if (source.isEmpty) return source;

    final List<KLineEntity> out = List<KLineEntity>.from(source);
    final last = source.last;

    final int stepMs = _getTimeframeStepMs(tf);

    int baseEmpty;
    switch (tf) {
      case Timeframe.m1:
        baseEmpty = 2;
        break;
      case Timeframe.m5:
        baseEmpty = 4;
        break;
      case Timeframe.m10:
        baseEmpty = 6;
        break;
      case Timeframe.m15:
        baseEmpty = 8;
        break;
      case Timeframe.m30:
        baseEmpty = 10;
        break;
      case Timeframe.h1:
        baseEmpty = 12;
        break;
      case Timeframe.h4:
        baseEmpty = 16;
        break;
      case Timeframe.d1:
        baseEmpty = 20;
        break;
      case Timeframe.w1:
        baseEmpty = 24;
        break;
    }

    int emptyCount = baseEmpty + (_currentZoomFactor * 10).round();

    for (int i = 1; i <= emptyCount; i++) {
      final tailTime = (last.time ?? 0) + stepMs * i;
      out.add(
        KLineEntity.fromCustom(
          time: tailTime,
          open: 0,
          close: 0,
          high: 0,
          low: 0,
          vol: 0,
        ),
      );
    }

    return out;
  }

  bool _initialized = false;

  Widget _buildCandlestickChart(ChartTheme chartTheme) {
    NumericAxis dynamicYAxis = _priceYAxis;
    final last = widget.data.isNotEmpty ? widget.data.last : null;
    final lastPrice = last?.close;

    final filledData = _fillTimeGaps(widget.data, widget.timeframe);
    final paddedData = _appendEmptyTail(filledData, widget.timeframe);

    if (paddedData.isNotEmpty) {
      final allPrices = filledData.expand((d) => [d.high, d.low]).toList();
      if (allPrices.isNotEmpty) {
        final minPrice = allPrices.reduce((a, b) => a < b ? a : b);
        final maxPrice = allPrices.reduce((a, b) => a > b ? a : b);
        final range = maxPrice - minPrice;
        final padding = range * 0.1;

        double? interval;
        int? maximumLabels;

        if (range > 0) {
          final double normalizedFactor = _currentZoomFactor.clamp(
            _minXFactor,
            _maxXFactor,
          );
          final double factorRatio =
              (normalizedFactor - _minXFactor) / (_maxXFactor - _minXFactor);
          final int labelCount = (4 + (1 - factorRatio) * 4).round().clamp(
            4,
            8,
          );
          maximumLabels = labelCount;

          final double visibleRange = range + padding * 2;
          interval = visibleRange / (labelCount - 1);

          if (interval > 0) {
            final double magnitude = (interval / 10).floor() * 10;
            final double order = magnitude > 0
                ? pow(10, (log(interval) / ln10).floor()).toDouble()
                : 1.0;
            interval = ((interval / order).round() * order).toDouble();

            if (interval <= 0) {
              interval = null;
            }
          } else {
            interval = null;
          }
        }

        dynamicYAxis = NumericAxis(
          labelPosition: ChartDataLabelPosition.inside,
          opposedPosition: true,
          axisLine: const AxisLine(width: 0),
          majorGridLines: MajorGridLines(
            width: 0.5,
            color: chartTheme.gridColor,
          ),
          minorGridLines: MinorGridLines(
            width: 0.25,
            color: chartTheme.gridColor.withValues(alpha: 0.5),
          ),
          majorTickLines: const MajorTickLines(width: 0),
          minorTickLines: const MinorTickLines(width: 0),
          labelStyle: TextStyle(color: chartTheme.textColor, fontSize: 10),

          interval: interval,
          maximumLabels: maximumLabels?.toInt() ?? 0,
          enableAutoIntervalOnZooming: false,
          plotBands: <PlotBand>[
            if (lastPrice != null)
              PlotBand(
                isVisible: true,
                start: lastPrice,
                end: lastPrice,
                color: Colors.transparent,
                borderColor: (last!.close >= last.open)
                    ? chartTheme.bullColor
                    : chartTheme.bearColor,
                borderWidth: 1,
                dashArray: const <double>[6, 4],
                shouldRenderAboveSeries: true,
              ),
          ],
          axisLabelFormatter: (AxisLabelRenderDetails args) {
            final num raw = args.value;
            final double v = raw.toDouble();

            return ChartAxisLabel(
              CurrencyFormatter.abbreviateTokenPrice(v, fixedDecimals: 4),
              args.textStyle,
            );
          },
          rangePadding: ChartRangePadding.auto,
        );

        _visibleMinY = minPrice - padding;
        _visibleMaxY = maxPrice + padding;
      }
    }

    const double tagHeight = 24;
    final lastEntity = filledData.isNotEmpty
        ? filledData.last
        : widget.data.last;
    final lastTimeMs = lastEntity.time ?? 0;
    final extendTimeMs = lastTimeMs + 60 * 1000;

    return LayoutBuilder(
      builder: (context, constraints) {
        final chart = SfCartesianChart(
          backgroundColor: Colors.transparent,
          plotAreaBorderWidth: 0,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          onChartTouchInteractionDown: _onDown,
          onChartTouchInteractionMove: _onMove,
          onChartTouchInteractionUp: _onUp,
          primaryXAxis: _priceXAxis,
          primaryYAxis: dynamicYAxis,
          zoomPanBehavior: _priceZoom,
          trackballBehavior: _trackballBehavior,
          crosshairBehavior: _crosshairBehavior,
          onZooming: _onPriceZooming,
          onActualRangeChanged: (args) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _updateLatestPixel();
            });
          },
          series: <CartesianSeries>[
            CandleSeries<KLineEntity, DateTime>(
              name: 'candle',
              dataSource: paddedData,
              xValueMapper: (d, _) =>
                  DateTime.fromMillisecondsSinceEpoch(d.time ?? 0),
              lowValueMapper: (d, _) => _isPaddingPoint(d) ? null : d.low,
              highValueMapper: (d, _) => _isPaddingPoint(d) ? null : d.high,
              openValueMapper: (d, _) => _isPaddingPoint(d) ? null : d.open,
              closeValueMapper: (d, _) => _isPaddingPoint(d) ? null : d.close,
              bearColor: chartTheme.bearColor,
              bullColor: chartTheme.bullColor,
              emptyPointSettings: const EmptyPointSettings(
                mode: EmptyPointMode.gap,
              ),
              enableSolidCandles: true,
              enableTooltip: false,
              animationDuration: _animMs,
              spacing: 0.01,
              width: 0.9,
              onRendererCreated: (controller) {
                _seriesController = controller;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _updateLatestPixel();
                });
              },
            ),
            LineSeries<KLineEntity, DateTime>(
              name: 'lastLine',
              animationDuration: _animMs,
              dataSource: <KLineEntity>[
                KLineEntity.fromCustom(
                  time: lastTimeMs,
                  open: lastEntity.close,
                  high: lastEntity.close,
                  low: lastEntity.close,
                  close: lastEntity.close,
                  vol: 0,
                ),
                KLineEntity.fromCustom(
                  time: extendTimeMs,
                  open: lastEntity.close,
                  high: lastEntity.close,
                  low: lastEntity.close,
                  close: lastEntity.close,
                  vol: 0,
                ),
              ],
              xValueMapper: (d, _) =>
                  DateTime.fromMillisecondsSinceEpoch(d.time ?? 0),
              yValueMapper: (d, _) => lastEntity.close,
              color: lastEntity.close >= lastEntity.open
                  ? chartTheme.bullColor
                  : chartTheme.bearColor,
              width: 1,
              dashArray: const <double>[6, 4],
            ),
          ],
        );

        return Stack(
          children: [
            Positioned.fill(child: chart),
            if (_latestPointPixel != null && widget.data.isNotEmpty) ...[
              Positioned(
                right: 4,
                top: (_latestPointPixel!.dy - tagHeight / 2).clamp(
                  0.0,
                  constraints.maxHeight - tagHeight,
                ),
                child: Container(
                  height: tagHeight,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: widget.data.last.close >= widget.data.last.open
                        ? chartTheme.bullColor
                        : chartTheme.bearColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    CurrencyFormatter.abbreviateTokenPrice(
                      widget.data.last.close,
                      fixedDecimals: 4,
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildVolumeChart(ChartTheme chartTheme) {
    final filledData = _fillTimeGaps(widget.data, widget.timeframe);

    final Set<int> timeHasVolume = {
      for (final d in filledData)
        if ((d.time ?? 0) > 0 && d.vol > 0) d.time!,
    };

    final paddedData = _appendEmptyTail(filledData, widget.timeframe);

    return SfCartesianChart(
      backgroundColor: Colors.transparent,
      plotAreaBorderWidth: 0,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      zoomPanBehavior: _volZoom,
      onZooming: _onVolZooming,
      primaryXAxis: DateTimeAxis(
        name: 'vol_x',
        isVisible: true,
        dateFormat: DateFormat(widget.timeframe.dateFormat),
        intervalType: DateTimeIntervalType.auto,
        majorGridLines: const MajorGridLines(width: 0),
        majorTickLines: const MajorTickLines(width: 0, size: 0),
        axisLine: const AxisLine(width: 0),
        labelIntersectAction: AxisLabelIntersectAction.hide,
        axisLabelFormatter: (AxisLabelRenderDetails details) {
          final String labelText = details.text;
          if (labelText.isEmpty) {
            return ChartAxisLabel('', const TextStyle(fontSize: 0));
          }

          DateTime? dt;
          try {
            dt = DateFormat(widget.timeframe.dateFormat).parse(labelText);
            if (dt.year < 2000) {
              final now = DateTime.now();
              dt = DateTime(now.year, dt.month, dt.day, dt.hour, dt.minute);
            }
          } catch (_) {
            dt = null;
          }
          if (dt == null) {
            return ChartAxisLabel(
              labelText,
              const TextStyle(color: Colors.grey, fontSize: 10),
            );
          }

          final int ts = dt.millisecondsSinceEpoch;
          final int cycleMs = widget.timeframe.duration.inMinutes * 60 * 1000;
          final int alignedTs = (ts ~/ cycleMs) * cycleMs;

          int minDiff = cycleMs * 10;
          for (final t in timeHasVolume) {
            final diff = (t - alignedTs).abs();
            if (diff < minDiff) {
              minDiff = diff;
            }
          }

          const int allowedDiff = 5000;
          if (minDiff > allowedDiff) {
            return ChartAxisLabel('', const TextStyle(fontSize: 0));
          }

          return ChartAxisLabel(
            labelText,
            const TextStyle(color: Colors.grey, fontSize: 10),
          );
        },
      ),
      primaryYAxis: const NumericAxis(
        isVisible: false,
        opposedPosition: true,
        majorGridLines: MajorGridLines(width: 0),
        minorGridLines: MinorGridLines(width: 0),
        axisLine: AxisLine(width: 0),
        majorTickLines: MajorTickLines(width: 0, size: 0),
        minorTickLines: MinorTickLines(width: 0, size: 0),
      ),
      series: <CartesianSeries>[
        ColumnSeries<KLineEntity, DateTime>(
          dataSource: paddedData,
          xValueMapper: (d, _) =>
              DateTime.fromMillisecondsSinceEpoch(d.time ?? 0),
          yValueMapper: (d, _) => d.vol,
          emptyPointSettings: const EmptyPointSettings(
            mode: EmptyPointMode.gap,
          ),
          pointColorMapper: (d, _) => d.close >= d.open
              ? chartTheme.bullColor.withValues(alpha: 0.5)
              : chartTheme.bearColor.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(2),
          spacing: 0.01,
          width: 0.9,
          animationDuration: _animMs,
        ),
      ],
    );
  }

  bool _isPaddingPoint(KLineEntity d) {
    return (d.open == 0 &&
        d.high == 0 &&
        d.low == 0 &&
        d.close == 0 &&
        d.vol == 0);
  }

  List<KLineEntity> _fillTimeGaps(List<KLineEntity> data, Timeframe tf) {
    if (data.isEmpty || data.length == 1) return data;

    final List<KLineEntity> filled = [];
    final int stepMs = _getTimeframeStepMs(tf);

    for (int i = 0; i < data.length; i++) {
      filled.add(data[i]);

      if (i < data.length - 1) {
        final currentTime = data[i].time ?? 0;
        final nextTime = data[i + 1].time ?? 0;
        final gap = nextTime - currentTime;

        if (gap > stepMs * 1.5) {
          final gapCount = (gap / stepMs).floor() - 1;
          final lastClose = data[i].close;

          for (int j = 1; j <= gapCount && j <= 100; j++) {
            final fillTime = currentTime + stepMs * j;
            filled.add(
              KLineEntity.fromCustom(
                time: fillTime,
                open: lastClose,
                high: lastClose,
                low: lastClose,
                close: lastClose,
                vol: 0,
              ),
            );
          }
        }
      }
    }

    return filled;
  }
}

class _FixedGridPainter extends CustomPainter {
  final Color gridColor;
  final int horizontalLines;
  final int verticalLines;

  _FixedGridPainter({
    required this.gridColor,
    required this.horizontalLines,
    required this.verticalLines,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    if (horizontalLines > 0) {
      for (int i = 0; i < horizontalLines; i++) {
        if (i == 0 || i == horizontalLines - 1) continue;

        final y = (size.height / (horizontalLines - 1)) * i;
        canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
      }
    }

    if (verticalLines > 0) {
      for (int i = 0; i < verticalLines; i++) {
        final x = (size.width / (verticalLines - 1)) * i;
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
