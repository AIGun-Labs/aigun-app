import "package:flutter/material.dart";
import "package:flutter_aigun/cubits/index.dart";
import "package:flutter_aigun/screens/intel/widgets/intel_item.dart";
import "package:flutter_aigun/screens/intel/widgets/refresh_header.dart";
import "package:flutter_aigun/themes/colors.dart";
import "package:flutter_aigun/utils/logger.dart";
import "package:flutter_aigun/widgets/token_skeleton.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pull_to_refresh/pull_to_refresh.dart";
import "package:visibility_detector/visibility_detector.dart";

class IntelList extends StatefulWidget {
  final ScrollController? scrollController;

  const IntelList({super.key, this.scrollController});

  @override
  State<IntelList> createState() => _IntelListState();
}

class _IntelListState extends State<IntelList> {
  late RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Future<void> _onLoading() async {
    if (!mounted) return;

    try {
      await context.read<IntelCubit>().getIntelsHistory();
      if (mounted) {
        final state = context.read<IntelCubit>().state;
        if (state.isNotMore) {
          _refreshController.loadNoData();
        } else {
          _refreshController.loadComplete();
        }
      }
    } catch (e) {
      Logger.error("_onLoading error: $e");
      if (mounted) {
        _refreshController.loadFailed();
      }
    }
  }

  void _onRefresh() async {
    if (!mounted) return;

    try {
      await context.read<IntelCubit>().refreshIntels();
      if (mounted) {
        _refreshController.refreshCompleted();
      }
    } catch (e) {
      Logger.error("refreshIntels error: $e");
      if (mounted) {
        _refreshController.refreshFailed();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IntelCubit, IntelState>(builder: (context, state) {
      // 如果正在加载数据并没有数据，则显示加载中
      if (state.isFetchingMore && state.allMessages?.isEmpty == true) {
        return Container(
          color: AppColors.white,
          child: const IntelSkeleton(itemCount: 3),
        );
      }

      return SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        footer: const ClassicFooter(),
        header: const CustomRefreshHeader(),
        controller: _refreshController,
        onLoading: _onLoading,
        onRefresh: _onRefresh,
        physics: const AlwaysScrollableScrollPhysics(),
        child: state.allMessages?.isEmpty == true
            ? const Center(child: Text('暂无数据'))
            : ListView.separated(
                controller: widget.scrollController,
                itemCount: state.allMessages?.length ?? 0,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    color: AppColors.card(context),
                    thickness: 10,
                    height: 10,
                    // indent: 16, //
                    // endIndent: 16,
                  );
                },
                itemBuilder: (context, index) {
                  final message = state.allMessages?[index];
                  if (message == null) {
                    return const SizedBox.shrink();
                  }

                  return VisibilityDetector(
                      key: Key(message.id ?? ''),
                      child: IntelMessageItem(intel: message, index: index),
                      onVisibilityChanged: (visibilityInfo) {
                        if (!mounted) return;

                        try {
                          if (state.visibleIds.isNotEmpty) {
                            context.read<IntelCubit>().getTokensByIntelIds();
                          }

                          // 如果可见，则添加到可见列表
                          double visibleFraction =
                              visibilityInfo.visibleFraction;

                          // 如果可见，则添加到可见列表
                          if (visibleFraction > 0 &&
                              !state.visibleIds.contains(message.id ?? '')) {
                            context
                                .read<IntelCubit>()
                                .addVisibleId(message.id ?? '');
                            Logger.info("add visible id: ${message.id}");
                          } else if (visibleFraction == 0 &&
                              // 如果不可见，则从可见列表中移除
                              state.visibleIds.contains(message.id ?? '')) {
                            context
                                .read<IntelCubit>()
                                .removeVisibleId(message.id ?? '');
                            Logger.info("remove visible id: ${message.id}");
                          }
                        } catch (e) {
                          Logger.error("VisibilityDetector error: $e");
                        }
                      });
                }),
      );
    });

    // return InfiniteScrollList(
    //     items: items,
    //     onLoadMore: _loadMore,
    //     itemBuilder: (context, index, item) {
    //       return IntelItem(intelId: index);
    //     });
  }
}
