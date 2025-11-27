import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../cubits/index.dart';
import '../../features/home/presentation/pages/home.dart';
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
      body: VisibilityDetector(
        key: const Key('wallet_screen'),
        onVisibilityChanged: (visibilityInfo) {
          if (visibilityInfo.visibleFraction > 0) {
            context.read<BalanceCubit>().startPollingBalance();
          } else {
            context.read<BalanceCubit>().stopPollingBalance();
          }
        },
        // 使用 NestedScrollView 以确保和 Intel/Trending 像素级对齐
        child: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  title: WalletSearchBar(
                      openDrawer: () => HomeScreenState.scaffoldKey.currentState
                          ?.openDrawer()),
                  automaticallyImplyLeading: false,
                  backgroundColor: AppColors.background(context),

                  // pinned: false, // 必须为 true，对应普通 AppBar 的效果
                  // floating: true, // 不需要自动隐藏
                  // snap: true,

                  expandedHeight: 56.h,
                  toolbarHeight: 56.h,
                  elevation: 0,
                ),
              ];
            },
            body: BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
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
              },
            ),
          ),
        ),
      ),
    );
  }
}
