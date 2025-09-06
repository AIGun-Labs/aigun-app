import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_aigun/cubits/index.dart";
import "package:flutter_aigun/screens/intel/widgets/intel_item.dart";
import "package:flutter_aigun/themes/colors.dart";
import "package:flutter_aigun/utils/logger.dart";
import "package:pull_to_refresh/pull_to_refresh.dart";
import "package:visibility_detector/visibility_detector.dart";

class IntelList extends StatefulWidget {
  const IntelList({super.key});

  @override
  State<IntelList> createState() => _IntelListState();
}

class _IntelListState extends State<IntelList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      print("滑动到了底部");
      context.read<IntelCubit>().getIntelsHistory();
    }
  }

  // Future<void> _loadMore() async {
  //   _isLoading = true;
  //   await Future.delayed(const Duration(seconds: 2));
  //   setState(() {
  //     items
  //         .addAll(List.generate(10, (index) => "item ${items.length + index}"));
  //   });
  //   _isLoading = false;
  // }

  // void _onScroll() {
  //   if (_scrollController.position.pixels ==
  //           _scrollController.position.maxScrollExtent &&
  //       !_isLoading) {
  //     _loadMore();
  //   }
  // }

  final RefreshController _refreshController = RefreshController();

  Future<void> _onLoading() async {
    await context.read<IntelCubit>().getIntelsHistory();
    if (mounted) {
      return context.read<IntelCubit>().state.isNotMore
          ? _refreshController.loadNoData()
          : _refreshController.loadComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IntelCubit, IntelState>(builder: (context, state) {
      // return Center(
      //   child: SizedBox(
      //     width: 26.w,
      //     height: 26.h,
      //     child: const CircularProgressIndicator(),
      //   ),
      // );

// first fetch data show loading indicator
      if (state.isFetchingMore && state.allMessages!.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      // if allMessages is empty, show loading indicator
      if (state.allMessages == null || state.allMessages!.isEmpty) {
        return Center(
          child: Text(
            "We are receiving intelligence. Please wait a moment.",
            style: TextStyle(color: AppColors.textPrimary(context)),
          ),
        );
      }

      return SmartRefresher(
        enablePullDown: false, // 禁用下拉刷新
        enablePullUp: true,
        footer: ClassicFooter(),
        controller: _refreshController,
        onLoading: _onLoading,

        child: ListView.separated(
            controller: _scrollController,
            // physics: const NeverScrollableScrollPhysics(),
            itemCount: state.allMessages!.length,
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
              if (index == state.allMessages!.length && state.isFetchingMore) {
                // return const CircularProgressIndicator();
                return const CircularProgressIndicator();
              }

              if (state.isNotMore) {
                return const Text("No more data");
              }

              final message = state.allMessages![index];

              // return IntelMessageItem(intel: message);
              return VisibilityDetector(
                  key: Key(message.id.toString()),
                  child: IntelMessageItem(intel: message),
                  onVisibilityChanged: (visibilityInfo) {
                    if (state.visibleIds.isNotEmpty) {
                      context.read<IntelCubit>().getTokensByIntelIds();
                    }

                    // 如果可见，则添加到可见列表
                    double visibleFraction = visibilityInfo.visibleFraction;

                    // 如果可见，则添加到可见列表
                    if (visibleFraction > 0 &&
                        !state.visibleIds.contains(message.id)) {
                      context.read<IntelCubit>().addVisibleId(message.id!);
                      Logger.info("add visible id: ${message.id}");
                    } else if (visibleFraction == 0 &&
                        // 如果不可见，则从可见列表中移除
                        state.visibleIds.contains(message.id)) {
                      context.read<IntelCubit>().removeVisibleId(message.id!);
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
