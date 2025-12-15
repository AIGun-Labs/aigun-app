import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../core/router/constants.dart';
import '../../../../shared/presentation/widgets/no_data_widget.dart';
import '../../../../shared/presentation/widgets/refresher/refresh_header_widget.dart';
import '../../../../shared/presentation/widgets/refresher/refresh_notification.dart';
import '../../../bonus/presentation/cubits/invite_cubit.dart';
import '../widgets/bonus_view.dart';
import '../widgets/bonus_view_skeleton.dart';
import '../widgets/invite_header.dart';

class BonusScreen extends StatefulWidget {
  const BonusScreen({super.key});

  @override
  State<BonusScreen> createState() => _BonusScreenState();
}

class _BonusScreenState extends State<BonusScreen> {
  late final RefreshController _refreshController;
  late final InviteCubit _inviteCubit;
  @override
  void initState() {
    super.initState();
    _inviteCubit = BlocProvider.of<InviteCubit>(context)..refresh();
    _refreshController = RefreshController(initialRefresh: false);
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _inviteCubit.close();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    try {
      await _inviteCubit.refreshInviteInfo();
      _refreshController.refreshCompleted();
    } catch (e) {
      _refreshController.refreshFailed();
    } finally {
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: VisibilityDetector(
        key: const Key(RouteNames.bonus),
        onVisibilityChanged: (visibilityInfo) {
          if (visibilityInfo.visibleFraction > 0) {
            _inviteCubit.refreshInviteInfo();
          }
        },
        child: RefreshNotification(
          onRefresh: () async {
            await _handleRefresh();
            return true;
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: CustomScrollView(
              slivers: [
                PullToRefreshContainer((
                  PullToRefreshScrollNotificationInfo? info,
                ) {
                  return SliverToBoxAdapter(child: RefreshHeaderWidget(info));
                }),
                SliverToBoxAdapter(child: 30.verticalSpace),
                const SliverToBoxAdapter(child: InviteHeader()),
                SliverToBoxAdapter(child: 26.verticalSpace),
                BlocBuilder<InviteCubit, InviteState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      success: (inviteInfo) => SliverToBoxAdapter(
                        child: BonusView(inviteInfo: inviteInfo),
                      ),
                      error: (error) => SliverFillRemaining(
                        child: NoDataWidget(
                          onRetry: () {
                            _inviteCubit.refresh();
                          },
                        ),
                      ),
                      orElse: () =>
                          const SliverToBoxAdapter(child: BonusViewSkeleton()),
                    );
                  },
                ),

                // SliverFillRemaining(
                //   child: Column(
                //     children: [

                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
