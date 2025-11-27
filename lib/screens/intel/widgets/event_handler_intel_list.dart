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
  ScrollController? _scrollController;

  bool _showUnreadBar = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 仅获取 Controller 用于传递给子组件以保持联动，但不进行监听
    final newController = PrimaryScrollController.of(context);
    if (_scrollController != newController) {
      _scrollController = newController;
    }
  }

  @override
  void dispose() {
    // 不需要移除监听，也不要 dispose
    super.dispose();
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
              NotificationListener<ScrollUpdateNotification>(
                onNotification: (notification) {
                  // 只有当滚动深度为0（即当前列表滚动，而非嵌套列表）时才处理
                  if (notification.depth == 0) {
                    final currentScroll = notification.metrics.pixels;
                    if (currentScroll >= 500) {
                      if (!_showUnreadBar)
                        setState(() => _showUnreadBar = true);
                    } else {
                      if (_showUnreadBar)
                        setState(() => _showUnreadBar = false);
                    }
                  }
                  return false;
                },
                child: IntelList(
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
