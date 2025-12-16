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

class ViewportSnapshot {
  const ViewportSnapshot({
    required this.dataLength,
    required this.scrollX,
    required this.scaleX,
  });

  final int dataLength;

  final double scrollX;

  final double scaleX;
}

enum MainState { MA, BOLL, SAR }

enum SecondaryState { MACD, KDJ, RSI, WR, CCI }

enum NowPriceAlignment { left, right }

enum CrossPriceAlignment { left, right, auto }

/// 图表手势状态，用于与父级滚动视图协调
enum ChartGestureState {
  /// 空闲状态，允许父级滚动
  idle,

  /// 正在缩放（双指），应阻止父级滚动
  scaling,

  /// 正在水平拖动（单指水平），应阻止父级滚动
  horizontalDragging,

  /// 正在垂直拖动（单指垂直），允许父级滚动
  verticalDragging,
}

/// 手势状态变化回调
typedef ChartGestureStateCallback = void Function(ChartGestureState state);

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
  const CandlestickWidget(
    this.datas,
    this.chartStyle,
    this.chartColors, {
    super.key,
    required this.isTrendLine,
    this.xFrontPadding = 100,
    this.xBackPadding = 100,
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
    this.panSensitivity = 1.0,
    this.loadingIndicatorBuilder,
    this.loadingErrorBuilder,
    this.boundaryThreshold = 50.0,
    this.debounceDelay = 1000,
    this.onGestureStateChanged,
  });

  final List<KLineEntity>? datas;

  final Set<MainState> mainStateLi;

  final bool volHidden;

  final Set<SecondaryState> secondaryStateLi;

  final bool isLine;

  final bool isTapShowInfoDialog;

  final bool hideGrid;

  final bool showNowPrice;

  final bool showInfoDialog;

  final bool materialInfoDialog;

  final ChartTranslations chartTranslations;

  final List<String> timeFormat;

  final double mBaseHeight;

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

  final double xBackPadding;

  final PriceFormatter? priceFormatter;

  final NowPriceAlignment? nowPriceAlignment;

  final CrossPriceAlignment crossPriceAlignment;

  final FutureOr<void> Function(bool isLeft)? onReachBoundary;

  final bool autoSwitchToLine;

  final double lineThreshold;

  final double panSensitivity;

  final Widget Function(bool isLeft)? loadingIndicatorBuilder;

  final Widget Function(bool isLeft, Object error, VoidCallback retry)?
      loadingErrorBuilder;

  final double boundaryThreshold;

  final int debounceDelay;

  /// 手势状态变化回调，用于与父级滚动视图协调
  /// 当手势状态变化时会调用此回调
  final ChartGestureStateCallback? onGestureStateChanged;

  @override
  _CandlestickWidgetState createState() => _CandlestickWidgetState();
}

