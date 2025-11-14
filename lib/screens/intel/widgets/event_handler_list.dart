import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/intel/intel_cubit.dart';
import 'package:flutter_aigun/cubits/intel/intel_state.dart';
import 'package:flutter_aigun/screens/intel/intel.dart';
import 'package:flutter_aigun/screens/intel/widgets/intel_list.dart';
import 'package:flutter_aigun/screens/intel/widgets/top_header.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventHandlerList extends StatelessWidget {
  const EventHandlerList(
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
                      intels: state.allMessages ?? [],
                      visibleIds: state.visibleIds,
                      isLoading: state.isLoading,
                      isNotMore: state.isNotMore,
                      onRefresh: () {
                        // context
                        //     .read<IntelCubit>()
                        //     .startPollingTokensByIntelIds();
                        context.read<IntelCubit>().refreshIntels();
                      },
                      onLoad: () {
                        context.read<IntelCubit>().getIntelsHistory();
                      },
                    ),
                    if (showUnreadBar)
                      Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: IntelUnreadBar(
                              scrollController: scrollController),
                        ),
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
