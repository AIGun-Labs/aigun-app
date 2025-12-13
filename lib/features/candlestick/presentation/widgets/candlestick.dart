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
import 'timeframe_selector.dart';

class AIGunCandlestick extends StatefulWidget {
  const AIGunCandlestick({super.key, this.height = 450, this.width});

  final double height;
  final double? width;

  @override
  State<AIGunCandlestick> createState() => _AIGunCandlestickState();
}

class _AIGunCandlestickState extends State<AIGunCandlestick> {
  late final CandlestickCubit _candlestickCubit;

  final ChartStyle chartStyle = ChartStyle();
  final ChartColors chartColors = ChartColors();

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
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 8.h,
                    ),
                    child: TimeframeSelector(source: candlestickState.source),
                  ),
                  AspectRatio(
                    aspectRatio: 1.0, // 宽高比 1:1，可以调整
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
                      success: (_) => CandlestickWidget(
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
                        autoSwitchToLine: true,
                        lineThreshold: 0.5,
                        priceFormatter: (price) =>
                            CurrencyFormatter.abbreviateTokenPrice(price),
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
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(
                  //     horizontal: 8.w,
                  //     vertical: 8.h,
                  //   ),
                  //   child: IndicatorSelector(),
                  // ),
                ],
              );
            },
          ),
    );
  }
}
