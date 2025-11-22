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
          child: Column(
            children: [
              _buildSignTypeChoice(context),
              Expanded(
                child: Container(
                  color: AppColors.card(context),
                  child: Stack(
                    children: [
                      IntelList(
                        scrollKey: const PageStorageKey('signal_intel_list'),
                        intelligences: state.singleIntelligences,
                        visibleIds: state.visibleIds,
                        isLoading: state.isFetchingSingleMore,
                        isNotMore: state.isNotSingleMore,
                        onRefresh: () {
                          context
                              .read<IntelCubit>()
                              .refreshSingleIntelligence();
                        },
                        onLoad: () {
                          context
                              .read<IntelCubit>()
                              .getSingleIntelligence(state.singleId);
                        },
                      ),
                      // if (_showUnreadBar)
                      //   const Positioned(
                      //     top: 0,
                      //     right: 0,
                      //     left: 0,
                      //     child: Align(
                      //       alignment: Alignment.topCenter,
                      //       child: IntelUnreadBar(),
                      //     ),
                      //   )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildSignTypeChoice(BuildContext context) {
    final singleTypeChoices =
        context.watch<OptionsCubit>().state.singleTypeChoices();
    final selectedId = context.watch<IntelCubit>().state.singleId;
    return BlocBuilder<IntelCubit, IntelState>(builder: (context, state) {
      return ExpandableScrollableWrap(
          spacing: 10.w,
          runSpacing: 10.h,
          padding: EdgeInsetsGeometry.only(
              left: 12.w, right: 12.w, top: 10.h, bottom: 6.h),
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
}
