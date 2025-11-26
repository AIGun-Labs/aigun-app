import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../cubits/index.dart';
import '../../../cubits/options/option_cubit.dart';
import '../../../l10n/l10n.dart';
import '../../../shared/presentation/widgets/multiple_choice.dart';

class SingleTypeChoices extends StatelessWidget implements PreferredSizeWidget {
  const SingleTypeChoices({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final singleTypeChoices =
        context.watch<OptionsCubit>().state.singleTypeChoices();
    final selectedId = context.watch<IntelCubit>().state.singleId;
    return BlocBuilder<IntelCubit, IntelState>(builder: (context, state) {
      return ExpandableScrollableWrap(
          spacing: 10.w,
          runSpacing: 10.h,
          backgroundColor: Colors.white,
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
  Size get preferredSize {
    // Calculate the height based on the content's styling:
    // Text: 12.sp * 1.2 (line height)
    // Chip Padding: 6.h * 2 (vertical)
    // Container Padding: 10.h (top) + 6.h (bottom)
    final double height = (12.sp * 1.2) + (6.h * 2) + 10.h + 6.h;
    return Size.fromHeight(height);
  }
}
