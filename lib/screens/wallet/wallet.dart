import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/index.dart';
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
      return LoadingIndicator();
    }

    return SafeArea(
        child: Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              children: [
                BlocBuilder<WalletCubit, WalletState>(
                  buildWhen: (previous, current) =>
                      previous.wallets != current.wallets,
                  builder: (context, state) {
                    // 钱包列表为空时，不显示钱包概览

                    if (state.wallets.isEmpty) {
                      return SizedBox.shrink();
                    }
                    // 显示钱包 Profile
                    return const WalletProfile();
                  },
                ),
                Container(
                  height: 1.w,
                  color: Theme.of(context).dividerColor.withValues(alpha: .3),
                ),
                BlocBuilder<WalletCubit, WalletState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 100.w),
                          child: LoadingIndicator(
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color!,
                          ),
                        ),
                      );
                    }

                    // 钱包列表为空时，显示空状态
                    // if (state.wallets.isEmpty) {
                    //   return const WalletEmpty();
                    // }

                    // 显示错误状态
                    if (state.errorMessage.isNotEmpty) {
                      return WalletError(errorMessage: state.errorMessage);
                    }

                    // 钱包列表不为空时，显示钱包列表
                    return const WalletList();
                  },
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                  child: TextButton(
                      onPressed: () {
                        context.read<UserCubit>().logout();
                      },
                      child: Text("LogOut",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: AppColors.textPrimary(context),
                          ))),
                )

                // // Padding(
                // //   padding: EdgeInsets.symmetric(vertical: 16.h),
                // //   child: AddTokenButton(),
                // // )
                // // CaptchaExample()
                // ElevatedButton(
                //     onPressed: () {
                //       ClickWordCaptchaDialog.show(
                //         context,
                //         base64Image: '',
                //         wordList: ['Hello', 'World', 'Click', 'Me'],
                //         onSuccess: (points) {},
                //         onFail: () {},
                //       );
                //     },
                //     child: const Text('Click Word Captcha'))
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
