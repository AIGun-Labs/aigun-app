import 'package:financial_chart/financial_chart.dart';
import 'package:flutter/material.dart';
import 'package:k_chart/entity/index.dart';

/// OKX 风格的 K 线图组件
///
/// 特点：
/// - 深色主题
/// - 主图显示蜡烛图和移动平均线（MA5、MA10、MA20）
/// - 底部显示成交量柱状图
/// - 支持十字准线和 Tooltip
/// - 专业的配色方案（OKX 绿涨红跌）
class OKXStyleChart extends StatefulWidget {
  /// K 线数据列表
  final List<KLineEntity> candles;

  /// 时间周期（用于计算移动平均线等）
  final String timeframe;

  /// 是否显示加载状态
  final bool isLoading;

  const OKXStyleChart({
    super.key,
    required this.candles,
    this.timeframe = '15m',
    this.isLoading = false,
  });

  @override
  State<OKXStyleChart> createState() => _OKXStyleChartState();
}

class _OKXStyleChartState extends State<OKXStyleChart>
    with TickerProviderStateMixin {
  GChart? _chart;

  @override
  void initState() {
    super.initState();
    _buildChart();
  }

  @override
  void didUpdateWidget(OKXStyleChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.candles != widget.candles) {
      _buildChart();
    }
  }

  @override
  void dispose() {
    _chart?.dispose();
    super.dispose();
  }

  /// 构建图表
  void _buildChart() {
    if (widget.candles.isEmpty) {
      setState(() {
        _chart = null;
      });
      return;
    }

    // 转换数据并计算技术指标
    final dataSource = _convertToDataSource(widget.candles);

    setState(() {
      _chart = GChart(
        dataSource: dataSource,
        theme: _buildOKXTheme(),
        pointViewPort: GPointViewPort(
          autoScaleStrategy: const GPointViewPortAutoScaleStrategyLatest(),
        ),
        crosshair: GCrosshair(),
        panels: [
          // 主图面板（K线 + MA）
          _buildMainPanel(dataSource),
          // 成交量面板
          _buildVolumePanel(dataSource),
        ],
      );
    });
  }

  /// 转换数据源
  GDataSource<int, GData<int>> _convertToDataSource(List<KLineEntity> candles) {
    // 计算移动平均线
    final ma5List = _calculateMA(candles, 5);
    final ma10List = _calculateMA(candles, 10);
    final ma20List = _calculateMA(candles, 20);

    final dataList = <GData<int>>[];
    for (int i = 0; i < candles.length; i++) {
      final candle = candles[i];
      dataList.add(GData<int>(
        pointValue: candle.time ?? 0,
        seriesValues: [
          candle.open,
          candle.high,
          candle.low,
          candle.close,
          candle.vol,
          ma5List[i],
          ma10List[i],
          ma20List[i],
        ],
      ));
    }

    return GDataSource<int, GData<int>>(
      dataList: dataList,
      seriesProperties: const [
        GDataSeriesProperty(key: 'open', label: 'O', precision: 2),
        GDataSeriesProperty(key: 'high', label: 'H', precision: 2),
        GDataSeriesProperty(key: 'low', label: 'L', precision: 2),
        GDataSeriesProperty(key: 'close', label: 'C', precision: 2),
        GDataSeriesProperty(key: 'volume', label: 'Vol', precision: 2),
        GDataSeriesProperty(key: 'ma5', label: 'MA5', precision: 2),
        GDataSeriesProperty(key: 'ma10', label: 'MA10', precision: 2),
        GDataSeriesProperty(key: 'ma20', label: 'MA20', precision: 2),
      ],
      pointValueFormater: (point, pointValue) {
        // 格式化时间显示
        final date = DateTime.fromMillisecondsSinceEpoch(pointValue);
        return '${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
      },
    );
  }

  /// 计算移动平均线
  List<double> _calculateMA(List<KLineEntity> candles, int period) {
    final result = List<double>.filled(candles.length, 0.0);

    for (int i = 0; i < candles.length; i++) {
      if (i < period - 1) {
        result[i] = 0.0; // 数据不足时设为0
        continue;
      }

      double sum = 0;
      for (int j = 0; j < period; j++) {
        sum += candles[i - j].close;
      }
      result[i] = sum / period;
    }

    return result;
  }

  /// 构建主图面板
  GPanel _buildMainPanel(GDataSource dataSource) {
    return GPanel(
      valueViewPorts: [
        GValueViewPort(
          valuePrecision: 2,
          autoScaleStrategy: GValueViewPortAutoScaleStrategyMinMax(
            dataKeys: const ["high", "low"],
            marginStart: GSize.viewHeightRatio(0.25), // 为成交量留出空间
            marginEnd: GSize.viewHeightRatio(0.05),
          ),
        ),
      ],
      valueAxes: [
        GValueAxis(
          position: GAxisPosition.end, // 价格轴在右侧
        ),
      ],
      pointAxes: [
        GPointAxis(
          position: GAxisPosition.end, // 时间轴在底部
        ),
      ],
      graphs: [
        // 网格线
        GGraphGrids(),
        // K线图
        GGraphOhlc(
          ohlcValueKeys: const ["open", "high", "low", "close"],
          drawAsCandle: true,
        ),
        // MA5 线
        GGraphLine(
          valueKey: "ma5",
          layer: 1,
          overlayMarkers: [
            // MA5 标签
            GLabelMarker(
              text: "MA5",
              anchorCoord: GPositionCoord.absolute(x: 10, y: 5),
              alignment: Alignment.topLeft,
              hitTestMode: GHitTestMode.none,
            ),
          ],
        ),
        // MA10 线
        GGraphLine(
          valueKey: "ma10",
          layer: 1,
          overlayMarkers: [
            // MA10 标签
            GLabelMarker(
              text: "MA10",
              anchorCoord: GPositionCoord.absolute(x: 60, y: 5),
              alignment: Alignment.topLeft,
              hitTestMode: GHitTestMode.none,
            ),
          ],
        ),
        // MA20 线
        GGraphLine(
          valueKey: "ma20",
          layer: 1,
          overlayMarkers: [
            // MA20 标签
            GLabelMarker(
              text: "MA20",
              anchorCoord: GPositionCoord.absolute(x: 115, y: 5),
              alignment: Alignment.topLeft,
              hitTestMode: GHitTestMode.none,
            ),
          ],
        ),
      ],
      tooltip: GTooltip(
        position: GTooltipPosition.followPointer,
        followValueKey: "close",
        dataKeys: const [
          "open",
          "high",
          "low",
          "close",
          "ma5",
          "ma10",
          "ma20",
        ],
      ),
      heightWeight: 0.7, // 主图占70%高度
    );
  }

  /// 构建成交量面板
  GPanel _buildVolumePanel(GDataSource dataSource) {
    return GPanel(
      valueViewPorts: [
        GValueViewPort(
          id: "volumeViewPort",
          valuePrecision: 0,
          autoScaleStrategy: GValueViewPortAutoScaleStrategyMinMax(
            dataKeys: const ["volume"],
            marginEnd: GSize.viewHeightRatio(0.1),
          ),
        ),
      ],
      valueAxes: [
        GValueAxis(
          id: "volumeAxis",
          viewPortId: "volumeViewPort",
          position: GAxisPosition.end,
          scaleMode: GAxisScaleMode.none, // 禁用拖拽缩放
        ),
      ],
      pointAxes: [
        GPointAxis(
          position: GAxisPosition.end,
        ),
      ],
      graphs: [
        // 网格线
        GGraphGrids(),
        // 成交量柱状图
        GGraphBar(
          valueKey: "volume",
          valueViewPortId: "volumeViewPort",
          overlayMarkers: [
            // VOL 标签
            GLabelMarker(
              text: "VOL",
              anchorCoord: GPositionCoord.absolute(x: 10, y: 5),
              alignment: Alignment.topLeft,
              hitTestMode: GHitTestMode.none,
            ),
          ],
        ),
      ],
      tooltip: GTooltip(
        position: GTooltipPosition.followPointer,
        followValueKey: "volume",
        followValueViewPortId: "volumeViewPort",
        dataKeys: const ["volume"],
      ),
      heightWeight: 0.3, // 成交量占30%高度
      resizable: true,
    );
  }

  /// 构建 OKX 深色主题
  GTheme _buildOKXTheme() {
    // OKX 配色
    const Color okxGreen = Color(0xFF02C076); // 涨（绿色）
    const Color okxRed = Color(0xFFED4264); // 跌（红色）
    const Color okxBackground = Color(0xFF0B0E11); // 背景色
    const Color okxGridLine = Color(0xFF1C2127); // 网格线
    const Color okxTextSecondary = Color(0xFF8B949E); // 次要文本
    const Color okxTextPrimary = Color(0xFFE5E7EB); // 主要文本
    const Color okxMA5 = Color(0xFFE0B340); // MA5 黄色
    const Color okxMA10 = Color(0xFF5B8FF9); // MA10 蓝色
    const Color okxMA20 = Color(0xFFD946EF); // MA20 紫色
    const Color okxCrosshair = Color(0xFF4A5568); // 十字准线

    return GTheme(
      name: 'OKX Dark',
      backgroundTheme: GBackgroundTheme(
        style: PaintStyle(fillColor: okxBackground),
      ),
      panelTheme: GPanelTheme(
        style: PaintStyle(
          fillColor: okxBackground,
          strokeColor: okxGridLine,
          strokeWidth: 0,
        ),
      ),
      pointAxisTheme: GAxisTheme(
        lineStyle: PaintStyle(
          strokeColor: okxGridLine,
          strokeWidth: 1.0,
        ),
        tickerLength: 5.0,
        tickerStyle: PaintStyle(
          strokeColor: okxTextSecondary,
          strokeWidth: 1.0,
        ),
        selectionStyle: PaintStyle(
          fillColor: okxCrosshair.withValues(alpha: 0.3),
          strokeColor: okxCrosshair,
          strokeWidth: 1.0,
        ),
        labelTheme: GAxisLabelTheme(
          labelStyle: LabelStyle(
            textStyle: const TextStyle(
              color: okxTextSecondary,
              fontSize: 10.0,
            ),
            backgroundStyle: PaintStyle(),
            backgroundPadding: const EdgeInsets.all(2),
            backgroundCornerRadius: 2,
          ),
        ),
      ),
      valueAxisTheme: GAxisTheme(
        lineStyle: PaintStyle(
          strokeColor: okxGridLine,
          strokeWidth: 1.0,
        ),
        tickerLength: 5.0,
        tickerStyle: PaintStyle(
          strokeColor: okxTextSecondary,
          strokeWidth: 1.0,
        ),
        selectionStyle: PaintStyle(
          fillColor: okxCrosshair.withValues(alpha: 0.3),
          strokeColor: okxCrosshair,
        ),
        labelTheme: GAxisLabelTheme(
          labelStyle: LabelStyle(
            textStyle: const TextStyle(
              color: okxTextSecondary,
              fontSize: 10.0,
            ),
            backgroundStyle: PaintStyle(),
            backgroundPadding: const EdgeInsets.all(2),
            backgroundCornerRadius: 2,
          ),
        ),
      ),
      crosshairTheme: GCrosshairTheme(
        lineStyle: PaintStyle(
          strokeColor: okxCrosshair,
          strokeWidth: 1,
          dash: const [4, 4],
        ),
        pointLabelTheme: GAxisLabelTheme(
          labelStyle: LabelStyle(
            textStyle: const TextStyle(
              color: okxTextPrimary,
              fontSize: 10.0,
            ),
            backgroundStyle: PaintStyle(fillColor: okxCrosshair),
            backgroundPadding: const EdgeInsets.all(2),
            backgroundCornerRadius: 2,
          ),
        ),
        valueLabelTheme: GAxisLabelTheme(
          labelStyle: LabelStyle(
            textStyle: const TextStyle(
              color: okxTextPrimary,
              fontSize: 10.0,
            ),
            backgroundStyle: PaintStyle(fillColor: okxCrosshair),
            backgroundPadding: const EdgeInsets.all(2),
            backgroundCornerRadius: 2,
          ),
        ),
      ),
      tooltipTheme: GTooltipTheme(
        frameStyle: PaintStyle(
          fillColor: const Color(0xFF1A1D22).withValues(alpha: 0.95),
          strokeColor: okxCrosshair,
          strokeWidth: 1,
        ),
        pointStyle: LabelStyle(
          textStyle: const TextStyle(
            color: okxTextPrimary,
            fontSize: 11.0,
          ),
        ),
        labelStyle: LabelStyle(
          textStyle: const TextStyle(
            color: okxTextSecondary,
            fontSize: 11.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        valueStyle: LabelStyle(
          textStyle: const TextStyle(
            color: okxTextPrimary,
            fontSize: 11.0,
          ),
        ),
        pointHighlightStyle: PaintStyle(
          fillColor: okxCrosshair.withValues(alpha: 0.3),
        ),
        valueHighlightStyle: PaintStyle(
          strokeColor: okxCrosshair,
          strokeWidth: 0.5,
        ),
      ),
      splitterTheme: GSplitterTheme(
        lineStyle: PaintStyle(
          strokeColor: okxGridLine,
          strokeWidth: 4,
        ),
        handleStyle: PaintStyle(
          fillColor: okxTextSecondary,
          strokeColor: okxGridLine,
        ),
        handleLineStyle: PaintStyle(
          strokeColor: okxTextPrimary,
          strokeWidth: 0.5,
        ),
        handleWidth: 80,
        handleBorderRadius: 4,
      ),
      graphThemes: {
        GGraph.typeName: GGraphTheme(
          axisMarkerTheme: GAxisMarkerTheme(
            labelTheme: GAxisLabelTheme(
              labelStyle: LabelStyle(
                textStyle: const TextStyle(
                  color: okxTextPrimary,
                  fontSize: 10.0,
                ),
                backgroundStyle: PaintStyle(fillColor: okxCrosshair),
                backgroundPadding: const EdgeInsets.all(2),
                backgroundCornerRadius: 2,
              ),
            ),
            rangeStyle: PaintStyle(
              fillColor: okxCrosshair.withValues(alpha: 0.3),
            ),
          ),
          overlayMarkerTheme: GOverlayMarkerTheme(
            markerStyle: PaintStyle(
              fillColor: okxGreen.withValues(alpha: 0.3),
              strokeColor: okxGreen,
              strokeWidth: 2,
            ),
            controlHandleThemes: {},
            labelStyle: LabelStyle(
              textStyle: const TextStyle(
                color: okxTextPrimary,
                fontSize: 10.0,
                fontWeight: FontWeight.w500,
              ),
              backgroundStyle: PaintStyle(
                fillColor: okxBackground.withValues(alpha: 0.8),
              ),
              backgroundPadding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 3,
              ),
              backgroundCornerRadius: 3,
            ),
          ),
        ),
        GGraphGrids.typeName: GGraphGridsTheme(
          lineStyle: PaintStyle(
            strokeColor: okxGridLine,
            strokeWidth: 0.5,
          ),
          selectionStyle: PaintStyle(
            fillColor: okxCrosshair.withValues(alpha: 0.2),
            strokeColor: okxCrosshair,
          ),
          axisMarkerTheme: GAxisMarkerTheme(
            labelTheme: GAxisLabelTheme(
              labelStyle: LabelStyle(
                textStyle: const TextStyle(
                  color: okxTextPrimary,
                  fontSize: 10.0,
                ),
                backgroundStyle: PaintStyle(fillColor: okxCrosshair),
                backgroundPadding: const EdgeInsets.all(2),
                backgroundCornerRadius: 2,
              ),
            ),
            rangeStyle: PaintStyle(
              fillColor: okxCrosshair.withValues(alpha: 0.3),
            ),
          ),
          overlayMarkerTheme: GOverlayMarkerTheme(
            markerStyle: PaintStyle(
              fillColor: okxGreen.withValues(alpha: 0.3),
              strokeColor: okxGreen,
              strokeWidth: 2,
            ),
            controlHandleThemes: {},
            labelStyle: LabelStyle(
              textStyle: const TextStyle(
                color: okxTextPrimary,
                fontSize: 10.0,
              ),
              backgroundStyle: PaintStyle(),
            ),
          ),
          highlightMarkerTheme: GGraphHighlightMarkerTheme(
            style: PaintStyle(
              strokeColor: okxCrosshair,
              strokeWidth: 1,
              fillColor: okxTextPrimary,
            ),
            size: 4.0,
            interval: 100.0,
            crosshairHighlightSize: 4.0,
          ),
        ),
        GGraphOhlc.typeName: GGraphOhlcTheme(
          barStylePlus: PaintStyle(
            fillColor: okxGreen,
            strokeWidth: 1,
            strokeColor: okxGreen,
          ),
          barStyleMinus: PaintStyle(
            fillColor: okxRed,
            strokeWidth: 1,
            strokeColor: okxRed,
          ),
          axisMarkerTheme: GAxisMarkerTheme(
            labelTheme: GAxisLabelTheme(
              labelStyle: LabelStyle(
                textStyle: const TextStyle(
                  color: okxTextPrimary,
                  fontSize: 10.0,
                ),
                backgroundStyle: PaintStyle(fillColor: okxCrosshair),
                backgroundPadding: const EdgeInsets.all(2),
                backgroundCornerRadius: 2,
              ),
            ),
            rangeStyle: PaintStyle(
              fillColor: okxCrosshair.withValues(alpha: 0.3),
            ),
          ),
          highlightMarkerTheme: GGraphHighlightMarkerTheme(
            style: PaintStyle(
              strokeColor: okxCrosshair,
              strokeWidth: 1,
              fillColor: okxTextPrimary,
            ),
            size: 4.0,
            interval: 100.0,
            crosshairHighlightSize: 4.0,
          ),
        ),
        GGraphLine.typeName: GGraphLineTheme(
          lineStyle: PaintStyle(
            strokeColor: okxMA5,
            strokeWidth: 1,
          ),
          pointStyle: PaintStyle(fillColor: okxMA5),
          axisMarkerTheme: GAxisMarkerTheme(
            labelTheme: GAxisLabelTheme(
              labelStyle: LabelStyle(
                textStyle: const TextStyle(
                  color: okxTextPrimary,
                  fontSize: 10.0,
                ),
                backgroundStyle: PaintStyle(fillColor: okxCrosshair),
                backgroundPadding: const EdgeInsets.all(2),
                backgroundCornerRadius: 2,
              ),
            ),
            rangeStyle: PaintStyle(
              fillColor: okxCrosshair.withValues(alpha: 0.3),
            ),
          ),
          highlightMarkerTheme: GGraphHighlightMarkerTheme(
            style: PaintStyle(
              strokeColor: okxCrosshair,
              strokeWidth: 1,
              fillColor: okxTextPrimary,
            ),
            size: 4.0,
            interval: 100.0,
            crosshairHighlightSize: 4.0,
          ),
        ),
        GGraphBar.typeName: GGraphBarTheme(
          barStyleAboveBase: PaintStyle(
            fillColor: okxGreen.withValues(alpha: 0.5),
          ),
          barStyleBelowBase: PaintStyle(
            fillColor: okxRed.withValues(alpha: 0.5),
          ),
          axisMarkerTheme: GAxisMarkerTheme(
            labelTheme: GAxisLabelTheme(
              labelStyle: LabelStyle(
                textStyle: const TextStyle(
                  color: okxTextPrimary,
                  fontSize: 10.0,
                ),
                backgroundStyle: PaintStyle(fillColor: okxCrosshair),
                backgroundPadding: const EdgeInsets.all(2),
                backgroundCornerRadius: 2,
              ),
            ),
            rangeStyle: PaintStyle(
              fillColor: okxCrosshair.withValues(alpha: 0.3),
            ),
          ),
          overlayMarkerTheme: GOverlayMarkerTheme(
            markerStyle: PaintStyle(
              fillColor: okxGreen.withValues(alpha: 0.3),
              strokeColor: okxGreen,
              strokeWidth: 2,
            ),
            controlHandleThemes: {},
            labelStyle: LabelStyle(
              textStyle: const TextStyle(
                color: okxTextPrimary,
                fontSize: 10.0,
              ),
              backgroundStyle: PaintStyle(),
            ),
          ),
          highlightMarkerTheme: GGraphHighlightMarkerTheme(
            style: PaintStyle(
              strokeColor: okxCrosshair,
              strokeWidth: 1,
              fillColor: okxTextPrimary,
            ),
            size: 4.0,
            interval: 100.0,
            crosshairHighlightSize: 4.0,
          ),
        ),
      },
      axisMarkerTheme: GAxisMarkerTheme(
        labelTheme: GAxisLabelTheme(
          labelStyle: LabelStyle(
            textStyle: const TextStyle(
              color: okxTextPrimary,
              fontSize: 10.0,
            ),
            backgroundStyle: PaintStyle(fillColor: okxCrosshair),
            backgroundPadding: const EdgeInsets.all(2),
            backgroundCornerRadius: 2,
          ),
        ),
        rangeStyle: PaintStyle(
          fillColor: okxCrosshair.withValues(alpha: 0.3),
        ),
      ),
      overlayMarkerTheme: GOverlayMarkerTheme(
        markerStyle: PaintStyle(
          fillColor: okxGreen.withValues(alpha: 0.3),
          strokeColor: okxGreen,
          strokeWidth: 2,
        ),
        controlHandleThemes: {},
        labelStyle: LabelStyle(
          textStyle: const TextStyle(
            color: okxTextPrimary,
            fontSize: 10.0,
            fontWeight: FontWeight.w500,
          ),
          backgroundStyle: PaintStyle(
            fillColor: okxBackground.withValues(alpha: 0.8),
          ),
          backgroundPadding: const EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 3,
          ),
          backgroundCornerRadius: 3,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading && widget.candles.isEmpty) {
      return Container(
        color: const Color(0xFF0B0E11),
        child: const Center(
          child: CircularProgressIndicator(
            color: Color(0xFF02C076),
          ),
        ),
      );
    }

    if (_chart == null) {
      return Container(
        color: const Color(0xFF0B0E11),
        child: const Center(
          child: Text(
            'No data available',
            style: TextStyle(color: Color(0xFF8B949E)),
          ),
        ),
      );
    }

    return Container(
      color: const Color(0xFF0B0E11),
      child: GChartWidget(
        chart: _chart!,
        tickerProvider: this,
      ),
    );
  }
}

/// K 线数据模型
///
/// 如果你已经有 KLineEntity，可以创建一个扩展方法来转换
class KLineData {
  final int time; // 时间戳（毫秒）
  final double open;
  final double high;
  final double low;
  final double close;
  final double volume;

  const KLineData({
    required this.time,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
  });

  /// 从你现有的 KLineEntity 转换
  /// 示例：
  /// factory KLineData.fromKLineEntity(KLineEntity entity) {
  ///   return KLineData(
  ///     time: entity.time ?? 0,
  ///     open: entity.open ?? 0,
  ///     high: entity.high ?? 0,
  ///     low: entity.low ?? 0,
  ///     close: entity.close ?? 0,
  ///     volume: entity.vol ?? 0,
  ///   );
  /// }
}
