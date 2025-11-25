import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../cubits/intel/intel_cubit.dart';
import '../../../cubits/intel/intel_state.dart';
import '../../../cubits/options/option_cubit.dart';
import '../../../l10n/l10n.dart';
import '../../../shared/presentation/widgets/multiple_choice.dart';
import '../../../themes/themes.dart';
import 'intel_list.dart';

class SignalIntelList extends StatefulWidget {
  const SignalIntelList({super.key});

  @override
  State<SignalIntelList> createState() => _SignalIntelListState();
}

class _SignalIntelListState extends State<SignalIntelList> {
  bool _showUnreadBar = false;

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      final currentScroll = notification.metrics.pixels;
      if (currentScroll >= 500) {
        if (!_showUnreadBar) setState(() => _showUnreadBar = true);
      } else {
        if (_showUnreadBar) setState(() => _showUnreadBar = false);
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IntelCubit, IntelState>(
      builder: (context, state) {
        return NotificationListener<ScrollNotification>(
          onNotification: _handleScrollNotification,
          child: Container(
            color: AppColors.card(context),
            child: IntelList(
              scrollKey: const PageStorageKey('signal_intel_list'),
              intelligences: state.singleIntelligences,
              visibleIds: state.visibleIds,
              isLoading: state.isFetchingSingleMore,
              isNotMore: state.isNotSingleMore,
              onRefresh: () {
                context.read<IntelCubit>().refreshSingleIntelligence();
              },
              onLoad: () {
                context
                    .read<IntelCubit>()
                    .getSingleIntelligence(state.singleId);
              },
            ),
          ),
        );
      },
    );
  }

}
