import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'chart_translations.dart';
import 'components/popup_info_view.dart';
import 'entity/index.dart';
import 'renderer/base_dimension.dart';
import 'renderer/index.dart';
import 'utils/date_format_util.dart';

typedef PriceFormatter = String Function(double price);

enum MainState { MA, BOLL, SAR }

enum SecondaryState { MACD, KDJ, RSI, WR, CCI }

/// 最新价格标识位置
enum NowPriceAlignment { left, right }

/// 十字准心价格标签位置
enum CrossPriceAlignment { left, right, auto }

class TimeFormat {
  static const List<String> YEAR_MONTH_DAY = [yyyy, '-', mm, '-', dd];
  static const List<String> YEAR_MONTH_DAY_WITH_HOUR = [
    yyyy,
    '-',
    mm,
    '-',
    dd,
    ' ',
    HH,
    ':',
    nn
  ];
}

class CandlestickWidget extends StatefulWidget {
  final List<KLineEntity>? datas;
  final Set<MainState> mainStateLi;
  final bool volHidden;
  final Set<SecondaryState> secondaryStateLi;
  // final Function()? onSecondaryTap;
  final bool isLine;
  final bool
      isTapShowInfoDialog; //Whether to enable click to display detailed data
  final bool hideGrid;
  final bool showNowPrice;
  final bool showInfoDialog;
  final bool materialInfoDialog; // Material Style Information Popup
  final ChartTranslations chartTranslations;
  final List<String> timeFormat;
  final double mBaseHeight;

  // It will be called when the screen scrolls to the end.
  // If true, it will be scrolled to the end of the right side of the screen.
  // If it is false, it will be scrolled to the end of the left side of the screen.
  final Function(bool)? onLoadMore;

  final int fixedLength;
  final List<int> maDayList;
  final int flingTime;
  final double flingRatio;
  final Curve flingCurve;
  final Function(bool)? isOnDrag;
  final ChartColors chartColors;
  final ChartStyle chartStyle;
  final VerticalTextAlignment verticalTextAlignment;
  final bool isTrendLine;
  final double xFrontPadding;
  final PriceFormatter? priceFormatter;
  final NowPriceAlignment? nowPriceAlignment;
  final CrossPriceAlignment crossPriceAlignment;

  /// 滑动到边界时的回调
  /// [isLeft] 为 true 表示到达左边界（最早数据），false 表示到达右边界（最新数据）
  final Function(bool isLeft)? onReachBoundary;

  /// 是否启用自动切换分时图模式（缩放到阈值以下时自动切换）
  final bool autoSwitchToLine;

  /// 切换到分时图的缩放阈值（默认 0.5）
  final double lineThreshold;

  const CandlestickWidget(
    this.datas,
    this.chartStyle,
    this.chartColors, {
    super.key,
    required this.isTrendLine,
    this.xFrontPadding = 100,
    this.mainStateLi = const <MainState>{},
    this.secondaryStateLi = const <SecondaryState>{},
    // this.onSecondaryTap,
    this.volHidden = false,
    this.isLine = false,
    this.isTapShowInfoDialog = false,
    this.hideGrid = false,
    this.showNowPrice = true,
    this.showInfoDialog = true,
    this.materialInfoDialog = true,
    this.chartTranslations = const ChartTranslations(),
    this.timeFormat = TimeFormat.YEAR_MONTH_DAY,
    this.onLoadMore,
    this.fixedLength = 2,
    this.maDayList = const [5, 10, 20],
    this.flingTime = 600,
    this.flingRatio = 0.5,
    this.flingCurve = Curves.decelerate,
    this.isOnDrag,
    this.verticalTextAlignment = VerticalTextAlignment.left,
    this.mBaseHeight = 360,
    this.priceFormatter,
    this.nowPriceAlignment,
    this.crossPriceAlignment = CrossPriceAlignment.auto,
    this.onReachBoundary,
    this.autoSwitchToLine = false,
    this.lineThreshold = 0.5,
  });

  @override
  _CandlestickWidgetState createState() => _CandlestickWidgetState();
}

