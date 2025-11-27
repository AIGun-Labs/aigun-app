import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../cubits/intel/intel_cubit.dart';
import '../../../../cubits/intel/intel_state.dart';
import '../../../../cubits/options/option_cubit.dart';
import '../../../../l10n/l10n.dart';
import '../../../../shared/presentation/widgets/multiple_choice.dart';

class SignalTypeChoices extends StatelessWidget implements PreferredSizeWidget {
  const SignalTypeChoices({super.key});

  @override
  Widget build(BuildContext context) {
    final singleTypeChoices =
        context.watch<OptionsCubit>().state.singleTypeChoices();
    final selectedId = context.watch<IntelCubit>().state.singleId;
    return BlocBuilder<IntelCubit, IntelState>(builder: (context, state) {
      return ExpandableScrollableWrap(
          spacing: 10.w,
          runSpacing: 10.h,
          padding:
              EdgeInsets.only(left: 12.w, right: 12.w, top: 10.h, bottom: 6.h),
          selectedValue: selectedId,
          onSelected: (value) {
            if (state.isFetchingSingleMore) {
              return;
            }
            context.read<IntelCubit>().updateSingleId(value);
          },
          items: [
            ChoiceItem(label: S.of(context).all, value: 'all'),
            ...singleTypeChoices
          ]);
    });
  }

  @override
  Size get preferredSize => Size.fromHeight(30.h);
}
