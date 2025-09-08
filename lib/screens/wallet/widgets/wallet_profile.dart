import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/data/models/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/utils/language.dart';
import 'package:flutter_aigun/utils/theme.dart';
import 'package:flutter_aigun/widgets/button.dart';
import 'package:flutter_aigun/widgets/image.dart';
import 'package:flutter_aigun/widgets/loading_indicator/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class WalletProfile extends StatelessWidget {
  const WalletProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return state.maybeWhen(
          success: (user) => _buildProfileContent(context, user),
          loading: () => const LoadingIndicator(),
          error: (error) => Container(
            // 获取用户信息失败
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text(error)),
                SizedBox(height: 10.w),
                CustomButton(
                  width: 100.w,
                  height: 40.w,
                  fontSize: 14.sp,
                  textColor: Theme.of(context).colorScheme.onPrimary,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    context.push(Routes.login);
                  },
                  child: Text(S.of(context).common_login),
                ),
              ],
            ),
          ),
          orElse: () => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget _buildProfileContent(BuildContext context, User? user) {
    return BlocBuilder<WalletCubit, WalletState>(builder: (context, state) {
      return Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 16.w,
          left: 16.w,
          right: 16.w,
          bottom: 16.w,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              AppColors.bgGradientStart(context),
              AppColors.bgGradientEnd(context),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    context.push(Routes.user);
                  },
                  // 用户头像
                  child: CachedImage(
                    width: 60.w,
                    height: 60.w,
                    borderRadius: BorderRadius.circular(30.w),
                    imageUrl: user?.avatar ?? 'assets/images/happy.png',
                  ),
                ),
                SizedBox(width: 10.w),
                Flexible(child: _buildUserInfoColumn(context, user)),
                Spacer(),
                _buildInviteInfo(context, user),
              ],
            ),
            if (state.wallets.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.w),
                  _buildAssetEstimation(context),
                  SizedBox(height: 10.w),
                  _buildAssetValue(context),
                  SizedBox(height: 10.w),
                  _buildAssetChange(context), // TODO:后端没有返回字段
                  SizedBox(height: 10.w),
                  _buildActionButtons(context),
                ],
              )
            else
              SizedBox(),
          ],
        ),
      );
    });
  }

