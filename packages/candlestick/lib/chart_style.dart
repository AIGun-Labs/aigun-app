import 'package:flutter/material.dart' show Color, EdgeInsets;

/// ChartColors
///
/// Note:
/// If you need to apply multi theme, you need to change at least the colors related to the text, border and background color
/// Ex:
/// Background: bgColor, selectFillColor
/// Border
/// Text
///
class ChartColors {
  /// the background color of base chart
  Color bgColor;

  Color kLineColor;

  ///
  Color lineFillColor;

  ///
  Color lineFillInsideColor;

  /// color: ma5, ma10, ma30, up, down, vol, macd, diff, dea, k, d, j, rsi
  Color ma5Color;
  Color ma10Color;
  Color ma30Color;
  Color upColor;
  Color dnColor;
  Color volColor;

  Color macdColor;
  Color difColor;
  Color deaColor;

  Color kColor;
  Color dColor;
  Color jColor;
  Color rsiColor;

  Color sarColor;
  Color avgColor;

  /// default text color: apply for text at grid
  Color defaultTextColor;

  /// color of the current price
  Color nowPriceUpColor;
  Color nowPriceDnColor;
  Color nowPriceTextColor;

  /// trend color
  Color trendLineColor;

  /// depth color
  Color depthBuyColor; //upColor
  Color depthBuyPathColor;
  Color depthSellColor; //dnColor
  Color depthSellPathColor;

  ///value border color after selection
  Color selectBorderColor;

  ///background color when value selected
  Color selectFillColor;

  ///color of grid
  Color gridColor;

  ///color of annotation content
  Color infoWindowNormalColor;
  Color infoWindowTitleColor;
  Color infoWindowUpColor;
  Color infoWindowDnColor;

  /// color of the horizontal cross line
  Color hCrossColor;

  /// color of the vertical cross line
  Color vCrossColor;

  /// text color
  Color crossTextColor;

  ///The color of the maximum and minimum values in the current display
  Color maxColor;
  Color minColor;

  /// get MA color via index
  Color getMAColor(int index) {
    switch (index % 3) {
      case 1:
        return ma10Color;
      case 2:
        return ma30Color;
      default:
        return ma5Color;
    }
  }

  /// constructor chart color
  ChartColors({
    this.bgColor = const Color(0xffffffff),
    this.kLineColor = const Color(0xff4C86CD),

    ///
    this.lineFillColor = const Color(0x554C86CD),

    ///
    this.lineFillInsideColor = const Color(0x00000000),

    ///
    this.ma5Color = const Color(0xffE5B767),
    this.ma10Color = const Color(0xff1FD1AC),
    this.ma30Color = const Color(0xffB48CE3),
    this.upColor = const Color(0xFF14AD8F),
    this.dnColor = const Color(0xFFD5405D),
    this.volColor = const Color(0xff2f8fd5),
    this.macdColor = const Color(0xff2f8fd5),
    this.difColor = const Color(0xffE5B767),
    this.deaColor = const Color(0xff1FD1AC),
    this.kColor = const Color(0xffE5B767),
    this.dColor = const Color(0xff1FD1AC),
    this.jColor = const Color(0xffB48CE3),
    this.rsiColor = const Color(0xffE5B767),
    this.defaultTextColor = const Color(0xFF909196),
    this.nowPriceUpColor = const Color(0xFF14AD8F),
    this.nowPriceDnColor = const Color(0xFFD5405D),
    this.nowPriceTextColor = const Color(0xffffffff),
    this.sarColor = const Color(0xffE5B767),
    this.avgColor = const Color(0xff82878e),

    /// trend color
    this.trendLineColor = const Color(0xFFF89215),

    ///depth color
    this.depthBuyColor = const Color(0xFF14AD8F),
    this.depthBuyPathColor = const Color(0x3314AD8F),
    this.depthSellColor = const Color(0xFFD5405D),
    this.depthSellPathColor = const Color(0x33D5405D),

    ///value border color after selection
    // this.selectBorderColor = const Color(0xFF222223),
    this.selectBorderColor = const Color.fromARGB(255, 255, 255, 255),

    ///background color when value selected
    // this.selectFillColor = const Color(0xffffffff),
    this.selectFillColor = const Color(0xf0f0f0f0),

    ///color of grid
    this.gridColor = const Color(0xFFD1D3DB),

    ///color of annotation content
    this.infoWindowNormalColor = const Color(0xFF222223),
    this.infoWindowTitleColor = const Color(0xFF4D4D4E), //0xFF707070
    this.infoWindowUpColor = const Color(0xFF14AD8F),
    this.infoWindowDnColor = const Color(0xFFD5405D),
    this.hCrossColor = const Color(0xFF222223),
    this.vCrossColor = const Color(0xFF222223),
    this.crossTextColor = const Color(0xFF222223),

    ///The color of the maximum and minimum values in the current display
    this.maxColor = const Color(0xFF222223),
    this.minColor = const Color(0xFF222223),
  });
}

