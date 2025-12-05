import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../cubits/index.dart';
import '../../../data/models/intel/intel.dart';
import '../../../l10n/l10n.dart';
import '../../../shared/presentation/widgets/no_data_widget.dart';
import '../../../shared/presentation/widgets/refresher/refresh_header_widget.dart';
import '../../../shared/presentation/widgets/refresher/refresh_notification.dart';
import '../../../shared/utils/safe_request.dart';
import '../../../themes/colors.dart';
import '../../../utils/logger.dart';
import '../../../widgets/token_skeleton.dart';
import 'intelligence_type/intelligence_classifier.dart';
import 'unread_bar.dart';

class IntelList extends StatefulWidget {
  final Key? scrollKey;

  const IntelList({
    super.key,
    this.scrollKey,
    this.onRefresh,
    this.onLoad,
    this.isNotMore = false,
    this.intelligences,
    this.visibleIds = const [],
    this.onRefreshToken,
    this.header,
    this.scrollController,
    this.isLoading = false,
    this.unreadBarFilter,
  });

  final Future<void> Function()? onRefresh;
  final Function()? onLoad;
  final List<String> visibleIds;
  final bool isNotMore;
  final bool isLoading;
  final List<Intel>? intelligences;
  final VoidCallback? onRefreshToken;
  final Widget? header;
  final ScrollController? scrollController;
  final bool Function(Intel)? unreadBarFilter;

  @override
  State<IntelList> createState() => _IntelListState();
}

class _IntelListState extends State<IntelList> with TickerProviderStateMixin {
  late IntelCubit _intelCubit;
  @override
  void initState() {
    super.initState();
    _intelCubit = BlocProvider.of<IntelCubit>(context);
  }

  Future<void> _onLoading() async {
    if (!mounted) return;

    final state = context.read<IntelCubit>().state;

    if (state.isFetchingMore && state.isNotMore) return;
    await safeRequest(
      () => widget.onLoad?.call(),
      onSuccess: () {
        if (!mounted) return;
      },
      onError: (e, s) {
        if (!mounted) return;
      },
    );
  }

  Future<void> _onRefresh() async {
    if (!mounted) return;

    await safeRequest(
      () async => await widget.onRefresh?.call(),
      onSuccess: () {
        if (!mounted) return;
      },
      onError: (e, s) {
        if (!mounted) return;
      },
    );
  }

  Widget _buildLoadingFooter() {
    if (widget.intelligences?.isEmpty ?? true) {
      return const SizedBox.shrink();
    }

    if (widget.isNotMore) {
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

    if (widget.isLoading) {
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

  bool _handleScrollNotification(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 100) {
      final state = context.read<IntelCubit>().state;
      if (!state.isFetchingMore && !state.isNotMore) {
        _onLoading();
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IntelCubit, IntelState>(
      buildWhen: (previous, current) {
        return previous.isFetchingMore != current.isFetchingMore ||
            previous.isNotMore != current.isNotMore ||
            previous.showUnreadBar != current.showUnreadBar;
      },
      builder: (context, state) {
        return RefreshNotification(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 2), () {
              _onRefresh();
            });
            return Future.value(true);
          },
          child: Stack(
            children: [
              NotificationListener<ScrollNotification>(
                onNotification: _handleScrollNotification,
                child: CustomScrollView(
                  key: widget.scrollKey,
                  // controller: widget.scrollController,
                  // physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    if (widget.header != null) widget.header!,
                    PullToRefreshContainer((
                      PullToRefreshScrollNotificationInfo? info,
                    ) {
                      return SliverToBoxAdapter(
                        child: RefreshHeaderWidget(info),
                      );
                    }),

                    if ((widget.intelligences?.isEmpty ?? true) &&
                        !widget.isLoading)
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Container(
                          color: Colors.white,
                          child: NoDataWidget(
                            onRetry: () {
                              _onRefresh();
                            },
                            errorTextDesc: S.of(context).noReceivedFromServer,
                          ),
                        ),
                      ),

                    if (widget.isLoading &&
                        (widget.intelligences?.isEmpty ?? true))
                      SliverToBoxAdapter(
                        child: ListView(
                          primary: false,
                          // physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            Container(
                              color: Colors.white,
                              child: const IntelSkeleton(itemCount: 3),
                            ),
                          ],
                        ),
                      ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final actualIndex = index ~/ 2;

                          if (index.isOdd) {
                            return Divider(
                              color: AppColors.card(context),
                              thickness: 10,
                              height: 10,
                            );
                          }

                          final message = widget.intelligences?[actualIndex];
                          if (message?.id == null) {
                            return const SizedBox.shrink();
                          }

                          return VisibilityDetector(
                            key: ValueKey(message?.id),
                            child: IntelligenceClassifier(
                              intel: message!,
                              index: actualIndex,
                            ),
                            onVisibilityChanged: (visibilityInfo) {
                              if (!mounted) return;
                              Logger.info('onVisibilityChanged: ${message.id}');
                              try {
                                if (state.visibleIds.isNotEmpty) {
                                  widget.onRefreshToken?.call();
                                }

                                double visibleFraction =
                                    visibilityInfo.visibleFraction;

                                if (visibleFraction > 0 &&
                                    !state.visibleIds.contains(
                                      message.id ?? '',
                                    )) {
                                  Logger.info('addVisibleId: ${message.id}');

                                  _intelCubit.addVisibleId(message.id ?? '');
                                } else if (visibleFraction == 0 &&
                                    state.visibleIds.contains(
                                      message.id ?? '',
                                    )) {
                                  _intelCubit.removeVisibleId(message.id ?? '');
                                  Logger.info('removeVisibleId: ${message.id}');
                                }
                              } catch (e) {
                                Logger.error('onVisibilityChanged error: $e');
                              }
                            },
                          );
                        },
                        childCount: (widget.intelligences?.length ?? 0) * 2 - 1,
                      ),
                    ),

                    SliverToBoxAdapter(child: _buildLoadingFooter()),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: IntelUnreadBar(
                    scrollController: PrimaryScrollController.of(context),
                    filter: widget.unreadBarFilter,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
