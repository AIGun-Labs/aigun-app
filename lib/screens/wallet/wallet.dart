import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/screens/tabbar/tabbar.dart';
import 'package:flutter_aigun/screens/wallet/widgets/wallet_actions.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/widgets/button/primary.dart';
import 'package:flutter_aigun/widgets/drawer/drawer_setting.dart';
import 'package:flutter_aigun/widgets/user/index.dart';
import 'package:flutter_aigun/screens/wallet/widgets/wallet_list.dart';
import 'package:flutter_aigun/screens/wallet/widgets/wallet_profile.dart';
import 'package:flutter_aigun/widgets/user/widgets/user_profile_with_search_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerSetting(),
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
                      context.go(Routes.login);
                      context.read<UserCubit>().logout();
                    },
                    label: Text(S.of(context).common_login,
                        style: const TextStyle(color: AppColors.white))));
          }
          return Column(
            children: [
              UserProfileWithSearchBar(
                openDrawer: () => Scaffold.of(context).openDrawer(),
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    const UserWalletProfile(),
                    const WalletActions(),
                    Divider(
                      color: AppColors.border(context),
                    ),
                    const WalletList(),
                  ],
                ),
              ))
            ],
          );
        }),
      ),
    );
  }
}
