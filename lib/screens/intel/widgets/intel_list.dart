import "package:flutter/material.dart";
import "package:flutter_aigun/cubits/index.dart";
import "package:flutter_aigun/data/models/intel/intel.dart";
import "package:flutter_aigun/screens/intel/widgets/intel_item/intel_item.dart";
import "package:flutter_aigun/screens/intel/widgets/intel_item/intel_item_radar_signal.dart";
import "package:flutter_aigun/screens/intel/widgets/refresh_header.dart";
import "package:flutter_aigun/screens/trending/widgets/push_to_refresh_header.dart";
import "package:flutter_aigun/themes/colors.dart";
import "package:flutter_aigun/utils/logger.dart";
import "package:flutter_aigun/widgets/token_skeleton.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:pull_to_refresh/pull_to_refresh.dart";
import "package:pull_to_refresh_notification/pull_to_refresh_notification.dart";
import "package:visibility_detector/visibility_detector.dart";
import 'package:flutter_aigun/screens/intel/widgets/intel_item/intel_item_info.dart';

class IntelList extends StatefulWidget {
  final ScrollController? scrollController;

  const IntelList({super.key, this.scrollController});

  @override
  State<IntelList> createState() => _IntelListState();
}

class _IntelListState extends State<IntelList> with TickerProviderStateMixin {
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
        Future.delayed(const Duration(milliseconds: 1000), () {
          _refreshController.refreshCompleted();
        });
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
        // 保证没有数据时，也是显示一个列表，否则会布局报错
        return ListView(
          controller: widget.scrollController,
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Container(
              color: Colors.white,
              child: const IntelSkeleton(itemCount: 3),
            )
          ],
        );
      }

      return PullToRefreshNotification(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 2), () {
              _onRefresh();
            });
            return Future.value(true);
          },
          maxDragOffset: 110.h,
          child: CustomScrollView(
            controller: widget.scrollController,
            slivers: [
              PullToRefreshContainer(
                  (PullToRefreshScrollNotificationInfo? info) {
                return SliverToBoxAdapter(
                  child: PullToRefreshHeader(info),
                );
              }),
              state.allMessages?.isEmpty == true
                  ? SliverToBoxAdapter(
                      child: SizedBox(
                        height: 400.h,
                        child: const Center(child: Text('暂无数据')),
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final actualIndex = index ~/ 2;

                          // 奇数索引显示分隔符
                          if (index.isOdd) {
                            return Divider(
                              color: AppColors.card(context),
                              thickness: 10,
                              height: 10,
                            );
                          }

                          if (index ==
                              (state.allMessages?.length ?? 0) * 2 - 1) {
                            Logger.info(
                                "state.allMessages: $index  ${state.allMessages?.length}");

                            return const Text('加载更多');
                          }

                          // 偶数索引显示列表项
                          final message = state.allMessages?[actualIndex];
                          if (message == null) {
                            return const SizedBox.shrink();
                          }

                          return VisibilityDetector(
                              key: Key(message.id ?? ''),
                              child:
                                  IntelItem(intel: message, index: actualIndex),
                              onVisibilityChanged: (visibilityInfo) {
                                if (!mounted) return;

                                try {
                                  if (state.visibleIds.isNotEmpty) {
                                    context
                                        .read<IntelCubit>()
                                        .getTokensByIntelIds();
                                  }

                                  double visibleFraction =
                                      visibilityInfo.visibleFraction;

                                  if (visibleFraction > 0 &&
                                      !state.visibleIds
                                          .contains(message.id ?? '')) {
                                    context
                                        .read<IntelCubit>()
                                        .addVisibleId(message.id ?? '');
                                    Logger.info(
                                        "add visible id: ${message.id}");
                                  } else if (visibleFraction == 0 &&
                                      state.visibleIds
                                          .contains(message.id ?? '')) {
                                    context
                                        .read<IntelCubit>()
                                        .removeVisibleId(message.id ?? '');
                                    Logger.info(
                                        "remove visible id: ${message.id}");
                                  }
                                } catch (e) {
                                  Logger.error("VisibilityDetector error: $e");
                                }
                              });
                        },
                        childCount: (state.allMessages?.length ?? 0) * 2 - 1,
                      ),
                    )
            ],
          ));

      // return SmartRefresher(
      //   enablePullDown: true,
      //   enablePullUp: true,
      //   footer: const ClassicFooter(),
      //   header: const CustomRefreshHeader(),
      //   controller: _refreshController,
      //   scrollController: widget.scrollController,
      //   onLoading: _onLoading,
      //   onRefresh: _onRefresh,
      //   physics: const ClampingScrollPhysics(), // 禁止回弹效果
      //   // child: ListView.builder(itemBuilder: (context, index) {
      //   //   final intel = state.allMessages?[index];
      //   //   return IntelItemSmartMoney(
      //   //       intel: intel ?? const Intel(), index: index);
      //   // }),
      //   child: state.allMessages?.isEmpty == true
      //       ? ListView(
      //           controller: widget.scrollController,
      //           physics: const ClampingScrollPhysics(),
      //           shrinkWrap: true,
      //           children: [
      //             SizedBox(
      //               height: 400.h,
      //               child: const Center(child: Text('暂无数据')),
      //             ),
      //           ],
      //         )
      //       : ListView.separated(
      //           controller: widget.scrollController,
      //           physics: const ClampingScrollPhysics(),
      //           itemCount: state.allMessages?.length ?? 0,
      //           separatorBuilder: (BuildContext context, int index) {
      //             return Divider(
      //               color: AppColors.card(context),
      //               thickness: 10,
      //               height: 10,
      //             );
      //           },
      //           itemBuilder: (context, index) {
      //             final message = state.allMessages?[index];
      //             if (message == null) {
      //               return const SizedBox.shrink();
      //             }

      //             return VisibilityDetector(
      //                 key: Key(message.id ?? ''),
      //                 child: IntelItem(intel: message, index: index),
      //                 onVisibilityChanged: (visibilityInfo) {
      //                   if (!mounted) return;

      //                   try {
      //                     if (state.visibleIds.isNotEmpty) {
      //                       context.read<IntelCubit>().getTokensByIntelIds();
      //                     }

      //                     // 如果可见，则添加到可见列表
      //                     double visibleFraction =
      //                         visibilityInfo.visibleFraction;

      //                     // 如果可见，则添加到可见列表
      //                     if (visibleFraction > 0 &&
      //                         !state.visibleIds.contains(message.id ?? '')) {
      //                       context
      //                           .read<IntelCubit>()
      //                           .addVisibleId(message.id ?? '');
      //                       Logger.info("add visible id: ${message.id}");
      //                     } else if (visibleFraction == 0 &&
      //                         // 如果不可见，则从可见列表中移除
      //                         state.visibleIds.contains(message.id ?? '')) {
      //                       context
      //                           .read<IntelCubit>()
      //                           .removeVisibleId(message.id ?? '');
      //                       Logger.info("remove visible id: ${message.id}");
      //                     }
      //                   } catch (e) {
      //                     Logger.error("VisibilityDetector error: $e");
      //                   }
      //                 });
      //           }),
      // );
    });

    // return InfiniteScrollList(
    //     items: items,
    //     onLoadMore: _loadMore,
    //     itemBuilder: (context, index, item) {
    //       return IntelItem(intelId: index);
    //     });
  }
}
