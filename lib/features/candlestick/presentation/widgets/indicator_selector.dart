import 'package:candlestick/candlestick_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../themes/colors.dart';
import '../cubit/selection/selection_params_cubit.dart';
import '../cubit/selection/selection_params_state.dart';
import 'indicator_button.dart';

class IndicatorSelector extends StatelessWidget {
  const IndicatorSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectionParamsCubit, SelectionParamsState>(
      builder: (context, state) {
        final cubit = context.read<SelectionParamsCubit>();

        return Align(
          alignment: Alignment.centerLeft,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                // // 主图指标
                ...MainState.values.map(
                  (indicator) => IndicatorButton(
                    label: indicator.name,
                    isSelected: state.mainStates.contains(indicator),
                    onPressed: () => cubit.toggleMainState(indicator),
                  ),
                ),
                // 分隔符
                _buildDivider(context),
                // // VOL 按钮
                IndicatorButton(
                  label: 'VOL',
                  isSelected: !state.volHidden,
                  onPressed: () => cubit.toggleVolHidden(),
                ),
                // 副图指标
                ...SecondaryState.values.map(
                  (indicator) => IndicatorButton(
                    label: indicator.name,
                    isSelected: state.secondaryStates.contains(indicator),
                    onPressed: () => cubit.toggleSecondaryState(indicator),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      height: 16.h,
      width: 1,
      color: AppColors.textQuaternary(context),
    );
  }
}
