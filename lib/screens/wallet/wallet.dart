import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/widgets/button/primary.dart';
import 'package:flutter_aigun/widgets/toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/screens/wallet/widgets/wallet_error.dart';
import 'package:flutter_aigun/screens/wallet/widgets/wallet_list.dart';
import 'package:flutter_aigun/screens/wallet/widgets/wallet_not_logged_in.dart';
import 'package:flutter_aigun/screens/wallet/widgets/wallet_profile.dart';
import 'package:flutter_aigun/widgets/loading_indicator/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.select(
      (UserCubit cubit) => cubit.state.isLoggedIn,
    );

    final isLoading = context.select(
      (UserCubit cubit) => cubit.state.isLoading,
    );

    // 如果用户没有登录，则实现提示用户登录界面
    if (!isLoggedIn) {
      return const WalletNotLoggedIn();
    }

// 加载动画
    if (isLoading) {
      return const LoadingIndicator();
    }

    return SafeArea(
      child: BlocBuilder<WalletCubit, WalletState>(builder: (context, state) {
        return Column(
          children: [
            const WalletProfile(),
            SizedBox(height: 12.w),
            // 使用Expanded确保WalletList可以占用剩余空间
            Expanded(child: _buildWalletList(context)),

            Padding(
                padding: EdgeInsets.all(16.w),
                child: PrimaryButton(
                    backgroundColor: AppColors.card(context),
                    onPressed: () {
                      context.read<UserCubit>().logout();
                    },
                    label: const Text('退出登录（测试）'),
                    icon: const Icon(Icons.logout)))
          ],
        );
      }),
    );
  }

  Widget _buildWalletList(BuildContext context) {
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Center(
            child: Padding(
              padding: EdgeInsets.only(top: 100.w),
              child: LoadingIndicator(
                color: Theme.of(context).textTheme.bodyMedium!.color!,
              ),
            ),
          );
        }

        // 显示错误状态
        if (state.errorMessage.isNotEmpty) {
          return WalletError(errorMessage: state.errorMessage);
        }

        // 钱包列表不为空时，显示钱包列表
        return const WalletList();
      },
    );
  }
}