class _CandlestickWidgetState extends State<CandlestickWidget>
    with TickerProviderStateMixin {
  final StreamController<InfoWindowEntity?> mInfoWindowStream =
      StreamController<InfoWindowEntity?>();
  double mScaleX = 1.0, mScrollX = 0.0, mSelectX = 0.0;
  double mHeight = 0, mWidth = 0;
  AnimationController? _controller;
  Animation<double>? aniX;

  /// 是否因缩放自动切换到分时图模式
  bool _isAutoLine = false;

  //For TrendLine
  List<TrendLine> lines = [];
  double? changeinXposition;
  double? changeinYposition;
  double mSelectY = 0.0;
  bool waitingForOtherPairofCords = false;
  bool enableCordRecord = false;

  double getMinScrollX() {
    return mScaleX;
  }

  double _lastScale = 1.0;
  int _initialPointerCount = 1;
  bool isScale = false, isDrag = false, isLongPress = false, isOnTap = false;

  /// 边界处累积的滑动距离，用于触发 onReachBoundary
  double _boundaryOverscroll = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    mInfoWindowStream.sink.close();
    mInfoWindowStream.close();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.datas != null && widget.datas!.isEmpty) {
      mScrollX = mSelectX = 0.0;
      mScaleX = 1.0;
    }
    final BaseDimension baseDimension = BaseDimension(
      mBaseHeight: widget.mBaseHeight,
      volHidden: widget.volHidden,
      secondaryStateLi: widget.secondaryStateLi,
      mainStateLi: widget.mainStateLi,
    );
    final painter = ChartPainter(
      widget.chartStyle,
      widget.chartColors,
      baseDimension: baseDimension,
      lines: lines, //For TrendLine
      sink: mInfoWindowStream.sink,
      xFrontPadding: widget.xFrontPadding,
      isTrendLine: widget.isTrendLine, //For TrendLine
      selectY: mSelectY, //For TrendLine
      datas: widget.datas,
      scaleX: mScaleX,
      scrollX: mScrollX,
      selectX: mSelectX,
      isLongPass: isLongPress,
      isOnTap: isOnTap,
      isTapShowInfoDialog: widget.isTapShowInfoDialog,
      mainStateLi: widget.mainStateLi,
      volHidden: widget.volHidden,
      secondaryStateLi: widget.secondaryStateLi,
      isLine: widget.isLine || _isAutoLine,
      hideGrid: widget.hideGrid,
      showNowPrice: widget.showNowPrice,
      fixedLength: widget.fixedLength,
      maDayList: widget.maDayList,
      verticalTextAlignment: widget.verticalTextAlignment,
      priceFormatter: widget.priceFormatter,
      nowPriceAlignment: widget.nowPriceAlignment,
      crossPriceAlignment: widget.crossPriceAlignment,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        mHeight = constraints.maxHeight;
        mWidth = constraints.maxWidth;
        return RawGestureDetector(
          behavior: HitTestBehavior.opaque,
          gestures: <Type, GestureRecognizerFactory>{
            // 水平拖拽手势
            HorizontalDragGestureRecognizer:
                GestureRecognizerFactoryWithHandlers<
                    HorizontalDragGestureRecognizer>(
              () => HorizontalDragGestureRecognizer(),
              (HorizontalDragGestureRecognizer instance) {
                instance
                  ..onStart = (details) {
                    isScale = true;
                    isOnTap = false;
                    _initialPointerCount = 1;
                    _boundaryOverscroll = 0.0; // 重置边界滑动累积
                    _stopAnimation();
                    _onDragChanged(true);
                  }
                  ..onUpdate = (details) {
                    if (isLongPress) return;
                    // 单指: 只处理平移
                    final delta = details.delta.dx;
                    mScrollX = (delta / mScaleX + mScrollX)
                        .clamp(0.0, ChartPainter.maxScrollX)
                        .toDouble();

                    // 检测边界：如果已经在边界且继续朝边界方向滑动
                    if (widget.onReachBoundary != null) {
                      // 在左边界且向右滑动
                      if (mScrollX <= 0 && delta > 0) {
                        _boundaryOverscroll += delta;
                        if (_boundaryOverscroll > 50) {
                          widget.onReachBoundary!(true);
                          _boundaryOverscroll = 0.0;
                        }
                      }
                      // 在右边界且向左滑动
                      else if (mScrollX >= ChartPainter.maxScrollX &&
                          ChartPainter.maxScrollX > 0 &&
                          delta < 0) {
                        _boundaryOverscroll += delta.abs();
                        if (_boundaryOverscroll > 50) {
                          widget.onReachBoundary!(false);
                          _boundaryOverscroll = 0.0;
                        }
                      } else {
                        _boundaryOverscroll = 0.0; // 不在边界，重置
                      }
                    }
                    notifyChanged();
                  }
                  ..onEnd = (details) {
                    isScale = false;
                    _onDragChanged(false);
                    var velocity = details.velocity.pixelsPerSecond.dx;
                    _onFling(velocity);
                  };
              },
            ),
            // 缩放手势
            ScaleGestureRecognizer:
                GestureRecognizerFactoryWithHandlers<ScaleGestureRecognizer>(
              () => ScaleGestureRecognizer(),
              (ScaleGestureRecognizer instance) {
                instance
                  ..onStart = (details) {
                    if (details.pointerCount >= 2) {
                      isScale = true;
                      _initialPointerCount = details.pointerCount;
                      _stopAnimation();
                    }
                  }
                  ..onUpdate = (details) {
                    if (details.pointerCount >= 2) {
                      mScaleX = (_lastScale * details.scale).clamp(0.2, 4.0);
                      if (widget.autoSwitchToLine) {
                        _isAutoLine = mScaleX <= widget.lineThreshold;
                      }
                      notifyChanged();
                    }
                  }
                  ..onEnd = (details) {
                    isScale = false;
                    _lastScale = mScaleX;
                  };
              },
            ),
            // 点击手势
            TapGestureRecognizer:
                GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
              () => TapGestureRecognizer(),
              (TapGestureRecognizer instance) {
                instance.onTapUp = (details) {
                  if (!widget.isTrendLine &&
                      painter.isInMainRect(details.localPosition)) {
                    isOnTap = true;
                    if (mSelectX != details.localPosition.dx &&
                        widget.isTapShowInfoDialog) {
                      mSelectX = details.localPosition.dx;
                      notifyChanged();
                    }
                  }
                  if (widget.isTrendLine && !isLongPress && enableCordRecord) {
                    enableCordRecord = false;
                    Offset p1 = Offset(getTrendLineX(), mSelectY);
                    if (!waitingForOtherPairofCords) {
                      lines.add(TrendLine(
                          p1, Offset(-1, -1), trendLineMax!, trendLineScale!));
                    }
                    if (waitingForOtherPairofCords) {
                      var a = lines.last;
                      lines.removeLast();
                      lines.add(
                          TrendLine(a.p1, p1, trendLineMax!, trendLineScale!));
                      waitingForOtherPairofCords = false;
                    } else {
                      waitingForOtherPairofCords = true;
                    }
                    notifyChanged();
                  }
                };
              },
            ),
            // 长按手势
            LongPressGestureRecognizer: GestureRecognizerFactoryWithHandlers<
                LongPressGestureRecognizer>(
              () => LongPressGestureRecognizer(),
              (LongPressGestureRecognizer instance) {
                instance
                  ..onLongPressStart = (details) {
                    isOnTap = false;
                    isLongPress = true;
                    if ((mSelectX != details.localPosition.dx ||
                            mSelectY != details.globalPosition.dy) &&
                        !widget.isTrendLine) {
                      mSelectX = details.localPosition.dx;
                      notifyChanged();
                    }
                    if (widget.isTrendLine && changeinXposition == null) {
                      mSelectX = changeinXposition = details.localPosition.dx;
                      mSelectY = changeinYposition = details.globalPosition.dy;
                      notifyChanged();
                    }
                    if (widget.isTrendLine && changeinXposition != null) {
                      changeinXposition = details.localPosition.dx;
                      changeinYposition = details.globalPosition.dy;
                      notifyChanged();
                    }
                  }
                  ..onLongPressMoveUpdate = (details) {
                    if ((mSelectX != details.localPosition.dx ||
                            mSelectY != details.globalPosition.dy) &&
                        !widget.isTrendLine) {
                      mSelectX = details.localPosition.dx;
                      mSelectY = details.localPosition.dy;
                      notifyChanged();
                    }
                    if (widget.isTrendLine) {
                      mSelectX = mSelectX +
                          (details.localPosition.dx - changeinXposition!);
                      changeinXposition = details.localPosition.dx;
                      mSelectY = mSelectY +
                          (details.globalPosition.dy - changeinYposition!);
                      changeinYposition = details.globalPosition.dy;
                      notifyChanged();
                    }
                  }
                  ..onLongPressEnd = (details) {
                    isLongPress = false;
                    enableCordRecord = true;
                    mInfoWindowStream.sink.add(null);
                    notifyChanged();
                  };
              },
            ),
          },
          child: Stack(
            children: <Widget>[
              CustomPaint(
                size: Size(double.infinity, baseDimension.mDisplayHeight),
                painter: painter,
              ),
              if (widget.showInfoDialog) _buildInfoDialog()
            ],
          ),
        );
      },
    );
  }

  void _stopAnimation({bool needNotify = true}) {
    if (_controller != null && _controller!.isAnimating) {
      _controller!.stop();
      _onDragChanged(false);
      if (needNotify) {
        notifyChanged();
      }
    }
  }

  void _onDragChanged(bool isOnDrag) {
    isDrag = isOnDrag;
    if (widget.isOnDrag != null) {
      widget.isOnDrag!(isDrag);
    }
  }

  void _onFling(double x) {
    _controller = AnimationController(
        duration: Duration(milliseconds: widget.flingTime), vsync: this);
    aniX = null;
    aniX = Tween<double>(begin: mScrollX, end: x * widget.flingRatio + mScrollX)
        .animate(CurvedAnimation(
            parent: _controller!.view, curve: widget.flingCurve));
    aniX!.addListener(() {
      mScrollX = aniX!.value;
      if (mScrollX <= 0) {
        mScrollX = 0;
        if (widget.onLoadMore != null) {
          widget.onLoadMore!(true);
        }
        _stopAnimation();
      } else if (mScrollX >= ChartPainter.maxScrollX) {
        mScrollX = ChartPainter.maxScrollX;
        if (widget.onLoadMore != null) {
          widget.onLoadMore!(false);
        }
        _stopAnimation();
      }
      notifyChanged();
    });
    aniX!.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        _onDragChanged(false);
        notifyChanged();
      }
    });
    _controller!.forward();
  }

  void notifyChanged() => setState(() {});

  late List<String> infos;

  Widget _buildInfoDialog() {
    return StreamBuilder<InfoWindowEntity?>(
      stream: mInfoWindowStream.stream,
      builder: (context, snapshot) {
        if ((!isLongPress && !isOnTap) ||
            widget.isLine == true ||
            !snapshot.hasData ||
            snapshot.data?.kLineEntity == null) return SizedBox();
        KLineEntity entity = snapshot.data!.kLineEntity;
        final dialogWidth = mWidth / 3;
        if (snapshot.data!.isLeft) {
          return Positioned(
            top: 25,
            left: 10.0,
            child: PopupInfoView(
              entity: entity,
              width: dialogWidth,
              chartColors: widget.chartColors,
              chartStyle: widget.chartStyle,
              chartTranslations: widget.chartTranslations,
              materialInfoDialog: widget.materialInfoDialog,
              timeFormat: widget.timeFormat,
              fixedLength: widget.fixedLength,
              priceFormatter: widget.priceFormatter,
            ),
          );
        }
        return Positioned(
          top: 25,
          right: 80.0,
          child: PopupInfoView(
            entity: entity,
            width: dialogWidth,
            chartColors: widget.chartColors,
            chartStyle: widget.chartStyle,
            chartTranslations: widget.chartTranslations,
            materialInfoDialog: widget.materialInfoDialog,
            timeFormat: widget.timeFormat,
            fixedLength: widget.fixedLength,
            priceFormatter: widget.priceFormatter,
          ),
        );
      },
    );
  }
}
