import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/core/enums/timeframe.dart';
import 'package:flutter_aigun/themes/chart.dart';
import 'package:k_chart/flutter_k_chart.dart';
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
  // —— 最大放大度（最小可见窗口比例）
  static const double _minXFactor = 0.6;

  // —— 单击/长按判定阈值
  static const int _longPressMs = 350; // 长按判定时长
  static const double _tapMaxMove = 8.0; // 单击允许的最大位移
  static const int _tapMaxMs = 250; // 单击允许的最长时长

  // 缩放行为（主图 / 成交量图）
  late final ZoomPanBehavior _priceZoom;
  late final ZoomPanBehavior _volZoom;

  // X 轴（必须持有轴实例，便于编程式缩放）
  late final DateTimeAxis _priceXAxis;
  late final DateTimeAxis _volXAxis;
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

  void _initializeAxes(ChartTheme chartTheme) {
    // 初始化 X 轴，使用 widget.timeframe 的日期格式
    _priceXAxis = DateTimeAxis(
      name: 'x',
      isVisible: false,
      // 固定垂直网格线数量
      desiredIntervals: 5, // 显示6条竖线（5个间隔）
      majorGridLines: MajorGridLines(
        color: chartTheme.gridColor,
        width: 0.8,
      ),
      axisLine: const AxisLine(width: 0),
      labelStyle: TextStyle(color: chartTheme.secondaryTextColor, fontSize: 10),
      dateFormat: DateFormat(widget.timeframe.dateFormat),
      intervalType: DateTimeIntervalType.auto,
    );

    _volXAxis = DateTimeAxis(
      name: 'x',
      isVisible: true,
      dateFormat: DateFormat(widget.timeframe.dateFormat),
      intervalType: DateTimeIntervalType.auto,
      // 固定垂直网格线数量（与主图保持一致）
      desiredIntervals: 5, // 显示6条竖线（5个间隔）
      majorGridLines: MajorGridLines(
        color: chartTheme.gridColor,
        width: 0.8,
      ),
      minorGridLines: const MinorGridLines(width: 0),
      majorTickLines: const MajorTickLines(width: 0, size: 0),
      axisLine: const AxisLine(width: 0),
      labelStyle: TextStyle(color: chartTheme.secondaryTextColor, fontSize: 10),
    );

    _priceYAxis = NumericAxis(
      labelPosition: ChartDataLabelPosition.inside,
      opposedPosition: true,
      // 固定网格线数量：设置期望的间隔数（网格线数量 = desiredIntervals + 1）
      desiredIntervals: 4, // 显示5条横线（4个间隔）
      majorGridLines: MajorGridLines(
        width: 0.8,
        color: chartTheme.gridColor,
      ),
      // 禁用次要网格线，只保留主网格线
      minorGridLines: const MinorGridLines(width: 0),
      minorTicksPerInterval: 0,
      axisLine: const AxisLine(width: 0),
      majorTickLines: const MajorTickLines(width: 0), // 隐藏Y轴刻度线
      minorTickLines: const MinorTickLines(width: 0), // 隐藏Y轴次刻度线
      labelStyle: TextStyle(color: chartTheme.secondaryTextColor, fontSize: 10),
      numberFormat: NumberFormat.currency(symbol: '\$', decimalDigits: 2),
    );
  }

  @override
  void initState() {
    super.initState();

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

  // 计算 factor/position 并应用到两个图表
  void _applyInitialViewByLastN(int lastN) {
    if (widget.data.isEmpty) return;
    final int len = widget.data.length;
    final double factor = (lastN / len).clamp(0.0, 1.0); // 初始缩放比例
    final double position = (1.0 - factor).clamp(0.0, 1.0); // 把窗口贴到最右（最新）

    // 若你限制了最大放大度（_minXFactor），要确保初始 factor ≥ _minXFactor
    // 否则会被限制住看不到那么“窄”的窗口
    final double appliedFactor = factor.clamp(_minXFactor, 1.0);

    // 等第一帧布局完再调用（轴/行为就绪）
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _priceZoom.zoomToSingleAxis(_priceXAxis, position, appliedFactor);
      _volZoom.zoomToSingleAxis(_volXAxis, position, appliedFactor);
    });
  }

  @override
  void dispose() {
    _longPressTimer?.cancel();
    super.dispose();
  }

  // —— 缩放同步：主图 -> 成交量图（带“最大放大度”夹紧）
  void _onPriceZooming(ZoomPanArgs args) {
    if (_syncingFromVol) return;
    if (args.axis?.name != 'x') return;
    _syncingFromPrice = true;
    final factor = args.currentZoomFactor.clamp(_minXFactor, 1.0).toDouble();
    _volZoom.zoomToSingleAxis(_volXAxis, args.currentZoomPosition, factor);
    _syncingFromPrice = false;
  }

  // —— 缩放同步：成交量图 -> 主图（带“最大放大度”夹紧）
  void _onVolZooming(ZoomPanArgs args) {
    if (_syncingFromPrice) return;
    if (args.axis?.name != 'x') return;
    _syncingFromVol = true;
    final factor = args.currentZoomFactor.clamp(_minXFactor, 1.0).toDouble();
    _priceZoom.zoomToSingleAxis(_priceXAxis, args.currentZoomPosition, factor);
    _syncingFromVol = false;
  }

  // —— 程序化显示/隐藏（在像素坐标处）
  void _showAt(Offset p) {
    // 使用 'pixel' 参数指定坐标单位为像素
    _trackballBehavior.show(p.dx, p.dy, 'pixel');
    _crosshairBehavior.show(p.dx, p.dy, 'pixel');
    _isPinned = true;
  }

  void _hideAll() {
    _trackballBehavior.hide();
    _crosshairBehavior.hide();
    _isPinned = false;
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
      _applyInitialViewByLastN(20);
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

  Widget _buildCandlestickChart(ChartTheme chartTheme) {
    return SfCartesianChart(
      backgroundColor: Colors.transparent,
      plotAreaBorderWidth: 0,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),

      // —— 我们用这些回调实现"单击固定/再次单击隐藏；长按跟随，松开固定"
      onChartTouchInteractionDown: _onDown,
      onChartTouchInteractionMove: _onMove,
      onChartTouchInteractionUp: _onUp,
      // onChartTouchInteractionCancel: _onCancel,

      // 行为
      primaryXAxis: _priceXAxis,

      primaryYAxis: _priceYAxis,
      zoomPanBehavior: _priceZoom,
      trackballBehavior: _trackballBehavior,
      crosshairBehavior: _crosshairBehavior,

      // 同步回调
      onZooming: _onPriceZooming,

      // Candle
      series: <CartesianSeries>[
        CandleSeries<KLineEntity, DateTime>(
          dataSource: widget.data,
          xValueMapper: (d, _) =>
              DateTime.fromMillisecondsSinceEpoch((d.time! * 1000).toInt()),
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
        ),
      ],
      tooltipBehavior: TooltipBehavior(enable: false),
    );
  }

  Widget _buildVolumeChart(ChartTheme chartTheme) {
    return SfCartesianChart(
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
              DateTime.fromMillisecondsSinceEpoch((d.time! * 1000).toInt()),
          yValueMapper: (d, _) => d.vol,
          pointColorMapper: (d, _) => d.isBullish
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
}
