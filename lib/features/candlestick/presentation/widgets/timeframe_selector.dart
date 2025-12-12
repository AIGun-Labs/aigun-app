import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/timeframe.dart';
import '../cubit/candlestick/candlestick_cubit.dart';
import '../cubit/candlestick/candlestick_state.dart';
import '../cubit/selection/selection_params_cubit.dart';
import '../cubit/selection/selection_params_state.dart';
import 'timeframe_button.dart';

class TimeframeSelector extends StatelessWidget {
  const TimeframeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CandlestickCubit, CandlestickState>(
      builder: (context, candlestickState) {
        final source = candlestickState.source;
        final allTimeframes = source.supportedTimeframes;

        return BlocBuilder<SelectionParamsCubit, SelectionParamsState>(
          builder: (context, selectionState) {
            final selectedTimeframe = selectionState.selectedTimeframe;

            return Row(
              children: [
                ...allTimeframes.map(
                  (timeframe) => TimeframeButton(
                    timeframe: timeframe,
                    isSelected: selectedTimeframe == timeframe,
                    onPressed: () => _onTimeframeSelected(context, timeframe),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _onTimeframeSelected(BuildContext context, Timeframe timeframe) {
    BlocProvider.of<SelectionParamsCubit>(context).updateTimeframe(timeframe);
  }
}
