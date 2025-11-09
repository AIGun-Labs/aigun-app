import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/core/enums/timeframe.dart';
import 'package:flutter_aigun/themes/chart.dart';
import 'package:flutter_aigun/utils/format/currency.dart';
import 'package:flutter_aigun/utils/logger.dart';
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
  // —— 缩放限制
  static const double _minXFactor = 0.01;
  static const double _maxXFactor = 0.8; // 最大缩小度 - 缩小到显示100%的数据

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
    // X 轴 — 主图
    _priceXAxis = DateTimeAxis(
      name: 'x',
      isVisible: true,
      dateFormat: DateFormat(widget.timeframe.dateFormat),
      intervalType: DateTimeIntervalType.auto,
      labelStyle: TextStyle(
        color: Colors.transparent,
        fontSize: 10,
      ),
      // 添加主网格线（横线）
      majorGridLines: MajorGridLines(
        width: 0.5,
        color: chartTheme.gridColor,
      ),
      // 添加辅网格线（横线，更细、更淡）
      minorGridLines: MinorGridLines(
        width: 0.25,
        color: chartTheme.gridColor.withValues(alpha: 0.5),
      ),
      axisLine: const AxisLine(width: 0),
      majorTickLines: const MajorTickLines(width: 0),
      minorTickLines: const MinorTickLines(width: 0),
      rangePadding: ChartRangePadding.auto,
      enableAutoIntervalOnZooming: true, // <— 关键：缩放后刻度自动调整
      labelIntersectAction: AxisLabelIntersectAction.hide,
    );

    // X 轴 — 成交量图（如下部）
    _volXAxis = DateTimeAxis(
      name: 'vol_x',
      isVisible: true,
      dateFormat: DateFormat(widget.timeframe.dateFormat),
      intervalType: DateTimeIntervalType.auto,
      enableAutoIntervalOnZooming: true,
      majorGridLines: MajorGridLines(
        width: 0.5,
        color: chartTheme.gridColor,
      ),
      minorGridLines: MinorGridLines(
        width: 0.25,
        color: chartTheme.gridColor.withOpacity(0.5),
      ),
      majorTickLines: const MajorTickLines(width: 0, size: 0),
      axisLine: const AxisLine(width: 0),
      labelStyle: TextStyle(
        color: chartTheme.secondaryTextColor,
        fontSize: 10,
      ),
      labelIntersectAction: AxisLabelIntersectAction.hide,
      maximumLabels: 6,
      rangePadding: ChartRangePadding.additional,
    );

    // Y 轴 — 价格
    _priceYAxis = NumericAxis(
      opposedPosition: true,
      enableAutoIntervalOnZooming: true,
      // 添加主网格线（横线）
      majorGridLines: MajorGridLines(
        width: 0.5,
        color: chartTheme.gridColor,
      ),
      // 添加辅网格线（横线，更细、更淡）
      minorGridLines: MinorGridLines(
        width: 0.25,
        color: chartTheme.gridColor.withValues(alpha: 0.5),
      ),
      axisLine: const AxisLine(width: 0),
      majorTickLines: const MajorTickLines(width: 0),
      minorTickLines: const MinorTickLines(width: 0),
      labelStyle: TextStyle(
        color: chartTheme.secondaryTextColor,
        fontSize: 10,
      ),
      numberFormat: NumberFormat.currency(symbol: '\$', decimalDigits: 4),
      decimalPlaces: 4,
      rangePadding: ChartRangePadding.auto,
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

    double factor;
    if (len <= 5) {
      // 数据条数太少时，避免拉满整个视图
      // 使用固定的缩放比例，让图表保持合适的密度
      factor = 0.5; // 可以调整为 0.3 ~ 0.7
    } else {
      factor = (lastN / len).clamp(0.0, 1.0); // 初始缩放比例
    }

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

  int _calcPaddingCount() {
    const int maxPad = 10; // 你原来写的 10，可以自己调
    // 根据当前缩放算要补的个数
    int count = (maxPad * _currentZoomFactor).round();
    // 至少 1，最多 10
    if (count < 1) count = 1;
    if (count > maxPad) count = maxPad;
    return count;
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

    final factor =
        args.currentZoomFactor.clamp(_minXFactor, _maxXFactor).toDouble();
    final position =
        args.currentZoomPosition.clamp(0.0, 1.0 - factor).toDouble();

    _currentZoomFactor = factor; // 👈 记录缩放
    _currentZoomPosition = position;

    // 同步到成交量
    _volZoom.zoomToSingleAxis(_volXAxis, position, factor);

    _syncingFromPrice = false;

    // 👇 让 build 再跑一次，这样下面 appendEmptyTail 能拿到新的缩放
    setState(() {});
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

  // 根据时间周期计算时间步长（毫秒）
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

    // 根据周期计算空白条数：例如：
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

    // 也可以根据 _currentZoomFactor 调整：越放大，空白少；越缩小，空白多
    int emptyCount = baseEmpty + (_currentZoomFactor * 10).round();

    for (int i = 1; i <= emptyCount; i++) {
      final tailTime = (last.time ?? 0) + stepMs * i;
      out.add(KLineEntity.fromCustom(
        time: tailTime,
        open: 0,
        close: 0,
        high: 0,
        low: 0,
        vol: 0,
      ));
    }

    return out;
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

  Widget _buildCandlestickChart(ChartTheme chartTheme) {
    // 动态 Y 轴那段你原来的逻辑……
    NumericAxis dynamicYAxis = _priceYAxis;
    final last = widget.data.isNotEmpty ? widget.data.last : null;
    final lastPrice = last?.close;
    final paddedData = _appendEmptyTail(widget.data, widget.timeframe);

    if (paddedData.isNotEmpty) {
      final allPrices = widget.data.expand((d) => [d.high, d.low]).toList();
      if (allPrices.isNotEmpty) {
        final minPrice = allPrices.reduce((a, b) => a < b ? a : b);
        final maxPrice = allPrices.reduce((a, b) => a > b ? a : b);
        final range = maxPrice - minPrice;
        final padding = range * 0.1;
        final decimalPlaces = maxPrice < 0.01 ? 4 : (maxPrice < 1 ? 4 : 2);

        dynamicYAxis = NumericAxis(
          labelPosition: ChartDataLabelPosition.inside,
          opposedPosition: true,
          axisLine: const AxisLine(width: 0),

          majorGridLines: MajorGridLines(
            width: 0.5,
            color: chartTheme.gridColor,
          ),
          // 添加辅网格线（横线，更细、更淡）
          minorGridLines: MinorGridLines(
            width: 0.25,
            color: chartTheme.gridColor.withValues(alpha: 0.5),
          ),
          majorTickLines: const MajorTickLines(width: 0), // 隐藏主刻度线
          minorTickLines: const MinorTickLines(width: 0), // 隐藏辅刻度线
          labelStyle:
              TextStyle(color: chartTheme.secondaryTextColor, fontSize: 10),
          numberFormat:
              NumberFormat.currency(symbol: '', decimalDigits: decimalPlaces),
          decimalPlaces: decimalPlaces,
          rangePadding: ChartRangePadding.auto,
        );

        _visibleMinY = minPrice - padding;
        _visibleMaxY = maxPrice + padding;
      }
    }

    const double tagHeight = 24;
    final lastEntity = widget.data.last;
    final lastTimeMs = lastEntity.time ?? 0;
    final extendTimeMs = lastTimeMs + 60 * 1000; // 比最后时间多 1 分钟，或你自己设个值

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
              dataSource: paddedData,
              xValueMapper: (d, _) =>
                  DateTime.fromMillisecondsSinceEpoch(d.time ?? 0),
              lowValueMapper: (d, _) => _isPaddingPoint(d) ? null : d.low,
              highValueMapper: (d, _) => _isPaddingPoint(d) ? null : d.high,
              openValueMapper: (d, _) => _isPaddingPoint(d) ? null : d.open,
              closeValueMapper: (d, _) => _isPaddingPoint(d) ? null : d.close,
              bearColor: chartTheme.bearColor,
              bullColor: chartTheme.bullColor,
              emptyPointSettings:
                  const EmptyPointSettings(mode: EmptyPointMode.gap),
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

            // 在 series 集合中添加：

            LineSeries<KLineEntity, DateTime>(
              animationDuration: _animMs,
              dataSource: <KLineEntity>[
                // 起点：在最后一个实际数据点
                KLineEntity.fromCustom(
                  time: lastTimeMs,
                  open: lastEntity.close,
                  high: lastEntity.close,
                  low: lastEntity.close,
                  close: lastEntity.close,
                  vol: 0,
                ),
                // 终点：稍后时间，以保线向右延伸
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
              color: lastEntity.isBull
                  ? chartTheme.bullColor
                  : chartTheme.bearColor,
              width: 1,
              dashArray: <double>[6, 4],
            ),
          ],
        );

        return Stack(
          children: [
            // Positioned.fill(child: _buildFixedGrid(chartTheme)),
            Positioned.fill(child: chart),
            if (_latestPointPixel != null && widget.data.isNotEmpty) ...[
              Positioned(
                right: 4,
                top: (_latestPointPixel!.dy - tagHeight / 2)
                    .clamp(0.0, constraints.maxHeight - tagHeight),
                child: Container(
                  height: tagHeight,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: widget.data.last.isBull
                        ? chartTheme.bullColor
                        : chartTheme.bearColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    CurrencyFormatter.abbreviateTokenPrice(
                        widget.data.last.close),
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
    // 1. 原始有成交量的时间戳（不要用 padded 的，否则会多出来）
    final int stepMs = _getTimeframeStepMs(widget.timeframe);
    final Set<int> timeHasVolume = {
      for (final d in widget.data)
        if ((d.time ?? 0) > 0 && d.vol > 0) d.time!,
    };

    // 2. 还是要补尾巴，让图腾到右边
    final paddedData = _appendEmptyTail(widget.data, widget.timeframe);

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
          final String labelText = details.text ?? '';
          if (labelText.isEmpty) {
            return ChartAxisLabel('', TextStyle(fontSize: 0));
          }

          // 1) 解析 labelText 成 DateTime
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
              TextStyle(color: chartTheme.secondaryTextColor, fontSize: 10),
            );
          }

          // 2) 转为毫秒、对齐周期
          final int ts = dt.millisecondsSinceEpoch;
          final int cycleMs = widget.timeframe.duration.inMinutes * 60 * 1000;
          final int alignedTs = (ts ~/ cycleMs) * cycleMs;

          // 3) 找出最近的有量时间戳差距
          int minDiff = cycleMs * 10; // 初始设得比较大
          for (final t in timeHasVolume) {
            final diff = (t - alignedTs).abs();
            if (diff < minDiff) {
              minDiff = diff;
            }
          }

          // 4) 判断是否“有量”——差距必须非常小
          const int allowedDiff = 5000; // 5秒以内算“匹配”
          if (minDiff > allowedDiff) {
            return ChartAxisLabel('', TextStyle(fontSize: 0));
          }

          // 5) 显示刻度
          return ChartAxisLabel(
            labelText,
            TextStyle(color: chartTheme.secondaryTextColor, fontSize: 10),
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
          yValueMapper: (d, _) => d.vol, // 你原来乘 6 就自己加
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

// 判断一根是不是你补的“尾巴”
// 你现在补尾巴的时候是全 0，所以这样判断就行
  bool _isPaddingPoint(KLineEntity d) {
    return (d.open == 0 &&
        d.high == 0 &&
        d.low == 0 &&
        d.close == 0 &&
        d.vol == 0);
  }
}

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

    // 横线：不画最上面和最下面
    if (horizontalLines > 0) {
      for (int i = 0; i < horizontalLines; i++) {
        // 跳过第一条(顶部)和最后一条(底部)
        if (i == 0 || i == horizontalLines - 1) continue;

        final y = (size.height / (horizontalLines - 1)) * i;
        canvas.drawLine(
          Offset(0, y),
          Offset(size.width, y),
          paint,
        );
      }
    }

    // 竖线保持不变
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
