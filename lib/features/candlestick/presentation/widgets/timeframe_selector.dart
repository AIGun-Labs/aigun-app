import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/timeframe.dart';
import '../cubit/selection/selection_params_cubit.dart';
import '../cubit/selection/selection_params_state.dart';
import 'more_button.dart';
import 'settings_button.dart';
import 'timeframe_button.dart';
import 'timeframe_selector_bottom_sheet.dart';

class TimeframeSelector extends StatelessWidget {
  const TimeframeSelector({super.key, this.onSettingsPressed});

  final VoidCallback? onSettingsPressed;

  /// Primary timeframes shown as buttons
  static const List<Timeframe> primaryTimeframes = [
    Timeframe.m1,
    Timeframe.m15,
    Timeframe.h1,
    Timeframe.d1,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectionParamsCubit, SelectionParamsState>(
      builder: (context, state) {
        final selectedTimeframe = state.selectedTimeframe;
        final isSelectedInPrimary = primaryTimeframes.contains(
          selectedTimeframe,
        );

        return Row(
          children: [
            ...primaryTimeframes.map(
              (timeframe) => TimeframeButton(
                timeframe: timeframe,
                isSelected: selectedTimeframe == timeframe,
                onPressed: () => _onTimeframeSelected(context, timeframe),
              ),
            ),
            MoreButton(
              isHighlighted: !isSelectedInPrimary,
              selectedTimeframe: isSelectedInPrimary ? null : selectedTimeframe,
              onPressed: () => _showMoreSheet(context, selectedTimeframe),
            ),
            const Spacer(),
            SettingsButton(onPressed: onSettingsPressed),
          ],
        );
      },
    );
  }

  void _onTimeframeSelected(BuildContext context, Timeframe timeframe) {
    BlocProvider.of<SelectionParamsCubit>(context).updateTimeframe(timeframe);
  }

  void _showMoreSheet(BuildContext context, Timeframe currentSelection) {
    showTimeframeSelectorBottomSheet(
      context: context,
      currentSelection: currentSelection,
      onSelected: (timeframe) {
        BlocProvider.of<SelectionParamsCubit>(
          context,
        ).updateTimeframe(timeframe);
        Navigator.of(context).pop();
      },
    );
  }
}
