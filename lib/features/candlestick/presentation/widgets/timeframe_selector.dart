import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/candle_source.dart';
import '../../../../core/enums/timeframe.dart';
import '../cubit/selection/selection_params_cubit.dart';
import '../cubit/selection/selection_params_state.dart';
import 'timeframe_button.dart';
import 'timeframe_selector_bottom_sheet.dart';

class TimeframeSelector extends StatefulWidget {
  const TimeframeSelector({super.key, required this.source});

  final CandleSource source;

  /// All timeframes that can be shown as buttons
  /// TODO: 暂时隐藏 h4, d1, w1
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

  /// Get available timeframes based on source
  static List<Timeframe> getAvailableTimeframes(CandleSource source) {
    if (source == CandleSource.cmc) {
      return allTimeframes
          .where((t) => t != Timeframe.m1 && t != Timeframe.m5)
          .toList();
    }
    return allTimeframes;
  }

  @override
  State<TimeframeSelector> createState() => _TimeframeSelectorState();
}

class _TimeframeSelectorState extends State<TimeframeSelector> {
  late List<Timeframe> _availableTimeframes;
  late int _visibleCount;
  late List<GlobalKey> _buttonKeys;
  // final GlobalKey _moreButtonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _updateAvailableTimeframes();
  }

  @override
  void didUpdateWidget(TimeframeSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.source != widget.source) {
      _updateAvailableTimeframes();
    }
  }

  void _updateAvailableTimeframes() {
    _availableTimeframes = TimeframeSelector.getAvailableTimeframes(
      widget.source,
    );
    _visibleCount = _availableTimeframes.length;
    _buttonKeys = List.generate(
      _availableTimeframes.length,
      (_) => GlobalKey(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectionParamsCubit, SelectionParamsState>(
      builder: (context, state) {
        final selectedTimeframe = state.selectedTimeframe;
        // final visibleTimeframes = _availableTimeframes
        //     .take(_visibleCount)
        //     .toList();
        // final hiddenTimeframes =
        //     _availableTimeframes.skip(_visibleCount).toList();
        // final isSelectedInVisible = visibleTimeframes.contains(selectedTimeframe);
        // final hasOverflow = hiddenTimeframes.isNotEmpty;

        final displayTimeframe =
            (widget.source == CandleSource.cmc &&
                (selectedTimeframe == Timeframe.m1 ||
                    selectedTimeframe == Timeframe.m5))
            ? Timeframe.m15
            : selectedTimeframe;

        // final visibleTimeframes = _availableTimeframes
        //     .take(_visibleCount)
        //     .toList();

        return LayoutBuilder(
          builder: (context, constraints) {
            // 在下一帧计算可见按钮数量
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _calculateVisibleButtons(constraints.maxWidth);
            });

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ..._availableTimeframes.asMap().entries.map(
                    (entry) => TimeframeButton(
                      key: _buttonKeys[entry.key], // 声明 Key
                      timeframe: entry.value,
                      isSelected: displayTimeframe == entry.value,
                      onPressed: () =>
                          _onTimeframeSelected(context, entry.value),
                    ),
                  ),
                  // if (hasOverflow)
                  //   MoreButton(
                  //     key: _moreButtonKey,
                  //     isHighlighted: !isSelectedInVisible,
                  //     selectedTimeframe:
                  //         isSelectedInVisible ? null : selectedTimeframe,
                  //     onPressed: () => _showMoreSheet(context, selectedTimeframe),
                  //   ),
                ],
              ),
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
      // 获取每一个 button 的 key
      final key = _buttonKeys[i];
      // 获取 Key 的上下文 
      final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox == null) continue;

      final buttonWidth = renderBox.size.width;
      final remainingSpace = maxWidth - totalWidth;

      // 检查是否需要为 More 按钮留空间
      final needsMore = i < _buttonKeys.length - 1;
      final requiredSpace = needsMore
          ? buttonWidth + moreButtonWidth
          : buttonWidth;

      if (remainingSpace >= requiredSpace) {
        totalWidth += buttonWidth;
        count++;
      } else {
        break;
      }
    }

    // 至少显示一个按钮
    count = count.clamp(1, _availableTimeframes.length);

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
      availableTimeframes: _availableTimeframes,
      onSelected: (timeframe) {
        BlocProvider.of<SelectionParamsCubit>(
          context,
        ).updateTimeframe(timeframe);
        Navigator.of(context).pop();
      },
    );
  }
}