// 用户信息列
  Widget _buildUserInfoColumn(BuildContext context, User? user) {
    return SizedBox(
      height: 60.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            //  用户名称
            user?.nickname ?? '--',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18.sp,
              color: AppColors.textPrimary(context),
              fontWeight: FontWeight.w600,
              height: 1.3.h,
            ),
          ),
          Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Transform.translate(
                  offset: Offset(-1.2.w, -1.2.w),
                  child: SvgPicture.asset(
                    'assets/images/icons/icons8-money-bag.svg',
                    colorFilter: const ColorFilter.mode(
                      AppColors.quinary,
                      BlendMode.srcIn,
                    ),
                    width: 25.w,
                    height: 25.w,
                  ),
                ),
              ),
              SizedBox(width: 4.w),
              Center(
                child: Text(
                  "\$0",
                  // '\$${user.balance}',
                  style: TextStyle(
                    fontSize: 22.sp,
                    color: AppColors.textPrimary(context),
                    height: 0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

// 邀请信息
  Widget _buildInviteInfo(BuildContext context, User? user) {
    return Row(
      children: [
        SizedBox(width: 34.w),
        _buildInviteColumn(context, user?.inviteAmount.toString() ?? '0',
            "Direct", 18.sp, 12.sp),
        SizedBox(width: 10.w),
        _buildInviteColumn(
            context,
            user?.indirectInviteAmount.toString() ?? '0',
            "Indirect",
            18.sp,
            12.sp),
      ],
    );
  }

  Widget _buildInviteColumn(BuildContext context, String count, String label,
      double countFontSize, double labelFontSize) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            fontSize: countFontSize,
            color: AppColors.textPrimary(context),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: labelFontSize,
            color: AppColors.textPrimary(context),
          ),
        ),
      ],
    );
  }

  Widget _buildAssetEstimation(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          S.of(context).wallet_totalAssetEstimation,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.textSecondary(context),
          ),
        ),
        // GestureDetector(
        //   onTap: () {
        //     context.push(Routes.managementWallet);
        //   },
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       Icon(
        //         Icons.wallet_outlined,
        //         size: 16.w,
        //         color: Theme.of(context).textTheme.bodySmall?.color,
        //       ),
        //       Text(
        //         S.of(context).managementWallet,
        //         style: TextStyle(
        //           fontSize: 14.sp,
        //           color: Theme.of(context).textTheme.bodyMedium?.color,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  Widget _buildAssetValue(BuildContext context) {
    return BlocSelector<BalanceCubit, BalanceState, String>(
      selector: (state) => state.balances?.totalBalanceUsd ?? '0.00',
      builder: (context, value) {
        // final balance =
        //     Decimal.tryParse(state.balances?.totalBalanceUsd ?? '0');

        final balance = Decimal.tryParse(value)?.toStringAsFixed(6);

        return Text(
          '≈ \$${balance == null ? '--' : balance}',
          // "≈ $value",
          style: TextStyle(
            fontSize: 28.sp,
            color: AppColors.textPrimary(context),
            height: 1.2.sign,
          ),
        );
      },
    );
  }

  Widget _buildAssetChange(BuildContext context) {
    return Text(
      '+\$0.00(+0.00%) Today',
      style: TextStyle(
        fontSize: 14.sp,
        color: AppColors.textSecondary(context),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 10.w,
      children: [
        _buildActionButton(
          'assets/images/icons/icons8-down.svg',
          S.of(context).wallet_transferIn,
          // AppColors.foregroundBlack,
          // AppColors.backgroundWhite,
          AppColors.foreground(context),
          AppColors.background(context),
          BorderSide(
            color: AppColors.foreground(context),
            width: 1.w,
          ),
          context,
          () {
            context.push(Routes.selectNetwork);
          },
        ),
        _buildActionButton(
          'assets/images/icons/icons8-up.svg',
          S.of(context).wallet_transferOut,
          // AppColors.textTertiary(context),
          AppColors.background(context),
          AppColors.foreground(context),
          BorderSide(
            color: AppColors.textTertiary(context),
            width: 1.w,
          ),
          context,
          () {
            context.push(Routes.sendSelectToken);
          },
        ),
        _buildActionButton(
          'assets/images/icons/icons8-invite.svg',
          S.of(context).ui_invite,
          AppColors.background(context),
          AppColors.foreground(context),
          BorderSide(
            color: AppColors.textTertiary(context),
            width: 1.w,
          ),
          context,
          () {
            // context.push(Routes.selectNetwork);
          },
        ),
      ],
    );
  }

  Widget _buildActionButton(
    String iconPath,
    String text,
    Color backgroundColor,
    Color textColor,
    BorderSide? borderSide,
    BuildContext context,
    VoidCallback? onPressed,
  ) {
    return Expanded(
      child: CustomButton(
        width: 115.w,
        height: 46.w,
        onPressed: onPressed,
        backgroundColor: backgroundColor,
        textColor: textColor,
        hasShadow: false,
        borderSide: borderSide,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              colorFilter: ColorFilter.mode(
                textColor,
                BlendMode.srcIn,
              ),
              width: Language.isEnglish(context) ? 0.w : 20.w,
              height: Language.isEnglish(context) ? 0.w : 20.w,
            ),
            S.of(context).ui_invite == text
                ? SizedBox(width: 4.w)
                : SizedBox(width: 0.w),
            Text(
              text,
              style: TextStyle(
                fontSize: Language.isEnglish(context) ? 14.sp : 15.sp,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
