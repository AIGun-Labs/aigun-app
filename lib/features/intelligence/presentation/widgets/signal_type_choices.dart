import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../cubits/options/option_cubit.dart';
import '../../../../l10n/l10n.dart';
import '../../../../shared/domain/entities/choice_item_entity.dart';
import '../../../../shared/presentation/widgets/multiple_choice.dart';
import '../cubits/signal_list/signal_list_cubit.dart';
import '../cubits/signal_list/signal_list_state.dart';

/// Signal Type Choices Widget
///
/// Filter chips for selecting signal types (chains).
class SignalTypeChoicesWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const SignalTypeChoicesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final singleTypeChoices = BlocProvider.of<OptionsCubit>(
      context,
    ).state.singleTypeChoices();

    return BlocBuilder<SignalListCubit, SignalListState>(
      builder: (context, state) {
        return ExpandableScrollableWrap(
          spacing: 10.w,
          runSpacing: 10.h,
          backgroundColor: Colors.white,
          padding: EdgeInsets.only(
            left: 12.w,
            right: 12.w,
            top: 10.h,
            bottom: 6.h,
          ),
          selectedValue: state.chainId,
          onSelected: (value) {
            if (state.isLoading || state.isLoadingMore) {
              return;
            }
            BlocProvider.of<SignalListCubit>(context).changeChain(value);
          },
          items: [
            ChoiceItemEntity(
              name: NameType.text(S.of(context).all),
              label: S.of(context).all,
              value: 'all',
            ),
            ...singleTypeChoices,
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize {
    // Calculate the height based on the content's styling
    final double height = (12.sp * 1.2) + (6.h * 2) + 10.h + 6.h;
    return Size.fromHeight(height);
  }
}
