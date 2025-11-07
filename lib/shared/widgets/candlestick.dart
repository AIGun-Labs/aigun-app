import 'dart:async';
import 'package:flutter/material.dart';
import 'package:k_chart/flutter_k_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class CandlestickChartWidget extends StatefulWidget {
  final List<KLineEntity> data;
  final String title;

  const CandlestickChartWidget({
    super.key,
    required this.data,
    this.title = 'BTC/USDT',
  });

  @override
  State<CandlestickChartWidget> createState() => _CandlestickChartWidgetState();
}

class _CandlestickChartWidgetState extends State<CandlestickChartWidget> {
  late ZoomPanBehavior _zoomPanBehavior;
  late TrackballBehavior _trackballBehavior;
  late CrosshairBehavior _crosshairBehavior;

  // 十字指针相关状态
  bool _isCrosshairVisible = false;
  KLineEntity? _selectedData;

  @override
  void initState() {
    super.initState();

    // Configure zoom and pan behavior
    // 禁用 enableSelectionZooming 避免长按时选中放大
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      enableDoubleTapZooming: true,
      enablePanning: true,
      enableSelectionZooming: false, // 禁用选中放大，避免与十字指针冲突
      enableMouseWheelZooming: true,
      zoomMode: ZoomMode.x,
    );

