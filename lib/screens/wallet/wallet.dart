import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../core/router/constants.dart';
import '../../cubits/index.dart';
import '../../l10n/l10n.dart';
import '../../themes/themes.dart';
import '../../widgets/button/primary.dart';
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
        titleSpacing: 20.w,
        automaticallyImplyLeading: false,
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 5.h),
          child: WalletSearchBar(
              openDrawer: () => Scaffold.of(context).openDrawer()),
        ),
        backgroundColor: AppColors.background(context),
      ),
      body: VisibilityDetector(
          key: const Key("wallet_screen"),
          onVisibilityChanged: (visibilityInfo) {
            if (visibilityInfo.visibleFraction > 0) {
              context.read<BalanceCubit>().startPollingBalance();
            } else {
              context.read<BalanceCubit>().stopPollingBalance();
            }
          },
          child: SafeArea(
            child: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
              // 处理未登录的情况
              if (state.status.maybeWhen(
                success: (user) => false,
                orElse: () => true,
              )) {
                return Center(
                    child: PrimaryButton(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        onPressed: () {
                          context.pushNamed(RouteNames.login);
                          context.read<UserCubit>().logout();
                        },
                        label: Text(S.of(context).common_login,
                            style: const TextStyle(color: Colors.white))));
              }
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
