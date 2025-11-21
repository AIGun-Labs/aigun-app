import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/intel/intel_cubit.dart';
import '../../../cubits/intel/intel_state.dart';
import '../../../themes/themes.dart';
import 'intel_list.dart';

class EventHandlerList extends StatefulWidget {
  const EventHandlerList({super.key});

  @override
  State<EventHandlerList> createState() => _EventHandlerListState();
}

class _EventHandlerListState extends State<EventHandlerList> {
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
              // LatestDiscoveriesSection(scrollController: scrollController),
              Expanded(
                child: Container(
                  color: AppColors.card(context),
                  child: Stack(
                    children: [
                      IntelList(
                        scrollKey: const PageStorageKey('event_handler_list'),
                        intelligences: state.eventIntelligences,
                        visibleIds: state.visibleIds,
                        isLoading: state.isFetchingMore,
                        isNotMore: state.isNotMore,
                        onRefresh: () {
                          context.read<IntelCubit>().refreshEventIntelligence();
                        },
                        onLoad: () {
                          context.read<IntelCubit>().getEventIntelligence();
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
}
