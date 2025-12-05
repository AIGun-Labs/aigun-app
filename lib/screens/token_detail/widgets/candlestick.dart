import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:k_chart/entity/k_line_entity.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/enums/timeframe.dart';
import '../../../core/service_locator.dart';
import '../../../cubits/candle/candle_cubit.dart';
import '../../../cubits/candle/candle_state.dart';
import '../../../l10n/l10n.dart' as app_l10n;
import '../../../shared/presentation/widgets/candlestick.dart';
import '../../../themes/colors.dart';

class Candlestick extends StatefulWidget {
  const Candlestick({super.key});

  @override
  State<Candlestick> createState() => _CandlestickState();
}

class _CandlestickState extends State<Candlestick> {
  late final CandleCubit _candleCubit;
  int _selectedPeriodIndex = 1;

  Timeframe _timeframe = Timeframe.m5;

  @override
  void initState() {
    super.initState();
    _candleCubit = getIt<CandleCubit>();
  }

  @override
  void dispose() {
    // _pollingTimer?.cancel();
    super.dispose();
  }

  List<String> _getTimeOptions(BuildContext context) {
    return [
      app_l10n.S.of(context).chart_period_1min,
      app_l10n.S.of(context).chart_period_5min,
      app_l10n.S.of(context).chart_period_15min,
      app_l10n.S.of(context).chart_period_1hour,
      app_l10n.S.of(context).chart_period_4hour,
      app_l10n.S.of(context).chart_period_1day,
    ];
  }

  
  final List<int> _timePeriodValues = [
    60, 
    5 * 60, 
    15 * 60, 
    60 * 60, 
    4 * 60 * 60, 
    24 * 60 * 60, 
  ];

  
  final List<Timeframe> _timeframeValues = [
    Timeframe.m1, 
    Timeframe.m5, 
    Timeframe.m15, 
    Timeframe.h1, 
    Timeframe.h4, 
    Timeframe.d1, 
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CandleCubit, CandleState>(builder: (context, state) {
      final timeOptions = _getTimeOptions(context);
      return VisibilityDetector(
          key: const Key('candlestick'),
          onVisibilityChanged: (visibility) {
            if (visibility.visibleFraction > 0) {
              _candleCubit.startPollingLatest();
            } else {
              _candleCubit.pausePollingLatest();
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              state.isEmpty
                  ? const SizedBox.shrink()
                  : ToggleButtons(
                      constraints:
                          BoxConstraints(maxHeight: 30.h, minWidth: 50.w),
                      isSelected: List.generate(
                        timeOptions.length,
                        (index) => index == _selectedPeriodIndex,
                      ),
                      onPressed: (index) async {
                        if (index == _selectedPeriodIndex) return;
                        if (state.isLoading) return;

                        setState(() {
                          _selectedPeriodIndex = index;
                          _timeframe = _timeframeValues[index]; 
                        });

                        try {
                          await _candleCubit
                              .updateBar(_timePeriodValues[index]);
                        } catch (e) {
                          
                          if (mounted) {
                            setState(() {
                              _selectedPeriodIndex = index;
                            });
                          }
                        }
                      },
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      borderColor: Colors.transparent,
                      selectedBorderColor: Colors.transparent,
                      color: AppColors.textSecondary(context),
                      selectedColor: AppColors.textPrimary(context),
                      fillColor: Colors.transparent,
                      children: List.generate(
                        timeOptions.length,
                        (index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: index == _selectedPeriodIndex
                                  ? AppColors.surface(context)
                                  : Colors.transparent,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 3.h),
                            child: Text(
                              timeOptions[index],
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: index == _selectedPeriodIndex
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  color: AppColors.textPrimary(context)),
                            ),
                          );
                        },
                      )),
              CandlestickContent(
                timeframe: _timeframe,
                candles: state.candles,
              ),
            ],
          ));
    });
  }
}

class CandlestickContent extends StatelessWidget {
  const CandlestickContent(
      {super.key, required this.timeframe, required this.candles});

  final Timeframe timeframe;
  final List<KLineEntity> candles;

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<CandleCubit, CandleState>(builder: (context, state) {
    //   if (state.loadingState == CandlestickLoadingState.loading) {
    //     return const Center(
    //       child: CircularProgressIndicator(
    //         color: AppColors.primary,
    //       ),
    //     );
    //   }

    //   if (state.loadingState == CandlestickLoadingState.error ||
    //       state.candles.isEmpty) {
    //     return const SizedBox.shrink();
    //   }

    //   return CandlestickChartWidget(
    //     data: state.candles,
    //     timeframe: timeframe,
    //   );
    // });

    return BlocSelector<CandleCubit, CandleState, CandlestickLoadingState>(
        selector: (state) => state.loadingState,
        builder: (context, loadingState) {
          if (loadingState == CandlestickLoadingState.loading) {
            return SizedBox(
              height: 250.h,
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              ),
            );
          }

          if (loadingState == CandlestickLoadingState.error ||
              candles.isEmpty) {
            return const SizedBox.shrink();
          }

          return SizedBox(
            height: 250.h,
            child: CandlestickChartWidget(
              data: candles,
              timeframe: timeframe,
            ),
          );
        });
  }
}
