import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../cubits/index.dart';
import '../../themes/themes.dart';
import 'widgets/search_bar.dart';
import 'widgets/wallet_actions.dart';
import 'widgets/wallet_list.dart';
import 'widgets/wallet_profile.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 15.w,
        automaticallyImplyLeading: false,
        title: WalletSearchBar(
            openDrawer: () => Scaffold.of(context).openDrawer()),
        backgroundColor: AppColors.background(context),
      ),
      body: VisibilityDetector(
          key: const Key('wallet_screen'),
          onVisibilityChanged: (visibilityInfo) {
            if (visibilityInfo.visibleFraction > 0) {
              context.read<BalanceCubit>().startPollingBalance();
            } else {
              context.read<BalanceCubit>().stopPollingBalance();
            }
          },
          child: SafeArea(
            child: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const WalletUserProfile(),
                    const WalletActions(),
                    Divider(
                      color: AppColors.border(context),
                    ),
                    SizedBox(height: 10.h),
                    const WalletList(),
                  ],
                ),
              );
            }),
          )),
    );
  }
}
