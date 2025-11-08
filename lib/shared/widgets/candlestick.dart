import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/core/enums/timeframe.dart';
import 'package:flutter_aigun/themes/chart.dart';
import 'package:flutter_aigun/utils/format/currency.dart';
import 'package:flutter_aigun/utils/logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:k_chart/flutter_k_chart.dart';
import 'package:money2/money2.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

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
  // —— 缩放限制
  static const double _minXFactor = 0.01;
  static const double _maxXFactor = 1.0; // 最大缩小度 - 缩小到显示100%的数据

  // —— 单击/长按判定阈值
  static const int _longPressMs = 350; // 长按判定时长
  static const double _tapMaxMove = 8.0; // 单击允许的最大位移
  static const int _tapMaxMs = 250; // 单击允许的最长时长

  // 缩放行为（主图 / 成交量图）
  late final ZoomPanBehavior _priceZoom;
  late final ZoomPanBehavior _volZoom;

  // X 轴（必须持有轴实例，便于编程式缩放）
  late final DateTimeCategoryAxis _priceXAxis;
  late final DateTimeCategoryAxis _volXAxis;
  late NumericAxis _priceYAxis;

  // 十字/轨迹
  late final TrackballBehavior _trackballBehavior;
  late final CrosshairBehavior _crosshairBehavior;

  static const double _animMs = 200.0;

  // 递归保护（避免 A 触发 B、B 又触发 A）
  bool _syncingFromPrice = false;
  bool _syncingFromVol = false;

  // —— 手势状态
  bool _isPinned = false; // 当前是否固定/显示
  bool _isPointerDown = false; // 手指是否按下
  bool _longPressActive = false; // 是否已进入长按跟随模式
  Offset? _downPos;
  DateTime? _downAt;
  Timer? _longPressTimer;

  // —— 保存缩放状态，用于数据更新时恢复
  double _currentZoomFactor = 1.0;
  double _currentZoomPosition = 0.0;
  Offset? _lastCrosshairPosition; // 保存十字指针位置

  // —— 记录当前 Y 轴的可见范围（用于计算浮动标签位置）
  double? _visibleMinY;
  double? _visibleMaxY;

  // —— K线序列控制器和最新价格像素位置
  ChartSeriesController? _seriesController;
  Offset? _latestPointPixel;

  void _initializeAxes(ChartTheme chartTheme) {
    // 初始化 X 轴，使用 widget.timeframe 的日期格式
    _priceXAxis = DateTimeCategoryAxis(
      name: 'x',
      isVisible: false,
      // 禁用自动滚动，防止数据更新时重置缩放位置
      // autoScrollingDelta: 5,
      // autoScrollingMode: AutoScrollingMode.end,
      // 隐藏动态网格线（使用自定义固定网格）
      majorGridLines: const MajorGridLines(width: 0),
      // minorGridLines: const MinorGridLines(width: 0),
      axisLine: const AxisLine(width: 0),
      labelStyle: TextStyle(color: chartTheme.secondaryTextColor, fontSize: 10),
      dateFormat: DateFormat(widget.timeframe.dateFormat),
      intervalType: DateTimeIntervalType.auto,
    );

    _volXAxis = DateTimeCategoryAxis(
      name: 'x',
      isVisible: true,
      dateFormat: DateFormat(widget.timeframe.dateFormat),
      intervalType: DateTimeIntervalType.auto,
      // 禁用自动滚动，防止数据更新时重置缩放位置
      // autoScrollingDelta: 5,
      // autoScrollingMode: AutoScrollingMode.end,
      // 隐藏动态网格线（使用自定义固定网格）
      majorGridLines: const MajorGridLines(width: 0),
      // minorGridLines: const MinorGridLines(width: 0),
      majorTickLines: const MajorTickLines(width: 0, size: 0),
      axisLine: const AxisLine(width: 0),
      labelStyle: TextStyle(color: chartTheme.secondaryTextColor, fontSize: 10),
      labelIntersectAction: AxisLabelIntersectAction.hide,
      maximumLabels: 6,
    );

    _priceYAxis = NumericAxis(
      labelPosition: ChartDataLabelPosition.inside,
      opposedPosition: true,
      // 隐藏动态网格线（使用自定义固定网格）
      majorGridLines: const MajorGridLines(width: 0),
      minorGridLines: const MinorGridLines(width: 0),
      minorTicksPerInterval: 0,
      axisLine: const AxisLine(width: 0),
      majorTickLines: const MajorTickLines(width: 0), // 隐藏Y轴刻度线
      minorTickLines: const MinorTickLines(width: 0), // 隐藏Y轴次刻度线
      labelStyle: TextStyle(color: chartTheme.secondaryTextColor, fontSize: 10),
      numberFormat: NumberFormat.currency(symbol: '\$', decimalDigits: 4),
      decimalPlaces: 4, // 最多显示4位小数
      rangePadding: ChartRangePadding.auto, // 自动计算合适的Y轴范围
    );
  }

  @override
  void initState() {
    super.initState();

    // 调试: 打印数据范围
    if (widget.data.isNotEmpty) {
      final prices = widget.data.expand((d) => [d.high, d.low]).toList();
      if (prices.isNotEmpty) {
        final minPrice = prices.reduce((a, b) => a < b ? a : b);
        final maxPrice = prices.reduce((a, b) => a > b ? a : b);
        Logger.error(
            '📊 K线数据范围: Min=$minPrice, Max=$maxPrice, Count=${widget.data.length}');

        // 检查是否所有价格都是0
        if (maxPrice == 0 || (maxPrice - minPrice).abs() < 0.0000001) {
          Logger.error('⚠️ 警告: 价格数据异常,所有价格相同或为0!');
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

  void _initializeBehaviors(ChartTheme chartTheme) {
    // —— Trackball 只作为"十字旁的小面板"，不自动触发，全部由代码控制
    _trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.none,
      shouldAlwaysShow: true,
      lineType: TrackballLineType.none,
      tooltipDisplayMode: TrackballDisplayMode.nearestPoint,
      tooltipSettings: InteractiveTooltip(
        enable: true,
        color: chartTheme.tooltipBackground,
        borderColor: chartTheme.tooltipBorder,
        borderWidth: 0.5,
        textStyle: TextStyle(color: chartTheme.textColor, fontSize: 10),
      ),
    );

    // —— Crosshair 只画线，不自动触发
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

  /// 根据时间周期返回初始应该显示的K线数量
  /// 目标：让图表看起来密集但不拥挤
  int _getInitialDisplayCount() {
    switch (widget.timeframe) {
      case Timeframe.m1:
        return 60; // 1分钟：显示1小时
      case Timeframe.m5:
        return 48; // 5分钟：显示4小时
      case Timeframe.m10:
        return 36; // 10分钟：显示6小时
      case Timeframe.m15:
        return 32; // 15分钟：显示8小时
      case Timeframe.m30:
        return 48; // 30分钟：显示24小时
      case Timeframe.h1:
        return 48; // 1小时：显示2天
      case Timeframe.h4:
        return 42; // 4小时：显示7天
      case Timeframe.d1:
        return 30; // 1天：显示30天
      case Timeframe.w1:
        return 26; // 1周：显示半年
    }
  }

  // 计算 factor/position 并应用到两个图表
  void _applyInitialViewByLastN(int lastN) {
    if (widget.data.isEmpty) return;
    final int len = widget.data.length;
    final double factor = (lastN / len).clamp(0.0, 1.0); // 初始缩放比例
    final double position = (1.0 - factor).clamp(0.0, 1.0); // 把窗口贴到最右（最新）

    // 若你限制了最大放大度（_minXFactor），要确保初始 factor ≥ _minXFactor
    // 否则会被限制住看不到那么"窄"的窗口
    final double appliedFactor = factor.clamp(_minXFactor, 1.0);

    // 保存初始缩放状态
    _currentZoomFactor = appliedFactor;
    _currentZoomPosition = position;

    // 等第一帧布局完再调用（轴/行为就绪）
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _priceZoom.zoomToSingleAxis(_priceXAxis, position, appliedFactor);
      _volZoom.zoomToSingleAxis(_volXAxis, position, appliedFactor);
    });
  }

  @override
  void didUpdateWidget(covariant CandlestickChartWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 检测数据是否更新
    if (widget.data != oldWidget.data && _initialized) {
      // 数据更新后，在下一帧恢复缩放状态
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // 恢复缩放位置
        if (_currentZoomFactor != 1.0 || _currentZoomPosition != 0.0) {
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

        // 恢复十字指针位置
        if (_isPinned && _lastCrosshairPosition != null) {
          _showAt(_lastCrosshairPosition!);
        }
      });
    }
  }

  @override
  void dispose() {
    _longPressTimer?.cancel();
    super.dispose();
  }

  // —— 缩放同步：主图 -> 成交量图（立即同步）
  void _onPriceZooming(ZoomPanArgs args) {
    // 递归保护：如果正在从成交量图同步过来，直接返回
    if (_syncingFromVol) return;
    // 只同步 X 轴
    if (args.axis?.name != 'x') return;

    _syncingFromPrice = true;

    // 限制缩放范围
    final factor =
        args.currentZoomFactor.clamp(_minXFactor, _maxXFactor).toDouble();
    final position =
        args.currentZoomPosition.clamp(0.0, 1.0 - factor).toDouble();

    // 保存当前缩放状态
    _currentZoomFactor = factor;
    _currentZoomPosition = position;

    // 立即同步到成交量图
    _volZoom.zoomToSingleAxis(_volXAxis, position, factor);

    _syncingFromPrice = false;
  }

  // —— 缩放同步：成交量图 -> 主图（立即同步）
  void _onVolZooming(ZoomPanArgs args) {
    // 递归保护：如果正在从主图同步过来，直接返回
    if (_syncingFromPrice) return;
    // 只同步 X 轴
    if (args.axis?.name != 'x') return;

    _syncingFromVol = true;

    // 限制缩放范围
    final factor =
        args.currentZoomFactor.clamp(_minXFactor, _maxXFactor).toDouble();
    final position =
        args.currentZoomPosition.clamp(0.0, 1.0 - factor).toDouble();

    // 保存当前缩放状态
    _currentZoomFactor = factor;
    _currentZoomPosition = position;

    // 立即同步到主图
    _priceZoom.zoomToSingleAxis(_priceXAxis, position, factor);

    _syncingFromVol = false;
  }

  // —— 更新最新价格的像素位置
  void _updateLatestPixel() {
    if (_seriesController == null || widget.data.isEmpty) return;
    final last = widget.data.last;
    if (last.time == null) return;

    final point = CartesianChartPoint<dynamic>(
      x: DateTime.fromMillisecondsSinceEpoch(last.time!),
      y: last.close,
    );
    final pixel = _seriesController!.pointToPixel(point);

    if (mounted) {
      setState(() {
        _latestPointPixel = pixel;
      });
    }
  }

  // —— 程序化显示/隐藏（在像素坐标处）
  void _showAt(Offset p) {
    // 使用 'pixel' 参数指定坐标单位为像素
    _trackballBehavior.show(p.dx, p.dy, 'pixel');
    _crosshairBehavior.show(p.dx, p.dy, 'pixel');
    _isPinned = true;
    _lastCrosshairPosition = p; // 保存位置
  }

  void _hideAll() {
    _trackballBehavior.hide();
    _crosshairBehavior.hide();
    _isPinned = false;
    _lastCrosshairPosition = null; // 清除位置
  }

  // —— 手势：按下/移动/抬起/取消
  void _onDown(ChartTouchInteractionArgs args) {
    _isPointerDown = true;
    _longPressActive = false;
    _downPos = args.position;
    _downAt = DateTime.now();

    // 启动长按定时器：到时未移动过远则进入长按模式并显示
    _longPressTimer?.cancel();
    _longPressTimer = Timer(const Duration(milliseconds: _longPressMs), () {
      if (!_isPointerDown || _downPos == null) return;
      // 长按触发
      _longPressActive = true;
      _showAt(_downPos!);
    });
  }

  void _onMove(ChartTouchInteractionArgs args) {
    if (!_isPointerDown) return;
    // 如果进入了长按模式，跟随移动
    if (_longPressActive) {
      _showAt(args.position);
    } else {
      // 未进入长按：若移动过远，取消长按判定
      if (_downPos != null &&
          (args.position - _downPos!).distance > _tapMaxMove) {
        _longPressTimer?.cancel();
      }
    }
  }

  void _onUp(ChartTouchInteractionArgs args) {
    // 结束按压
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
      // 长按松开：保持当前显示（固定）
      _isPinned = true;
    } else if (isTap) {
      // 单击：切换显示/隐藏
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
    // final theme = Theme.of(context);
    // final chartTheme = ChartTheme.fromBrightness(theme.brightness);
    const chartTheme = ChartTheme.light;

    // 在首次构建时初始化轴和行为
    if (!_initialized) {
      _initializeAxes(chartTheme);
      _initializeBehaviors(chartTheme);
      _initialized = true;
      // 根据时间周期调整初始显示的K线数量
      final initialDisplayCount = _getInitialDisplayCount();
      _applyInitialViewByLastN(initialDisplayCount);
    }

    return Container(
      decoration: BoxDecoration(
        color: chartTheme.backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // _buildChartHeader(chartTheme),
          Expanded(flex: 3, child: _buildCandlestickChart(chartTheme)),
          Expanded(flex: 1, child: _buildVolumeChart(chartTheme)),
        ],
      ),
    );
  }

  bool _initialized = false;

  // 构建固定网格背景（主图：横线+竖线）
  Widget _buildFixedGrid(ChartTheme chartTheme) {
    return CustomPaint(
      painter: _FixedGridPainter(
        gridColor: chartTheme.gridColor,
        horizontalLines: 5, // 横线数量
        verticalLines: 6, // 竖线数量
      ),
      child: Container(),
    );
  }

  // 构建固定网格背景（成交量图：只有横线）
  Widget _buildFixedGridHorizontalOnly(ChartTheme chartTheme) {
    return CustomPaint(
      painter: _FixedGridPainter(
        gridColor: chartTheme.gridColor,
        horizontalLines: 3, // 横线数量
        verticalLines: 0, // 不显示竖线
      ),
      child: Container(),
    );
  }

  Widget _buildCandlestickChart(ChartTheme chartTheme) {
    // 动态计算Y轴格式化精度 (最多4位小数)
    NumericAxis dynamicYAxis = _priceYAxis;
    final last = widget.data.isNotEmpty ? widget.data.last : null;

    final lastPrice = last?.close;

    // 计算可见数据的Y轴范围
    if (widget.data.isNotEmpty) {
      final allPrices = widget.data.expand((d) => [d.high, d.low]).toList();
      if (allPrices.isNotEmpty) {
        final minPrice = allPrices.reduce((a, b) => a < b ? a : b);
        final maxPrice = allPrices.reduce((a, b) => a > b ? a : b);

        // 应用 rangePadding，大约增加 10% 的边距
        final range = maxPrice - minPrice;
        final padding = range * 0.1;
        _visibleMinY = minPrice - padding;
        _visibleMaxY = maxPrice + padding;

        final decimalPlaces = maxPrice < 0.01 ? 4 : (maxPrice < 1 ? 4 : 2);
        dynamicYAxis = NumericAxis(
          labelPosition: ChartDataLabelPosition.inside,
          opposedPosition: true,
          majorGridLines: const MajorGridLines(width: 0),
          minorGridLines: const MinorGridLines(width: 0),
          minorTicksPerInterval: 0,
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(width: 0),
          minorTickLines: const MinorTickLines(width: 0),
          labelStyle:
              TextStyle(color: chartTheme.secondaryTextColor, fontSize: 10),
          numberFormat: NumberFormat.currency(
            symbol: '\$',
            decimalDigits: decimalPlaces,
          ),
          decimalPlaces: decimalPlaces,
          rangePadding: ChartRangePadding.auto,
          plotBands: [
            PlotBand(
              isVisible: true,
              start: lastPrice,
              end: lastPrice,
              // 只画虚线，不显示文字
              text: CurrencyFormatter.abbreviateTokenPriceWithSymbol(
                  lastPrice ?? 0),
              horizontalTextAlignment: TextAnchor.start,
              verticalTextAlignment: TextAnchor.end,
              textStyle: TextStyle(
                  color: (last?.close ?? 0) >= (last?.open ?? 0)
                      ? chartTheme.bullColor
                      : chartTheme.bearColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold),
              borderWidth: 1,
              borderColor: (last?.close ?? 0) >= (last?.open ?? 0)
                  ? chartTheme.bullColor
                  : chartTheme.bearColor,
              dashArray: const <double>[6, 4],
              shouldRenderAboveSeries: true,
            ),
          ],
        );
      }
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final chartHeight = constraints.maxHeight;

        // 计算标签应该在的 y 像素
        double? tagTop;
        if (lastPrice != null &&
            _visibleMinY != null &&
            _visibleMaxY != null &&
            _visibleMaxY != _visibleMinY) {
          // 注意：Y轴是从上到下，所以最大值在顶部
          final ratio =
              (_visibleMaxY! - lastPrice) / (_visibleMaxY! - _visibleMinY!);
          tagTop = ratio * chartHeight;
        }

        return Stack(
          children: [
            // 固定网格背景层
            Positioned.fill(child: _buildFixedGrid(chartTheme)),
            // K线图层
            SfCartesianChart(
              backgroundColor: Colors.transparent,
              plotAreaBorderWidth: 0,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),

              // —— 我们用这些回调实现"单击固定/再次单击隐藏；长按跟随，松开固定"
              onChartTouchInteractionDown: _onDown,
              onChartTouchInteractionMove: _onMove,
              onChartTouchInteractionUp: _onUp,

              // 行为
              primaryXAxis: _priceXAxis,
              primaryYAxis: dynamicYAxis,
              zoomPanBehavior: _priceZoom,
              trackballBehavior: _trackballBehavior,
              crosshairBehavior: _crosshairBehavior,

              // 同步回调
              onZooming: _onPriceZooming,
              onActualRangeChanged: (ActualRangeChangedArgs args) {
                // 范围变化时更新标签位置（缩放、平移、数据更新等）
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _updateLatestPixel();
                });
              },

              // Candle
              series: <CartesianSeries>[
                CandleSeries<KLineEntity, DateTime>(
                  dataSource: widget.data,
                  xValueMapper: (d, _) =>
                      DateTime.fromMillisecondsSinceEpoch(d.time ?? 0),
                  lowValueMapper: (d, _) => d.low,
                  highValueMapper: (d, _) => d.high,
                  openValueMapper: (d, _) => d.open,
                  closeValueMapper: (d, _) => d.close,
                  bearColor: chartTheme.bearColor,
                  bullColor: chartTheme.bullColor,
                  enableSolidCandles: true, // 启用实心蜡烛
                  enableTooltip: false,
                  animationDuration: _animMs,
                  spacing: 0.01,
                  width: 0.9,
                  onRendererCreated: (ChartSeriesController controller) {
                    _seriesController = controller;
                    // 初始化时更新一次像素位置
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _updateLatestPixel();
                    });
                  },
                ),
              ],
              tooltipBehavior: TooltipBehavior(enable: false),
            ),
          ],
        );
      },
    );
  }

  Widget _buildVolumeChart(ChartTheme chartTheme) {
    return Stack(
      children: [
        // 固定网格背景层（只有横线，没有竖线）
        Positioned.fill(child: _buildFixedGridHorizontalOnly(chartTheme)),
        // 成交量图层
        SfCartesianChart(
          backgroundColor: Colors.transparent,
          plotAreaBorderWidth: 0,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          primaryXAxis: _volXAxis,
          primaryYAxis: const NumericAxis(
            isVisible: false,
            opposedPosition: true,
            majorGridLines: MajorGridLines(width: 0),
            axisLine: AxisLine(width: 0),
          ),
          zoomPanBehavior: _volZoom,
          onZooming: _onVolZooming,
          series: <CartesianSeries>[
            ColumnSeries<KLineEntity, DateTime>(
              dataSource: widget.data,
              xValueMapper: (d, _) =>
                  DateTime.fromMillisecondsSinceEpoch(d.time ?? 0),
              yValueMapper: (d, _) => d.vol * 6,
              pointColorMapper: (d, _) => d.close >= d.open
                  ? chartTheme.bullColor.withValues(alpha: 0.5)
                  : chartTheme.bearColor.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(2),
              spacing: 0.01,
              width: 0.9,
              animationDuration: _animMs,
            ),
          ],
        ),
      ],
    );
  }
}

// 固定网格绘制器
class _FixedGridPainter extends CustomPainter {
  final Color gridColor;
  final int horizontalLines; // 横线数量
  final int verticalLines; // 竖线数量

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

    // 绘制横线（水平）
    if (horizontalLines > 0) {
      for (int i = 0; i < horizontalLines; i++) {
        final y = (size.height / (horizontalLines - 1)) * i;
        canvas.drawLine(
          Offset(0, y),
          Offset(size.width, y),
          paint,
        );
      }
    }

    // 绘制竖线（垂直）
    if (verticalLines > 0) {
      for (int i = 0; i < verticalLines; i++) {
        final x = (size.width / (verticalLines - 1)) * i;
        canvas.drawLine(
          Offset(x, 0),
          Offset(x, size.height),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// 最新价格标签组件（浮动在图表右侧）
class _LatestPriceTag extends StatelessWidget {
  final double price;
  final Color color;

  const _LatestPriceTag({
    required this.price,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        price.toStringAsFixed(4),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