class _CandlestickWidgetState extends State<CandlestickWidget>
    with TickerProviderStateMixin {
  final StreamController<InfoWindowEntity?> mInfoWindowStream =
      StreamController<InfoWindowEntity?>();

  double mScaleX = 1.0;

  double mScrollX = 0.0;

  double mSelectX = 0.0;

  double mHeight = 0, mWidth = 0;

  AnimationController? _controller;

  Animation<double>? aniX;

  bool _isAutoLine = false;

  List<TrendLine> lines = [];

  double? changeinXposition;

  double? changeinYposition;

  double mSelectY = 0.0;

  bool waitingForOtherPairofCords = false;

  bool enableCordRecord = false;

  double getMinScrollX() {
    return mScaleX;
  }

  int _pointerCount = 0;

  int _lastPointerCount = 0;

  double _scaleBase = 1.0;

  double _scaleXBase = 1.0;

  int _anchorIndex = 0;

  double _anchorScreenX = 0.0;

  bool isScale = false, isDrag = false, isLongPress = false, isOnTap = false;

  bool _isCrossLocked = false;

  double _boundaryOverscroll = 0.0;

  bool? _isLoadingAtLeft;

  Object? _loadingError;

  int? _lastBoundaryTriggerTime;

  /// 当前手势状态
  ChartGestureState _currentGestureState = ChartGestureState.idle;

  /// 初始触摸位置，用于判断滑动方向
  Offset? _initialPointerPosition;

  /// 是否已经确定了滑动方向
  bool _dragDirectionDetermined = false;

  /// 更新手势状态并通知回调
  void _updateGestureState(ChartGestureState newState) {
    if (_currentGestureState != newState) {
      _currentGestureState = newState;
      widget.onGestureStateChanged?.call(newState);
    }
  }

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
      lines: lines, // 趋势线列表
      sink: mInfoWindowStream.sink, // 信息弹窗数据流
      xFrontPadding: widget.xFrontPadding,
      xBackPadding: widget.xBackPadding,
      isTrendLine: widget.isTrendLine, // 是否启用趋势线
      selectY: mSelectY, // 选中的 Y 坐标（趋势线用）
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
      isCrossLocked: _isCrossLocked, // 十字线锁定状态
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        mHeight = constraints.maxHeight;
        mWidth = constraints.maxWidth;

        return Listener(
          onPointerDown: (event) {
            setState(() => _pointerCount++);
            // 记录初始触摸位置
            if (_pointerCount == 1) {
              _initialPointerPosition = event.position;
              _dragDirectionDetermined = false;
            }
            // 双指时立即通知缩放状态
            if (_pointerCount >= 2) {
              _updateGestureState(ChartGestureState.scaling);
            }
          },
          onPointerUp: (_) {
            setState(() => _pointerCount--);
            if (_pointerCount <= 0) {
              _pointerCount = 0;
              _initialPointerPosition = null;
              _dragDirectionDetermined = false;
              _updateGestureState(ChartGestureState.idle);
            }
          },
          onPointerCancel: (_) {
            setState(() => _pointerCount--);
            if (_pointerCount <= 0) {
              _pointerCount = 0;
              _initialPointerPosition = null;
              _dragDirectionDetermined = false;
              _updateGestureState(ChartGestureState.idle);
            }
          },
          child: RawGestureDetector(
            behavior: HitTestBehavior.opaque, // 确保空白区域也能接收事件
            gestures: <Type, GestureRecognizerFactory>{
              ScaleGestureRecognizer:
                  GestureRecognizerFactoryWithHandlers<ScaleGestureRecognizer>(
                ScaleGestureRecognizer.new,
                (ScaleGestureRecognizer instance) {
                  instance
                    ..onStart = (details) {
                      isOnTap = false;
                      _stopAnimation(); // 停止惯性滚动

                      _lastPointerCount = _pointerCount;

                      _scaleBase = 1.0; // 手势开始时总是 1.0
                      _scaleXBase = mScaleX;

                      _anchorScreenX = details.focalPoint.dx;
                      _anchorIndex = painter.calculateSelectedX(_anchorScreenX);

                      _boundaryOverscroll = 0.0; // 重置边界滑动累积
                      _onDragChanged(true); // 通知拖拽状态改变
                    }
                    ..onUpdate = (details) {
                      if (isLongPress) return;

                      if (_isCrossLocked) {
                        _isCrossLocked = false;
                        isOnTap = false;
                        mInfoWindowStream.sink.add(null);
                      }

                      if (_pointerCount != _lastPointerCount) {
                        _scaleBase = details.scale;
                        _scaleXBase = mScaleX;
                        _anchorScreenX = details.focalPoint.dx;
                        _anchorIndex =
                            painter.calculateSelectedX(_anchorScreenX);
                        _lastPointerCount = _pointerCount;
                      }

                      final isPinching = _pointerCount >= 2;

                      if (!isPinching) {
                        // 单指拖动：检测滑动方向
                        if (!_dragDirectionDetermined &&
                            _initialPointerPosition != null) {
                          final delta =
                              details.focalPoint - _initialPointerPosition!;
                          const threshold = 10.0; // 方向判断阈值

                          if (delta.distance > threshold) {
                            _dragDirectionDetermined = true;
                            // 判断是水平还是垂直滑动
                            if (delta.dx.abs() > delta.dy.abs()) {
                              // 水平滑动 - 图表处理，阻止父级滚动
                              _updateGestureState(
                                  ChartGestureState.horizontalDragging);
                            } else {
                              // 垂直滑动 - 允许父级滚动
                              _updateGestureState(
                                  ChartGestureState.verticalDragging);
                            }
                          }
                        }

                        final dx = details.focalPointDelta.dx;

                        final delta = (dx / mScaleX) * widget.panSensitivity;

                        mScrollX = (mScrollX + delta)
                            .clamp(0.0, ChartPainter.maxScrollX)
                            .toDouble();

                        if (widget.onReachBoundary != null) {
                          if (mScrollX <= 0 && dx < 0) {
                            _boundaryOverscroll += dx.abs();
                            if (_boundaryOverscroll >
                                widget.boundaryThreshold) {
                              _triggerBoundaryCallback(false);
                              _boundaryOverscroll = 0.0;
                            }
                          } else if (mScrollX >= ChartPainter.maxScrollX &&
                              ChartPainter.maxScrollX > 0 &&
                              dx > 0) {
                            _boundaryOverscroll += dx.abs();
                            if (_boundaryOverscroll >
                                widget.boundaryThreshold) {
                              _triggerBoundaryCallback(true);
                              _boundaryOverscroll = 0.0;
                            }
                          } else {
                            _boundaryOverscroll = 0.0;
                          }
                        }

                        isScale = false;
                      } else {
                        isScale = true;

                        final relativeScale = details.scale / _scaleBase;
                        final newScaleX =
                            (_scaleXBase * relativeScale).clamp(0.2, 4.0);

                        if (widget.autoSwitchToLine) {
                          _isAutoLine = newScaleX <= widget.lineThreshold;
                        }

                        //

                        //

                        final anchorLogicX = painter.getX(_anchorIndex);

                        // => mTranslateX = screenX / scaleX - logicX
                        final newTranslateX =
                            _anchorScreenX / newScaleX - anchorLogicX;

                        // mTranslateX = scrollX + getMinTranslateX()
                        // => scrollX = mTranslateX - getMinTranslateX()
                        final dataLen = painter.mDataLen;
                        final pointWidth = painter.mPointWidth;

                        final minTranslateX = -dataLen +
                            mWidth / newScaleX -
                            pointWidth / 2 -
                            widget.xFrontPadding / newScaleX;
                        final effectiveMinTranslateX =
                            minTranslateX >= 0 ? 0.0 : minTranslateX;

                        mScrollX = (newTranslateX - effectiveMinTranslateX)
                            .clamp(0.0, ChartPainter.maxScrollX)
                            .toDouble();

                        mScaleX = newScaleX;
                      }

                      notifyChanged(); // 触发重绘
                    }
                    ..onEnd = (details) {
                      isScale = false;
                      _onDragChanged(false);

                      if (_pointerCount == 0 && _lastPointerCount == 1) {
                        var velocity = details.velocity.pixelsPerSecond.dx;
                        _onFling(velocity);
                      }
                    };
                },
              ),
              TapGestureRecognizer:
                  GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
                TapGestureRecognizer.new,
                (TapGestureRecognizer instance) {
                  instance.onTapUp = (details) {
                    if (!widget.isTrendLine &&
                        painter.isInMainRect(details.localPosition)) {
                      if (_isCrossLocked) {
                        _isCrossLocked = false;
                        isOnTap = false;
                        mInfoWindowStream.sink.add(null); // 清空信息弹窗
                      } else {
                        _isCrossLocked = true;
                        isOnTap = true;
                        mSelectX = details.localPosition.dx;
                      }
                      notifyChanged();
                    }

                    if (widget.isTrendLine &&
                        !isLongPress &&
                        enableCordRecord) {
                      enableCordRecord = false;
                      Offset p1 = Offset(getTrendLineX(), mSelectY);

                      if (!waitingForOtherPairofCords) {
                        lines.add(TrendLine(p1, Offset(-1, -1), trendLineMax!,
                            trendLineScale!));
                      }

                      if (waitingForOtherPairofCords) {
                        var a = lines.last;
                        lines.removeLast();
                        lines.add(TrendLine(
                            a.p1, p1, trendLineMax!, trendLineScale!));
                        waitingForOtherPairofCords = false;
                      } else {
                        waitingForOtherPairofCords = true;
                      }
                      notifyChanged();
                    }
                  };
                },
              ),
              LongPressGestureRecognizer: GestureRecognizerFactoryWithHandlers<
                  LongPressGestureRecognizer>(
                LongPressGestureRecognizer.new,
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
                        mSelectY =
                            changeinYposition = details.globalPosition.dy;
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
                      enableCordRecord = true; // 启用趋势线坐标记录

                      if (!widget.isTrendLine) {
                        _isCrossLocked = true;
                        isOnTap = true; // 保持 isOnTap 为 true 以显示十字线
                      } else {
                        mInfoWindowStream.sink.add(null); // 趋势线模式清空信息弹窗
                      }
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
                if (widget.showInfoDialog) _buildInfoDialog(),
                if (_isLoadingAtLeft != null &&
                    widget.loadingIndicatorBuilder != null)
                  _buildLoadingIndicator(),
              ],
            ),
          ), // RawGestureDetector 结束
        ); // Listener 结束
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
    aniX = Tween<double>(
      begin: mScrollX,
      end: (x * widget.flingRatio * widget.panSensitivity) + mScrollX,
    ).animate(
        CurvedAnimation(parent: _controller!.view, curve: widget.flingCurve));

    aniX!.addListener(() {
      mScrollX = aniX!.value;

      if (mScrollX <= 0) {
        mScrollX = 0;
        _triggerBoundaryCallback(false); // false = 加载最新数据

        if (widget.onLoadMore != null) {
          widget.onLoadMore!(false);
        }
        _stopAnimation();
      } else if (mScrollX >= ChartPainter.maxScrollX) {
        mScrollX = ChartPainter.maxScrollX;
        _triggerBoundaryCallback(true); // true = 加载历史数据

        if (widget.onLoadMore != null) {
          widget.onLoadMore!(true);
        }
        _stopAnimation();
      }

      notifyChanged(); // 每帧重绘
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

  Future<void> _triggerBoundaryCallback(bool isLeft) async {
    if (widget.onReachBoundary == null) return;

    if (_isLoadingAtLeft == isLeft) return;

    final now = DateTime.now().millisecondsSinceEpoch;
    if (_lastBoundaryTriggerTime != null) {
      final elapsed = now - _lastBoundaryTriggerTime!;
      if (elapsed < widget.debounceDelay) return;
    }

    setState(() {
      _isLoadingAtLeft = isLeft;
      _loadingError = null; // 清除之前的错误
      _lastBoundaryTriggerTime = now;
    });

    try {
      await Future.value(widget.onReachBoundary!(isLeft));

      resetLoadingState();
    } catch (error) {
      setState(() {
        _loadingError = error;
      });

      if (widget.loadingErrorBuilder == null) {
        resetLoadingState();
      }
    }
  }

  void resetLoadingState() {
    if (_isLoadingAtLeft != null || _loadingError != null) {
      setState(() {
        _isLoadingAtLeft = null;
        _loadingError = null;
      });
    }
  }

  ViewportSnapshot createViewportSnapshot() {
    return ViewportSnapshot(
      dataLength: widget.datas?.length ?? 0,
      scrollX: mScrollX,
      scaleX: mScaleX,
    );
  }

  ///

  void restoreViewport(ViewportSnapshot snapshot, int newDataCount) {
    if (widget.datas == null || widget.datas!.isEmpty) return;

    final newScrollX = snapshot.scrollX + newDataCount;

    setState(() {
      mScaleX = snapshot.scaleX;

      mScrollX = newScrollX.clamp(0.0, ChartPainter.maxScrollX).toDouble();
    });
  }

  late List<String> infos;

  Widget _buildLoadingIndicator() {
    if (_isLoadingAtLeft == null) {
      return const SizedBox.shrink();
    }

    Widget content;

    if (_loadingError != null && widget.loadingErrorBuilder != null) {
      final loadingDirection = _isLoadingAtLeft!;
      content = widget.loadingErrorBuilder!(
        loadingDirection,
        _loadingError!,
        () {
          resetLoadingState();
          _triggerBoundaryCallback(loadingDirection);
        },
      );
    } else if (widget.loadingIndicatorBuilder != null) {
      content = widget.loadingIndicatorBuilder!(_isLoadingAtLeft!);
    } else {
      return const SizedBox.shrink();
    }

    return Positioned(
      top: 0,
      left: _isLoadingAtLeft! ? 0 : null,
      right: _isLoadingAtLeft! ? null : 0,
      child: content,
    );
  }

  Widget _buildInfoDialog() {
    return StreamBuilder<InfoWindowEntity?>(
      stream: mInfoWindowStream.stream,
      builder: (context, snapshot) {
        if ((!isLongPress && !isOnTap && !_isCrossLocked) ||
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
