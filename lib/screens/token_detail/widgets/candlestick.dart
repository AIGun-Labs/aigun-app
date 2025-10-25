import 'package:flutter/material.dart';
import 'package:flutter_aigun/core/service_locator.dart';
import 'package:flutter_aigun/cubits/candle/candle_cubit.dart';
import 'package:flutter_aigun/cubits/candle/candle_state.dart';
import 'package:flutter_aigun/data/models/candle/candle.dart';
import 'package:flutter_aigun/l10n/l10n.dart' as app_l10n;
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:k_chart/flutter_k_chart.dart';

class Candlestick extends StatefulWidget {
  const Candlestick({super.key});

  @override
  State<Candlestick> createState() => _CandlestickState();
}

class _CandlestickState extends State<Candlestick> {
  late final CandleCubit _candleCubit;
  int _selectedPeriodIndex = 1;

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

  List<KLineEntity> _convertToKLineEntity(List<Candle> candles) {
    final list = <KLineEntity>[];

    for (var candle in candles) {
      try {
        final timestamp = int.tryParse(candle.time) ?? 0;
        final open = double.tryParse(candle.open) ?? 0.0;
        final high = double.tryParse(candle.high) ?? 0.0;
        final low = double.tryParse(candle.low) ?? 0.0;
        final close = double.tryParse(candle.close) ?? 0.0;
        final volume = double.tryParse(candle.volume) ?? 0.0;

        list.add(KLineEntity.fromCustom(
          time: timestamp,
          open: open,
          high: high,
          low: low,
          close: close,
          vol: volume,
        ));
      } catch (e) {
        // 忽略转换失败的数据
        continue;
      }
    }

    // 计算技术指标
    if (list.isNotEmpty) {
      DataUtil.calculate(list);
    }

    return list;
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

  // 时间周期映射表：索引对应的 bar 值（分钟数）
  final List<int> _timePeriodValues = [
    60, // 1分钟
    5 * 60, // 5分钟
    15 * 60, // 15分钟
    60 * 60, // 1小时
    4 * 60 * 60, // 4小时
    24 * 60 * 60, // 日线（24小时 * 60分钟）
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CandleCubit, CandleState>(
      bloc: _candleCubit,
      builder: (context, candleState) {
        final klineData = _convertToKLineEntity(candleState.candles);

        return Container(
          child:
              BlocBuilder<CandleCubit, CandleState>(builder: (context, state) {
            final timeOptions = _getTimeOptions(context);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ToggleButtons(
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
                      });
                      await _candleCubit.updateBar(_timePeriodValues[index]);
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
                            // color: AppColors.surface(context),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 3.h),
                          child: Text(timeOptions[index]),
                        );
                      },
                    )),
                Divider(
                  height: 1.h,
                  color: AppColors.border(context),
                ),
                SizedBox(
                  height: 330.h,
                  child: state.isLoading && klineData.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        )
                      : klineData.isEmpty
                          ? const SizedBox.shrink()
                          : KChartWidget(
                              // isChinese: true,
                              // translations: kChartTranslations,
                              klineData,
                              onLoadMore: (bool isLoadingMore) async {
                                await _candleCubit.loadMoreLoad();
                              },
                              ChartStyle(),
                              ChartColors()
                                ..hCrossColor = AppColors.primary
                                ..vCrossColor =
                                    Colors.black.withValues(alpha: 0.1)
                                ..crossTextColor = Colors.white
                                ..bgColor = [Colors.white, Colors.white]
                                ..gridColor = Colors.transparent,
                              isLine: false,
                              mainState: MainState.NONE,
                              volHidden: false,
                              secondaryState: SecondaryState.NONE,
                              timeFormat: TimeFormat.YEAR_MONTH_DAY,
                              fixedLength: 2,
                              isTrendLine: false,
                            ),
                ),
              ],
            );
          }),
        );
      },
    );
  }
}
