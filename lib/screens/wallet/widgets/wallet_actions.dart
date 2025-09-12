import 'package:flutter/material.dart';
import 'package:flutter_aigun/config/nav.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class WalletActions extends StatelessWidget {
  const WalletActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 0.h, bottom: 10.h, left: 25.w, right: 25.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          WalletActionItem(
              icon: Icon(
                Icons.arrow_downward,
                color: AppColors.background(context),
              ),
              text: S.of(context).wallet_receive,
              onTap: () {
                context.push(Routes.selectNetwork);
              }),
          WalletActionItem(
              icon: Icon(
                Icons.arrow_upward,
                color: AppColors.background(context),
              ),
              text: S.of(context).wallet_send,
              onTap: () {
                context.push(Routes.sendSelectToken);
              }),
          WalletActionItem(
              icon: Center(
                child: SvgPicture.asset(
                  width: 24.w,
                  height: 24.h,
                  "assets/images/icons/wallet-trade-action.svg",
                ),
              ),
              text: S.of(context).wallet_trade,
              onTap: () {
                context.push(Routes.home, extra: NavIndex.trade);
              }),
          WalletActionItem(
              icon: Center(
                child: SvgPicture.asset(
                  "assets/images/icons/wallet-invite-action.svg",
                  width: 20.w,
                  height: 20.h,
                ),
              ),
              text: S.of(context).wallet_invite,
              onTap: () {}),
        ],
      ),
    );
  }
}

class WalletActionItem extends StatelessWidget {
  const WalletActionItem(
      {super.key, required this.icon, required this.text, required this.onTap});
  final Widget icon;
  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 55.w,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.foreground(context),
                borderRadius: BorderRadius.circular(25.r),
              ),
              height: 50.h,
              width: 50.w,
              child: icon,
            ),
            SizedBox(height: 4.h),
            Text(
              text,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textTertiary(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
