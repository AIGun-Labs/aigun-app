import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

import '../../../../shared/presentation/widgets/no_data_widget.dart';
import '../../../../shared/presentation/widgets/refresher/refresh_header_widget.dart';
import '../../../../shared/presentation/widgets/refresher/refresh_notification.dart';
import '../../../bonus/presentation/cubits/invite_cubit.dart';
import '../widgets/bonus_view.dart';
import '../widgets/bonus_view_skeleton.dart';

class BonusScreen extends StatefulWidget {
  const BonusScreen({super.key});

  @override
  State<BonusScreen> createState() => _BonusScreenState();
}

class _BonusScreenState extends State<BonusScreen> {
  bool _pollingEnabled = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _polling();
  }

  void _polling() {
    final tickerEnabled = TickerMode.of(context);

    if (_pollingEnabled == tickerEnabled) return;

    _pollingEnabled = tickerEnabled;

    if (tickerEnabled) {
      BlocProvider.of<InviteCubit>(context).startPollingRealtimeFunds();
      BlocProvider.of<InviteCubit>(context).refresh();
    } else {
      BlocProvider.of<InviteCubit>(context).stopPollingRealtimeFunds();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshNotification(
        onRefresh: () async {
          await BlocProvider.of<InviteCubit>(context).refresh();
          await Future.delayed(const Duration(milliseconds: 500));
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

              BlocBuilder<InviteCubit, InviteState>(
                builder: (context, state) {
                  if (state.status == InviteStateStatus.initial) {
                    return const SliverToBoxAdapter(child: BonusViewSkeleton());
                  }

                  if (state.status == InviteStateStatus.error) {
                    return SliverFillRemaining(
                      fillOverscroll: true,
                      hasScrollBody: false,
                      child: NoDataWidget(
                        onRetry: () =>
                            BlocProvider.of<InviteCubit>(context).init(),
                      ),
                    );
                  }

                  return SliverToBoxAdapter(
                    child: BonusView(
                      inviteInfo: state.inviteInfo!,
                      onClaimGold: () =>
                          BlocProvider.of<InviteCubit>(context).claimGold(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
