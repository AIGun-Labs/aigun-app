import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../cubits/balance/balance_cubit.dart';
import '../../../../cubits/user/user_cubit.dart';
import '../../../../cubits/user/user_state.dart';
import '../../../../themes/themes.dart';
import '../widgets/search_bar.dart';
import '../widgets/wallet_actions.dart';
import '../widgets/wallet_list.dart';
import '../widgets/wallet_profile.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: VisibilityDetector(
        key: const Key('wallet_screen'),
        onVisibilityChanged: (visibilityInfo) {
          if (visibilityInfo.visibleFraction > 0) {
            BlocProvider.of<BalanceCubit>(context).startPollingBalance();
          } else {
            BlocProvider.of<BalanceCubit>(context).stopPollingBalance();
          }
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: WalletSearchBar(
                openDrawer: () => Scaffold.maybeOf(context)?.openDrawer(),
              ),
              backgroundColor: AppColors.background(context),
              toolbarHeight: 56.h,
              automaticallyImplyLeading: false,
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      const WalletUserProfile(),
                      const WalletActions(),
                      Divider(color: AppColors.border(context)),
                      SizedBox(height: 10.h),
                      const WalletList(),
                    ],
                  );
                },
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 100.h)),
          ],
        ),
      ),
    );
  }
}
