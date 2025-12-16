import 'package:candlestick/candlestick.dart' hide S;
import 'package:candlestick/chart_translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/l10n.dart';
import '../../../../utils/format/currency.dart';
import '../cubit/candlestick/candlestick_cubit.dart';
import '../cubit/candlestick/candlestick_state.dart';
import '../cubit/history/history_candlestick_state.dart';
import '../cubit/selection/selection_params_cubit.dart';
import '../cubit/selection/selection_params_state.dart';
import 'indicator_selector.dart';
import 'timeframe_selector.dart';

class AIGunCandlestick extends StatefulWidget {
  const AIGunCandlestick({
    super.key,
    this.height = 450,
    this.width,
    this.onGestureStateChanged,
  });

  final double height;
  final double? width;

  /// 手势状态变化回调，用于与父级滚动视图协调
  final ChartGestureStateCallback? onGestureStateChanged;

  @override
  State<AIGunCandlestick> createState() => _AIGunCandlestickState();
}

class _AIGunCandlestickState extends State<AIGunCandlestick> {
  late final CandlestickCubit _candlestickCubit;
  late bool _isInitialed = false;

  final ChartStyle chartStyle = ChartStyle();
  final ChartColors chartColors = ChartColors();

  double _calculateChartHeight(SelectionParamsState state) {
    double height = 360;

    if (!state.volHidden) {
      height += 72;
    }

    // 每个副图指标的高度
    height += state.secondaryStates.length * 72;

    return height;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _candlestickCubit = BlocProvider.of<CandlestickCubit>(context);
  }

  @override
  void deactivate() {
    _candlestickCubit.stopPolling();
    super.deactivate();
  }

  @override
  void dispose() {
    if (mounted) {
      _candlestickCubit
        ..clearHistoryData()
        ..clearLatestData();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CandlestickCubit, CandlestickState>(
      builder: (context, candlestickState) =>
          BlocBuilder<SelectionParamsCubit, SelectionParamsState>(
            builder: (context, state) {
              final chartHeight = _calculateChartHeight(state);
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (_isInitialed)
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 8.h,
                      ),
                      child: TimeframeSelector(source: candlestickState.source),
                    ),

                  // candlestickState.status.when(
                  //   initial: () => SizedBox.shrink(),
                  //   loading: () => SizedBox.shrink(),
                  //   success: (_) => Padding(
                  //     padding: EdgeInsets.symmetric(
                  //       horizontal: 8.w,
                  //       vertical: 8.h,
                  //     ),
                  //     child: TimeframeSelector(source: candlestickState.source),
                  //   ),
                  //   error: (message) => SizedBox.shrink(),
                  // ),
                  SizedBox(
                    height: chartHeight,
                    child: candlestickState.status.when(
                      initial: () =>
                          const Center(child: CircularProgressIndicator()),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (message) => Center(
                        child: Text(
                          message,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                      success: (_) {
                        if (!_isInitialed) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (mounted) setState(() => _isInitialed = true);
                          });
                        }
                        return RepaintBoundary(
                          child: CandlestickWidget(
                            candlestickState.kLineEntities,
                            chartStyle,
                            chartColors,
                            mBaseHeight: 360,
                            isTrendLine: false,
                            mainStateLi: state.mainStates,
                            volHidden: state.volHidden,
                            secondaryStateLi: state.secondaryStates,
                            fixedLength: 2,
                            isTapShowInfoDialog: true,
                            timeFormat: TimeFormat.YEAR_MONTH_DAY,
                            verticalTextAlignment: VerticalTextAlignment.right,
                            nowPriceAlignment: NowPriceAlignment.right,
                            crossPriceAlignment: CrossPriceAlignment.right,
                            lineThreshold: 0.5,
                            onLoadMore: (isMore) =>
                                BlocProvider.of<CandlestickCubit>(
                                  context,
                                ).loadMore(),
                            priceFormatter:
                                CurrencyFormatter.abbreviateTokenPrice,
                            chartTranslations: ChartTranslations(
                              date: S.of(context).date,
                              open: S.of(context).opening,
                              high: S.of(context).high,
                              low: S.of(context).low,
                              close: S.of(context).closing,
                              changeAmount: S.of(context).changeAmount,
                              change: S.of(context).change,
                              amount: S.of(context).amount,
                              vol: S.of(context).vol,
                            ),
                            onGestureStateChanged: widget.onGestureStateChanged,

                            // // 自定义加载指示器
                            // loadingIndicatorBuilder: (isLeft) {
                            //   if (!isLeft) {
                            //     return SizedBox.shrink();
                            //   }

                            //   return Container(
                            //     padding: const EdgeInsets.all(8),
                            //     margin: const EdgeInsets.all(8),
                            //     decoration: BoxDecoration(
                            //       color: Colors.black.withOpacity(0.7),
                            //       borderRadius: BorderRadius.circular(4),
                            //     ),
                            //     child: Row(
                            //       mainAxisSize: MainAxisSize.min,
                            //       children: [
                            //         const SizedBox(
                            //           width: 16,
                            //           height: 16,
                            //           child: CircularProgressIndicator(
                            //             strokeWidth: 2,
                            //             valueColor:
                            //                 AlwaysStoppedAnimation<Color>(
                            //                   Colors.white,
                            //                 ),
                            //           ),
                            //         ),
                            //         const SizedBox(width: 8),
                            //         Text(
                            //           isLeft ? '加载历史数据...' : '加载最新数据...',
                            //           style: const TextStyle(
                            //             color: Colors.white,
                            //             fontSize: 12,
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   );
                            // },
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 8.h,
                    ),
                    child: IndicatorSelector(),
                  ),
                ],
              );
            },
          ),
    );
  }
}