    // 使用 trackball 提供数据点定位
    _trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.longPress,
      tooltipDisplayMode: TrackballDisplayMode.none,
      shouldAlwaysShow: false,
      lineType: TrackballLineType.none, // 不显示线，只用于数据定位
      lineColor: Colors.transparent,
    );

    // 使用 crosshair 显示完整的十字线（横竖都有）
    _crosshairBehavior = CrosshairBehavior(
      enable: true,
      activationMode: ActivationMode.longPress,
      shouldAlwaysShow: false,
      lineType: CrosshairLineType.both, // 十字线
      lineColor: Colors.grey.withValues(alpha: 0.8),
      lineWidth: 2,
      lineDashArray: const [5, 5],
    );
  }

  // 防抖定时器
  Timer? _debounceTimer;

  // 处理 trackball 位置变化
  void _onTrackballPositionChanging(TrackballArgs args) {
    // 检查是否有有效的数据点信息
    final chartPointInfo = args.chartPointInfo;

    // 尝试获取数据点索引
    int? dataPointIndex;
    try {
      dataPointIndex = chartPointInfo.dataPointIndex;
    } catch (e) {
      dataPointIndex = null;
    }

    // 取消之前的定时器
    _debounceTimer?.cancel();

    // 使用防抖机制，减少闪动
    _debounceTimer = Timer(const Duration(milliseconds: 16), () {
      if (!mounted) return;

      if (dataPointIndex != null &&
          dataPointIndex >= 0 &&
          dataPointIndex < widget.data.length) {
        // Trackball 激活
        final newData = widget.data[dataPointIndex];

        if (!_isCrosshairVisible || newData != _selectedData) {
          setState(() {
            _isCrosshairVisible = true;
            _selectedData = newData;
          });
        }
      } else {
        // Trackball 隐藏
        if (_isCrosshairVisible) {
          setState(() {
            _isCrosshairVisible = false;
            _selectedData = null;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0D0D0D),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Chart Header
          // _buildChartHeader(),

          // Main Chart
          Expanded(
            flex: 3,
            child: Listener(
              behavior: HitTestBehavior.translucent,
              onPointerUp: (event) {
                // 手指离开屏幕时，延迟隐藏信息面板
                // 使用延迟避免与图表内部事件冲突
                Future.delayed(const Duration(milliseconds: 100), () {
                  if (mounted && _isCrosshairVisible) {
                    setState(() {
                      _isCrosshairVisible = false;
                      _selectedData = null;
                    });
                  }
                });
              },
              onPointerCancel: (event) {
                // 手势取消时也隐藏
                if (mounted && _isCrosshairVisible) {
                  setState(() {
                    _isCrosshairVisible = false;
                    _selectedData = null;
                  });
                }
              },
              child: Stack(
                children: [
                  _buildCandlestickChart(),
                  // 固定在左上角的信息面板（带淡入淡出动画）
                  AnimatedOpacity(
                    opacity: (_isCrosshairVisible && _selectedData != null)
                        ? 1.0
                        : 0.0,
                    duration: const Duration(milliseconds: 150),
                    child: _isCrosshairVisible && _selectedData != null
                        ? _buildCrosshairInfoPanel()
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),

          // Volume Chart
          Expanded(flex: 1, child: _buildVolumeChart()),
        ],
      ),
    );
  }

  Widget _buildChartHeader() {
    if (widget.data.isEmpty) return const SizedBox.shrink();

    final latestData = widget.data.last;
    final priceChange = latestData.close - widget.data.first.close;
    final priceChangePercent = (priceChange / widget.data.first.close) * 100;
    final isPositive = priceChange >= 0;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                '\$${latestData.close.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isPositive
                      ? Colors.green.withValues(alpha: 0.2)
                      : Colors.red.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${isPositive ? '+' : ''}${priceChangePercent.toStringAsFixed(2)}%',
                  style: TextStyle(
                    color: isPositive ? Colors.green : Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildStatItem('H', latestData.high, Colors.green),
              const SizedBox(width: 16),
              _buildStatItem('L', latestData.low, Colors.red),
              const SizedBox(width: 16),
              _buildStatItem('O', latestData.open, Colors.grey),
              const SizedBox(width: 16),
              _buildStatItem('C', latestData.close, Colors.grey),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, double value, Color color) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
        Text(
          '\$${value.toStringAsFixed(2)}',
          style: TextStyle(color: color, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildCandlestickChart() {
    return SfCartesianChart(
      backgroundColor: Colors.transparent,
      plotAreaBorderWidth: 0,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),

      // Enable zoom and pan
      zoomPanBehavior: _zoomPanBehavior,
      trackballBehavior: _trackballBehavior,
      crosshairBehavior: _crosshairBehavior,
      onTrackballPositionChanging: _onTrackballPositionChanging,
      onCrosshairPositionChanging: (CrosshairRenderArgs args) {
        // Crosshair 和 Trackball 联动
      },

      // Primary X Axis (DateTime)
      primaryXAxis: DateTimeAxis(
        majorGridLines: MajorGridLines(
          color: Colors.grey.withValues(alpha: 0.1),
          width: 1,
        ),
        axisLine: const AxisLine(width: 0),
        labelStyle: const TextStyle(color: Colors.grey, fontSize: 10),
        dateFormat: DateFormat('MM/dd HH:mm'),
        intervalType: DateTimeIntervalType.auto,
      ),

      // Primary Y Axis (Price)
      primaryYAxis: NumericAxis(
        opposedPosition: true,
        majorGridLines: MajorGridLines(
          color: Colors.grey.withValues(alpha: 0.1),
          width: 1,
        ),
        axisLine: const AxisLine(width: 0),
        labelStyle: const TextStyle(color: Colors.grey, fontSize: 10),
        numberFormat: NumberFormat.currency(symbol: '\$', decimalDigits: 2),
      ),

      // Candlestick Series
      series: <CartesianSeries>[
        CandleSeries<KLineEntity, DateTime>(
          dataSource: widget.data,
          xValueMapper: (KLineEntity data, _) =>
              DateTime.fromMillisecondsSinceEpoch(data.time ?? 0),
          lowValueMapper: (KLineEntity data, _) => data.low,
          highValueMapper: (KLineEntity data, _) => data.high,
          openValueMapper: (KLineEntity data, _) => data.open,
          closeValueMapper: (KLineEntity data, _) => data.close,

          // Styling
          bearColor: const Color(0xFFEF5350), // Red for bearish
          bullColor: const Color(0xFF26A69A), // Green for bullish
          // 禁用 series tooltip，只使用左上角固定面板
          enableTooltip: false,

          // Smooth rendering
          animationDuration: 1000,
        ),
      ],

      // 禁用 tooltip behavior
      tooltipBehavior: TooltipBehavior(
        enable: false,
      ),
    );
  }

  Widget _buildVolumeChart() {
    return SfCartesianChart(
      backgroundColor: Colors.transparent,
      plotAreaBorderWidth: 0,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),

      // Primary X Axis (DateTime)
      primaryXAxis: DateTimeAxis(isVisible: false),

      // Primary Y Axis (Volume)
      primaryYAxis: NumericAxis(
        opposedPosition: true,
        majorGridLines: const MajorGridLines(width: 0),
        axisLine: const AxisLine(width: 0),
        labelStyle: const TextStyle(color: Colors.grey, fontSize: 10),
        numberFormat: NumberFormat.compact(),
      ),

      // Volume Series
      series: <CartesianSeries>[
        ColumnSeries<KLineEntity, DateTime>(
          dataSource: widget.data,
          xValueMapper: (KLineEntity data, _) =>
              DateTime.fromMillisecondsSinceEpoch(data.time ?? 0),
          yValueMapper: (KLineEntity data, _) => data.vol,

          // Color based on bullish/bearish
          pointColorMapper: (KLineEntity data, _) => data.isBullish
              ? const Color(0xFF26A69A).withValues(alpha: 0.5)
              : const Color(0xFFEF5350).withValues(alpha: 0.5),

          borderRadius: BorderRadius.circular(2),
          spacing: 0.1,
        ),
      ],
    );
  }

  // 构建固定在左上角的信息面板
  Widget _buildCrosshairInfoPanel() {
    if (_selectedData == null) return const SizedBox.shrink();

    final dateFormat = DateFormat('MM/dd HH:mm');
    final isPositive = _selectedData!.close >= _selectedData!.open;
    final change = _selectedData!.close - _selectedData!.open;
    final changePercent = (change / _selectedData!.open) * 100;

    return Positioned(
      top: 6,
      left: 6,
      child: IgnorePointer(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E).withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(3),
            border: Border.all(
                color: Colors.grey.withValues(alpha: 0.2), width: 0.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // 时间
              Text(
                dateFormat.format(DateTime.fromMillisecondsSinceEpoch(
                    _selectedData!.time ?? 0)),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 3),

              // OHLC 数据
              _buildInfoRow('O', _selectedData!.open, Colors.grey),
              _buildInfoRow('H', _selectedData!.high, Colors.green),
              _buildInfoRow('L', _selectedData!.low, Colors.red),
              _buildInfoRow('C', _selectedData!.close,
                  isPositive ? Colors.green : Colors.red),

              // 涨跌幅
              const SizedBox(height: 2),
              Container(
                height: 0.5,
                width: 80,
                color: Colors.grey.withValues(alpha: 0.3),
              ),
              const SizedBox(height: 2),

              Text(
                '${isPositive ? '+' : ''}${changePercent.toStringAsFixed(2)}%',
                style: TextStyle(
                  color: isPositive ? Colors.green : Colors.red,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 构建信息行
  Widget _buildInfoRow(String label, double value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 1),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label ',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 8,
            ),
          ),
          Text(
            '\$${value.toStringAsFixed(2)}',
            style: TextStyle(
              color: color,
              fontSize: 8,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
