import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/intel/intel_cubit.dart';
import 'package:flutter_aigun/cubits/intel/intel_state.dart';
import 'package:flutter_aigun/screens/intel/intel.dart';
import 'package:flutter_aigun/screens/intel/widgets/intel_list.dart';
import 'package:flutter_aigun/screens/intel/widgets/top_header.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignalIntelList extends StatelessWidget {
  const SignalIntelList(
      {super.key, required this.scrollController, required this.showUnreadBar});
  final ScrollController scrollController;
  final bool showUnreadBar;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IntelCubit, IntelState>(
      builder: (context, state) {
        return Column(
          children: [
            // LatestDiscoveriesSection(scrollController: scrollController),
            Expanded(
              child: Container(
                color: AppColors.card(context),
                child: Stack(
                  children: [
                    IntelList(
                      scrollController: scrollController,
                      intelligences: state.singleIntelligences,
                      visibleIds: state.visibleIds,
                      isLoading: state.isFetchingMore,
                      isNotMore: state.isNotMore,
                      onRefresh: () {
                        context.read<IntelCubit>().refreshSingleIntelligence();
                      },
                      onLoad: () {
                        context
                            .read<IntelCubit>()
                            .getSingleIntelligence(state.singleId);
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
