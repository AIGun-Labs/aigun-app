import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:k_chart/entity/k_line_entity.dart';

import '../../../../core/enums/timeframe.dart';
import '../../../../l10n/l10n.dart' as app_l10n;
import '../../../../shared/presentation/widgets/candlestick.dart';
import '../../../../themes/colors.dart';
import '../cubits/candle/candle_cubit.dart';
import '../cubits/candle/candle_state.dart';

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
    _candleCubit = BlocProvider.of<CandleCubit>(context);
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

  // 时间周期映射表：索引对应的 bar 值（秒数）
  final List<int> _timePeriodValues = [
    60, // 1分钟
    5 * 60, // 5分钟
    15 * 60, // 15分钟
    60 * 60, // 1小时
    4 * 60 * 60, // 4小时
    24 * 60 * 60, // 日线（24小时 * 60分钟）
  ];

  // 时间周期映射表：索引对应的 Timeframe 枚举
  final List<Timeframe> _timeframeValues = [
    Timeframe.m1, // 1分钟
    Timeframe.m5, // 5分钟
    Timeframe.m15, // 15分钟
    Timeframe.h1, // 1小时
    Timeframe.h4, // 4小时
    Timeframe.d1, // 1天
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CandleCubit, CandleState>(
      builder: (context, state) {
        final timeOptions = _getTimeOptions(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            state.isEmpty
                ? const SizedBox.shrink()
                : ToggleButtons(
                    constraints: BoxConstraints(
                      maxHeight: 30.w,
                      minWidth: 50.w,
                    ),
                    isSelected: List.generate(
                      timeOptions.length,
                      (index) => index == _selectedPeriodIndex,
                    ),
                    onPressed: (index) async {
                      if (index == _selectedPeriodIndex) return;
                      if (state.isLoading) return;

                      setState(() {
                        _selectedPeriodIndex = index;
                        _timeframe = _timeframeValues[index]; // 更新 timeframe
                      });

                      try {
                        await _candleCubit.updateBar(_timePeriodValues[index]);
                      } catch (e) {
                        // 如果更新失败，恢复之前的选择
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
                    children: List.generate(timeOptions.length, (index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: index == _selectedPeriodIndex
                              ? AppColors.surface(context)
                              : Colors.transparent,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 3.w,
                        ),
                        child: Text(
                          timeOptions[index],
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: index == _selectedPeriodIndex
                                ? FontWeight.w600
                                : FontWeight.w400,
                            color: AppColors.textPrimary(context),
                          ),
                        ),
                      );
                    }),
                  ),
            CandlestickContent(timeframe: _timeframe, candles: state.candles),
          ],
        );
      },
    );
  }
}

class CandlestickContent extends StatelessWidget {
  const CandlestickContent({
    super.key,
    required this.timeframe,
    required this.candles,
  });

  final Timeframe timeframe;
  final List<KLineEntity> candles;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CandleCubit, CandleState, CandlestickLoadingState>(
      selector: (state) => state.loadingState,
      builder: (context, state) {
        if (state == CandlestickLoadingState.loading) {
          return SizedBox(
            height: 250.h,
            child: const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        }

        if (state == CandlestickLoadingState.error || candles.isEmpty) {
          return const SizedBox.shrink();
        }

        return SizedBox(
          height: 300.h,
          child: CandlestickChartWidget(data: candles, timeframe: timeframe),
        );
      },
    );
  }
}
