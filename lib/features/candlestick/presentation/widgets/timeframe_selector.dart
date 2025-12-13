import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/timeframe.dart';
import '../cubit/selection/selection_params_cubit.dart';
import '../cubit/selection/selection_params_state.dart';
import 'more_button.dart';
import 'timeframe_button.dart';
import 'timeframe_selector_bottom_sheet.dart';

class TimeframeSelector extends StatefulWidget {
  const TimeframeSelector({super.key});

  /// All timeframes that can be shown as buttons
  static const List<Timeframe> allTimeframes = [
    Timeframe.m1,
    Timeframe.m5,
    Timeframe.m15,
    Timeframe.m30,
    Timeframe.h1,
    Timeframe.h4,
    Timeframe.d1,
    Timeframe.w1,
  ];

  @override
  State<TimeframeSelector> createState() => _TimeframeSelectorState();
}

class _TimeframeSelectorState extends State<TimeframeSelector> {
  int _visibleCount = TimeframeSelector.allTimeframes.length;
  final List<GlobalKey> _buttonKeys = List.generate(
    TimeframeSelector.allTimeframes.length,
    (_) => GlobalKey(),
  );
  final GlobalKey _moreButtonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectionParamsCubit, SelectionParamsState>(
      builder: (context, state) {
        final selectedTimeframe = state.selectedTimeframe;
        final visibleTimeframes =
            TimeframeSelector.allTimeframes.take(_visibleCount).toList();
        final hiddenTimeframes =
            TimeframeSelector.allTimeframes.skip(_visibleCount).toList();
        final isSelectedInVisible = visibleTimeframes.contains(selectedTimeframe);
        final hasOverflow = hiddenTimeframes.isNotEmpty;

        return LayoutBuilder(
          builder: (context, constraints) {
            // 在下一帧计算可见按钮数量
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _calculateVisibleButtons(constraints.maxWidth);
            });

            return Row(
              children: [
                ...visibleTimeframes.asMap().entries.map(
                      (entry) => TimeframeButton(
                        key: _buttonKeys[entry.key],
                        timeframe: entry.value,
                        isSelected: selectedTimeframe == entry.value,
                        onPressed: () =>
                            _onTimeframeSelected(context, entry.value),
                      ),
                    ),
                if (hasOverflow)
                  MoreButton(
                    key: _moreButtonKey,
                    isHighlighted: !isSelectedInVisible,
                    selectedTimeframe:
                        isSelectedInVisible ? null : selectedTimeframe,
                    onPressed: () => _showMoreSheet(context, selectedTimeframe),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  void _calculateVisibleButtons(double maxWidth) {
    double totalWidth = 0;
    int count = 0;
    const moreButtonWidth = 60.0; // 预估 More 按钮宽度

    for (int i = 0; i < _buttonKeys.length; i++) {
      final key = _buttonKeys[i];
      final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox == null) continue;

      final buttonWidth = renderBox.size.width;
      final remainingSpace = maxWidth - totalWidth;

      // 检查是否需要为 More 按钮留空间
      final needsMore = i < _buttonKeys.length - 1;
      final requiredSpace = needsMore ? buttonWidth + moreButtonWidth : buttonWidth;

      if (remainingSpace >= requiredSpace) {
        totalWidth += buttonWidth;
        count++;
      } else {
        break;
      }
    }

    // 至少显示一个按钮
    count = count.clamp(1, TimeframeSelector.allTimeframes.length);

    if (count != _visibleCount) {
      setState(() {
        _visibleCount = count;
      });
    }
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
