import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../l10n/l10n.dart';
import '../../../../shared/presentation/widgets/no_data_widget.dart';
import '../../../../shared/presentation/widgets/refresher/refresh_header_widget.dart';
import '../../../../shared/presentation/widgets/refresher/refresh_notification.dart';
import '../../../../themes/colors.dart';
import '../../../../widgets/token_skeleton.dart';
import '../../domain/entities/intelligence_entity.dart';
import 'intelligence_item_classifier.dart';

/// Intelligence List View Widget
///
/// Generic list view for displaying intelligence items with
/// pull-to-refresh and infinite scroll support.
class IntelligenceListView extends StatefulWidget {
  const IntelligenceListView({
    super.key,
    required this.items,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasReachedEnd = false,
    this.errorMessage,
    this.onRefresh,
    this.onLoadMore,
    this.onVisibilityChanged,
    this.headers,
    // this.slivers,
  });

  final List<IntelligenceEntity> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasReachedEnd;
  final String? errorMessage;
  final Future<void> Function()? onRefresh;
  final VoidCallback? onLoadMore;
  final void Function(String id, bool isVisible)? onVisibilityChanged;
  final List<Widget>? headers;
  // final List<Widget>? slivers;
  @override
  State<IntelligenceListView> createState() => _IntelligenceListViewState();
}

class _IntelligenceListViewState extends State<IntelligenceListView> {
  Future<bool> _onRefresh() async {
    if (!mounted) return true;
    await widget.onRefresh?.call();
    return true;
  }

  void _onLoadMore() {
    if (!mounted) return;
    if (widget.isLoadingMore || widget.hasReachedEnd) return;
    widget.onLoadMore?.call();
  }

  bool _handleScrollNotification(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 100) {
      _onLoadMore();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshNotification(
      onRefresh: () async => await _onRefresh(),
      child: NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: CustomScrollView(
          slivers: [
            if (widget.headers?.isNotEmpty ?? false) ...widget.headers!,
            PullToRefreshContainer((PullToRefreshScrollNotificationInfo? info) {
              return SliverToBoxAdapter(child: RefreshHeaderWidget(info));
            }),

            // Empty state
            if (widget.items.isEmpty && !widget.isLoading)
              SliverFillRemaining(
                hasScrollBody: false,
                child: ColoredBox(
                  color: Colors.white,
                  child: NoDataWidget(
                    onRetry: _onRefresh,
                    errorTextDesc: S.of(context).noReceivedFromServer,
                  ),
                ),
              ),

            // Loading skeleton
            if (widget.isLoading && widget.items.isEmpty)
              SliverToBoxAdapter(
                child: ColoredBox(
                  color: Colors.white,
                  child: const IntelSkeleton(itemCount: 3),
                ),
              ),

            // List items
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final actualIndex = index ~/ 2;

                  // Odd index shows divider
                  if (index.isOdd) {
                    return Divider(
                      color: AppColors.card(context),
                      thickness: 10,
                      height: 10,
                    );
                  }

                  // Even index shows list item
                  final item = widget.items[actualIndex];

                  return VisibilityDetector(
                    key: ValueKey(item.id),
                    onVisibilityChanged: (visibilityInfo) {
                      if (!mounted) return;
                      final isVisible = visibilityInfo.visibleFraction > 0;
                      widget.onVisibilityChanged?.call(item.id, isVisible);
                    },
                    // 第一个item显示分隔符
                    child: index == 0
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Divider(
                                height: 10,
                                thickness: 10,
                                color: AppColors.card(context),
                              ),
                              IntelligenceItemClassifier(
                                item: item,
                                index: actualIndex,
                              ),
                            ],
                          )
                        : IntelligenceItemClassifier(
                            item: item,
                            index: actualIndex,
                          ),
                  );
                },
                childCount: widget.items.isEmpty
                    ? 0
                    : widget.items.length * 2 - 1,
              ),
            ),

            // Loading footer
            SliverToBoxAdapter(child: _buildLoadingFooter(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingFooter(BuildContext context) {
    if (widget.items.isEmpty) {
      return const SizedBox.shrink();
    }

    if (widget.hasReachedEnd) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Center(
          child: Text(
            S.of(context).noMoreData,
            style: TextStyle(color: Colors.grey, fontSize: 14.sp),
          ),
        ),
      );
    }

    if (widget.isLoadingMore) {
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
}