class ChartStyle {
  double topPadding = 20.0;

  double bottomPadding = 20.0;

  double childPadding = 12.0;

  ///point-to-point distance
  double pointWidth = 11.0;

  ///candle width
  double candleWidth = 8.5;
  double candleLineWidth = 1.0;

  ///vol column width
  double volWidth = 8.5;

  ///macd column width
  double macdWidth = 1.2;

  ///vertical-horizontal cross line width
  double vCrossWidth = 0.5;
  double hCrossWidth = 0.5;

  ///(line length - space line - thickness) of the current price
  double nowPriceLineLength = 4.5;
  double nowPriceLineSpan = 3.5;
  double nowPriceLineWidth = 1;

  int gridRows = 4;
  int gridColumns = 4;

  ///customize the time below
  List<String>? dateTimeFormat;

  /// 价格弹窗 - 标题字体大小
  double popupTitleFontSize = 10.0;

  /// 价格弹窗 - 值字体大小
  double popupValueFontSize = 10.0;

  /// 价格弹窗 - 内边距
  EdgeInsets popupPadding = const EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 0.0);

  /// 价格弹窗 - 每行底部间距
  double popupItemSpacing = 3.0;

  /// 价格弹窗 - 边框宽度（0 则无边框）
  double popupBorderWidth = 0;

  /// 价格弹窗 - 边框圆角
  double popupBorderRadius = 0.0;

  /// 影线宽度动态调整 - 是否启用
  /// 当缩放到最小时，影线会逐渐变粗至与实体一样宽
  bool enableDynamicShadowWidth = true;

  /// 影线宽度动态调整 - 开始过渡的缩放阈值
  /// 当 scaleX 低于此值时，开始增加影线宽度
  /// 默认值 0.5 表示从 scaleX=0.5 开始过渡
  double shadowWidthTransitionStart = 0.3;

  /// 影线宽度动态调整 - 完全过渡的缩放阈值
  /// 当 scaleX 低于此值时，影线宽度完全等于实体宽度
  /// 默认值 0.2 表示在最小缩放时影线与实体同宽
  double shadowWidthTransitionEnd = 0.2;

  // ===== 技术指标线宽动态调整配置 =====

  /// 主图指标线宽动态调整 - 是否启用
  /// 启用后，主图技术指标线（MA、BOLL、SAR）会根据缩放级别动态调整粗细
  /// - 缩放时保持视觉一致性（补偿 scaleX）
  /// - 最小宽度不低于 K 线实体宽度（保证可见性）
  /// - 最大宽度受固定上限和 K 线宽度双重约束
  bool enableDynamicMainIndicatorWidth = false;

  /// 主图指标线 - 基础宽度（像素）
  /// 在 scaleX = 1.0 时的线条宽度
  double mainIndicatorBaseWidth = 1.5;

  /// 主图指标线 - 固定最大宽度上限（像素）
  /// 线条宽度不会超过此值，即使 K 线很宽
  double mainIndicatorMaxWidth = 3.0;

  /// 副图指标线宽动态调整 - 是否启用
  /// 启用后，副图技术指标线（MACD、KDJ、RSI 等）会根据缩放级别动态调整粗细
  bool enableDynamicSecondaryIndicatorWidth = false;

  /// 副图指标线 - 基础宽度（像素）
  /// 在 scaleX = 1.0 时的线条宽度
  double secondaryIndicatorBaseWidth = 1.2;

  /// 副图指标线 - 固定最大宽度上限（像素）
  /// 线条宽度不会超过此值
  double secondaryIndicatorMaxWidth = 3.0;

  /// 十字线是否使用虚线
  bool crossLineDash = true;

  /// 虚线段长度
  double crossLineDashLength = 4.0;

  /// 虚线间隔长度
  double crossLineDashSpace = 3.0;

  /// 日期行高度（显示在K线图正下方）
  /// 设置为 0 则日期显示在图表最底部（传统模式）
  double dateRowHeight = 20.0;
}