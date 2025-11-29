import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constant/intel_type.dart';
import '../../../cubits/intel/intel_cubit.dart';
import '../../../cubits/intel/intel_state.dart';
import 'intel_list.dart';

class EventHandlerList extends StatefulWidget {
  const EventHandlerList({
    super.key,
    this.pageStorageKey,
  });

  final Key? pageStorageKey;

  @override
  State<EventHandlerList> createState() => _EventHandlerListState();
}

class _EventHandlerListState extends State<EventHandlerList> {
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
        return IntelList(
          scrollKey: widget.pageStorageKey,
          intelligences: state.eventIntelligences,
          visibleIds: state.visibleIds,
          isLoading: state.isFetchingMore,
          isNotMore: state.isNotMore,
          onRefresh: () async {
            await context.read<IntelCubit>().refreshEventIntelligence();
          },
          unreadBarFilter: (intel) =>
              IntellgenceTypes.EVENT_LIST.contains(intel.type),
          onLoad: () {
            context.read<IntelCubit>().getEventIntelligence();
          },
        );
      },
    );
  }
}
