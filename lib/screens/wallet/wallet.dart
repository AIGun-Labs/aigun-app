import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/screens/wallet/widgets/wallet_actions.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/widgets/button/primary.dart';
import 'package:flutter_aigun/widgets/user/index.dart';
import 'package:flutter_aigun/screens/wallet/widgets/wallet_list.dart';
import 'package:flutter_aigun/screens/wallet/widgets/wallet_profile.dart';
import 'package:flutter_aigun/widgets/user/widgets/user_profile_with_search_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key, this.openDrawer});

  final VoidCallback? openDrawer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
          // 处理未登录的情况
          if (state.maybeWhen(
            success: (user) => false,
            orElse: () => true,
          )) {
            return Center(
                child: PrimaryButton(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    onPressed: () {
                      context.push(Routes.login);
                      context.read<UserCubit>().logout();
                    },
                    label: Text(S.of(context).common_login,
                        style: const TextStyle(color: Colors.white))));
          }
          return Column(
            children: [
              // 传入 openDrawer 回调函数
              UserProfileWithSearchBar(openDrawer: () => openDrawer?.call()),
              Expanded(
                  child: SingleChildScrollView(
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
              )),
            ],
          );
        }),
      ),
    );
  }
}
