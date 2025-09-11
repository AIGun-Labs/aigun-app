import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_aigun/cubits/index.dart";
import "package:flutter_aigun/screens/intel/widgets/intel_item.dart";
import "package:flutter_aigun/screens/intel/widgets/refresh_header.dart";
import "package:flutter_aigun/themes/colors.dart";
import "package:flutter_aigun/utils/logger.dart";
import "package:flutter_aigun/widgets/token_skeleton.dart";
import "package:pull_to_refresh/pull_to_refresh.dart";
import "package:visibility_detector/visibility_detector.dart";

class IntelList extends StatefulWidget {
  const IntelList({super.key});

  @override
  State<IntelList> createState() => _IntelListState();
}

class _IntelListState extends State<IntelList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  Future<void> _onLoading() async {
    await context.read<IntelCubit>().getIntelsHistory();
    if (mounted) {
      return context.read<IntelCubit>().state.isNotMore
          ? _refreshController.loadNoData()
          : _refreshController.loadComplete();
    }
  }

  void _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    try {
      await context.read<IntelCubit>().refreshIntels();
    } catch (e) {
      Logger.error("refreshIntels error: $e");
    } finally {
      if (mounted) {
        _refreshController.refreshCompleted();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IntelCubit, IntelState>(builder: (context, state) {
      if (state.isFetchingMore && state.allMessages?.isEmpty == true) {
        return SmartRefresher(
          enablePullDown: false,
          enablePullUp: false,
          controller: _refreshController,
          child: const SingleChildScrollView(
            child: IntelSkeleton(itemCount: 3),
          ),
        );
      }

      // if (state.allMessages == null || state.allMessages?.isEmpty == true) {
      //   return Center(
      //     child: Text(
      //       "We are receiving intelligence. Please wait a moment.",
      //       style: TextStyle(color: AppColors.textPrimary(context)),
      //     ),
      //   );
      // }
      return SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        footer: const ClassicFooter(),
        header: const CustomRefreshHeader(),
        controller: _refreshController,
        onLoading: _onLoading,
        onRefresh: _onRefresh,
        child: ListView.builder(
            // 移除 ScrollController，让 SmartRefresher 管理滚动
            itemCount: state.allMessages?.length ?? 0,
            // separatorBuilder: (BuildContext context, int index) {
            //   return Divider(
            //     color: AppColors.card(context),
            //     thickness: 10,
            //     height: 10,
            //     // indent: 16, //
            //     // endIndent: 16,
            //   );
            // },
            itemBuilder: (context, index) {
              // 修正条件：如果是最后一个项目且正在加载更多
              if (index == (state.allMessages?.length ?? 0) - 1 &&
                  state.isFetchingMore) {
                return Column(
                  children: [
                    VisibilityDetector(
                        key: Key(state.allMessages![index].id ?? ''),
                        child:
                            IntelMessageItem(intel: state.allMessages![index]),
                        onVisibilityChanged: (visibilityInfo) {
                          if (state.visibleIds.isNotEmpty) {
                            context.read<IntelCubit>().getTokensByIntelIds();
                          }
                          double visibleFraction =
                              visibilityInfo.visibleFraction;
                          if (visibleFraction > 0 &&
                              !state.visibleIds.contains(
                                  state.allMessages![index].id ?? '')) {
                            context.read<IntelCubit>().addVisibleId(
                                state.allMessages![index].id ?? '');
                          } else if (visibleFraction == 0 &&
                              state.visibleIds.contains(
                                  state.allMessages![index].id ?? '')) {
                            context.read<IntelCubit>().removeVisibleId(
                                state.allMessages![index].id ?? '');
                          }
                        }),
                  ],
                );
              }

              // 修正条件：如果是最后一个项目且没有更多数据
              if (state.isNotMore &&
                  index == (state.allMessages?.length ?? 0) - 1) {
                return Column(
                  children: [
                    VisibilityDetector(
                        key: Key(state.allMessages![index].id ?? ''),
                        child:
                            IntelMessageItem(intel: state.allMessages![index]),
                        onVisibilityChanged: (visibilityInfo) {
                          if (state.visibleIds.isNotEmpty) {
                            context.read<IntelCubit>().getTokensByIntelIds();
                          }
                          double visibleFraction =
                              visibilityInfo.visibleFraction;
                          if (visibleFraction > 0 &&
                              !state.visibleIds.contains(
                                  state.allMessages![index].id ?? '')) {
                            context.read<IntelCubit>().addVisibleId(
                                state.allMessages![index].id ?? '');
                            Logger.info(
                                "add visible id: ${state.allMessages![index].id}");
                          } else if (visibleFraction == 0 &&
                              state.visibleIds.contains(
                                  state.allMessages![index].id ?? '')) {
                            context.read<IntelCubit>().removeVisibleId(
                                state.allMessages![index].id ?? '');
                            Logger.info(
                                "remove visible id: ${state.allMessages![index].id}");
                          }
                        }),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text("No more data"),
                    ),
                  ],
                );
              }

              final message = state.allMessages?[index];

              if (message == null) {
                return const SizedBox.shrink();
              }

              // return IntelMessageItem(intel: message);
              return VisibilityDetector(
                  key: Key(message.id ?? ''),
                  child: IntelMessageItem(intel: message),
                  onVisibilityChanged: (visibilityInfo) {
                    if (state.visibleIds.isNotEmpty) {
                      context.read<IntelCubit>().getTokensByIntelIds();
                    }

                    // 如果可见，则添加到可见列表
                    double visibleFraction = visibilityInfo.visibleFraction;

                    // 如果可见，则添加到可见列表
                    if (visibleFraction > 0 &&
                        !state.visibleIds.contains(message.id ?? '')) {
                      context.read<IntelCubit>().addVisibleId(message.id ?? '');
                      Logger.info("add visible id: ${message.id}");
                    } else if (visibleFraction == 0 &&
                        // 如果不可见，则从可见列表中移除
                        state.visibleIds.contains(message.id ?? '')) {
                      context
                          .read<IntelCubit>()
                          .removeVisibleId(message.id ?? '');
                      Logger.info("remove visible id: ${message.id}");
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
