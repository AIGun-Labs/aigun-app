import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constant/intel_type.dart';
import '../../../cubits/intel/intel_cubit.dart';
import '../../../cubits/intel/intel_state.dart';
import '../../../themes/themes.dart';
import 'intel_list.dart';
import 'unread_bar.dart';

class EventHandlerList extends StatefulWidget {
  const EventHandlerList({super.key});

  @override
  State<EventHandlerList> createState() => _EventHandlerListState();
}

class _EventHandlerListState extends State<EventHandlerList> {
  final ScrollController _scrollController = ScrollController();

  bool _showUnreadBar = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

// 处理滚动事件
  void _handleScroll() {
    final currentScroll = _scrollController.offset;

    if (currentScroll >= 500) {
      if (!_showUnreadBar) setState(() => _showUnreadBar = true);
    } else {
      if (_showUnreadBar) setState(() => _showUnreadBar = false);
    }
  }

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
        return Container(
          color: AppColors.card(context),
          child: Stack(
            children: [
              IntelList(
                scrollController: _scrollController,
                scrollKey: const PageStorageKey('event_handler_list'),
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
              ),
              if (_showUnreadBar)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: IntelUnreadBar(
                      scrollController: _scrollController,
                      filter: (intel) =>
                          IntellgenceTypes.EVENT_LIST.contains(intel.type),
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
