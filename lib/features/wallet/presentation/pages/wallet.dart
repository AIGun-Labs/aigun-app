import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../cubits/balance/balance_cubit.dart';
import '../../../../cubits/user/user_cubit.dart';
import '../../../../shared/presentation/widgets/refresher/refresh_header_widget.dart';
import '../../../../shared/presentation/widgets/refresher/refresh_notification.dart';
import '../../../../themes/colors.dart';
import '../widgets/search_bar.dart';
import '../widgets/wallet_actions.dart';
import '../widgets/wallet_list.dart';
import '../widgets/wallet_profile.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('wallet_screen'),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction > 0) {
          context.read<BalanceCubit>().startPollingBalance();
        } else {
          context.read<BalanceCubit>().stopPollingBalance();
        }
      },
      child: SafeArea(
        child: ExtendedNestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: WalletSearchBar(
                  openDrawer: () => Scaffold.of(context).openDrawer(),
                ),
                automaticallyImplyLeading: false,
                backgroundColor: AppColors.background(context),
                expandedHeight: 56.h,
                elevation: 0,
              ),
            ];
          },
          body: RefreshNotification(
            onRefresh: () async {
              // Store cubit references before async operations to avoid using context across async gaps
              final userCubit = BlocProvider.of<UserCubit>(context);
              final balanceCubit = BlocProvider.of<BalanceCubit>(context);

              await userCubit.refresh();
              await balanceCubit.getBalanceList();
              return true;
            },
            child: CustomScrollView(
              slivers: [
                PullToRefreshContainer((
                  PullToRefreshScrollNotificationInfo? info,
                ) {
                  return SliverToBoxAdapter(child: RefreshHeaderWidget(info));
                }),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const WalletUserProfile(),
                      const WalletActions(),
                      Divider(color: AppColors.border(context)),
                      SizedBox(height: 10.h),
                      const WalletList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
