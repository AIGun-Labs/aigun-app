import "package:flutter/material.dart";
import "package:flutter_aigun/cubits/index.dart";
import "package:flutter_aigun/l10n/l10n.dart";
import "package:flutter_aigun/screens/intel/widgets/intel_item/intel_item.dart";
import "package:flutter_aigun/shared/widgets/no_data.dart";
import "package:flutter_aigun/widgets/push_to_refresh_header.dart";
import "package:flutter_aigun/themes/colors.dart";
import "package:flutter_aigun/utils/logger.dart";
import "package:flutter_aigun/widgets/token_skeleton.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:pull_to_refresh/pull_to_refresh.dart";
import "package:pull_to_refresh_notification/pull_to_refresh_notification.dart";
import "package:visibility_detector/visibility_detector.dart";

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
    _setupScrollListener();
  }

  void _setupScrollListener() {
    widget.scrollController?.addListener(() {
      if (!mounted) return;

      final scrollController = widget.scrollController;
      if (scrollController == null) return;

      // 检查是否滚动到接近底部（距底部100像素）
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 100) {
        // 如果正在加载或已经没有更多数据，则不再触发加载
        final state = context.read<IntelCubit>().state;
        if (!state.isFetchingMore && !state.isNotMore) {
          _onLoading();
        }
      }
    });
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

  Widget _buildLoadingFooter(IntelState state) {
    if (state.allMessages?.isEmpty == true) {
      return const SizedBox.shrink();
    }

    if (state.isNotMore) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Center(
          child: Text(
            S.of(context).noMoreData,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14.sp,
            ),
          ),
        ),
      );
    }

    if (state.isFetchingMore) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Center(
          child: SizedBox(
            width: 24.w,
            height: 24.h,
            child: const CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
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
                      child: NoDataWidget(
                        onRetry: () {
                          _onRefresh();
                        },
                        errorTextDesc: S.of(context).noReceivedFromServer,
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
                                  } else if (visibleFraction == 0 &&
                                      state.visibleIds
                                          .contains(message.id ?? '')) {
                                    context
                                        .read<IntelCubit>()
                                        .removeVisibleId(message.id ?? '');
                                    Logger.info(
                                        "remove visible id: ${message.id}");
                                  }
                                } catch (e) {}
                              });
                        },
                        childCount: (state.allMessages?.length ?? 0) * 2 - 1,
                      ),
                    ),
              // 添加底部加载指示器
              SliverToBoxAdapter(
                child: _buildLoadingFooter(state),
              ),
            ],
          ));
    });
  }
}
