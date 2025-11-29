import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constant/intel_type.dart';
import '../../../cubits/intel/intel_cubit.dart';
import '../../../cubits/intel/intel_state.dart';
import 'intel_list.dart';
import 'unread_bar.dart';

class EventHandlerList extends StatefulWidget {
  const EventHandlerList({super.key, this.pageStorageKey});

  final Key? pageStorageKey;

  @override
  State<EventHandlerList> createState() => _EventHandlerListState();
}

class _EventHandlerListState extends State<EventHandlerList> {
  final bool _showUnreadBar = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IntelCubit, IntelState>(
      buildWhen: (previous, current) {
        return previous.eventIntelligences != current.eventIntelligences ||
            previous.isFetchingMore != current.isFetchingMore ||
            previous.isNotMore != current.isNotMore ||
            previous.unreadIntels != current.unreadIntels;
      },
      builder: (context, state) {
        return Column(
          children: [
            if (_showUnreadBar)
              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: IntelUnreadBar(
                      scrollController: PrimaryScrollController.of(context),
                      filter: (intel) =>
                          IntellgenceTypes.EVENT_LIST.contains(intel.type),
                    ),
                  )),
            Expanded(
                child: IntelList(
              scrollKey: widget.pageStorageKey,
              intelligences: state.eventIntelligences,
              visibleIds: state.visibleIds,
              isLoading: state.isFetchingMore,
              isNotMore: state.isNotMore,
              onRefresh: () async {
                await context.read<IntelCubit>().refreshEventIntelligence();
              },
              onLoad: () {
                context.read<IntelCubit>().getEventIntelligence();
              },
            ))
          ],
        );
      },
    );
  }
}
