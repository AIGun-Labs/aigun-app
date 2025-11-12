import 'package:flutter/material.dart';
import 'package:flutter_aigun/utils/toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/l10n.dart';
import '../../../../themes/colors.dart';
import '../../../../utils/clipboard.dart';
import 'card_widget.dart';

class InviteCard extends StatelessWidget {
  final String inviteCode;
  final String inviteLink;
  final String inviteBonus;
  const InviteCard(
      {super.key,
      required this.inviteCode,
      required this.inviteLink,
      required this.inviteBonus});

  Future<void> _copyInviteCode(BuildContext context) async {
    try {
      await ClipboardUtils.copy(inviteCode);
      if (!context.mounted) return;
      ToastUtils.showSuccessToast(context, message: S.of(context).copySuccess);
    } catch (e) {
      if (!context.mounted) return;

      ToastUtils.showFailureToast(context, message: e.toString());
    }
  }

  Future<void> _copyInviteLink(BuildContext context) async {
    try {
      await ClipboardUtils.copy(inviteLink);
      if (!context.mounted) return;

      ToastUtils.showSuccessToast(context, message: S.of(context).copySuccess);
    } catch (e) {
      if (!context.mounted) return;

      ToastUtils.showFailureToast(context, message: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8.h,
                children: [
                  Text(
                    S.of(context).myInviteCode,
                    style: TextStyle(
                      fontSize: 14.sp,
                      height: 1.2.h,
                      color: AppColors.textSecondary(context),
                    ),
                  ),
                  Text(
                    inviteCode,
                    style: TextStyle(
                      fontSize: 20.sp,
                      height: 1.2.h,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              TextButton(
                  onPressed: () => _copyInviteCode(context),
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.foreground(context),
                    foregroundColor: AppColors.background(context),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 14.h),
                    textStyle: TextStyle(
                        fontSize: 16.sp,
                        height: 1.2,
                        fontWeight: FontWeight.w700),
                  ),
                  child: Text(
                    S.of(context).copy,
                  ))
            ],
          ),
          16.verticalSpace,
          Divider(
            height: 1.h,
            color: AppColors.border(context),
          ),
          20.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                S.of(context).inviteLink,
                style: TextStyle(
                  fontSize: 14.sp,
                  height: 1.2.h,
                  color: AppColors.textSecondary(context),
                ),
              ),
              12.horizontalSpace,
              Expanded(
                  child: Text(
                inviteLink,
                style: TextStyle(
                  fontSize: 14.sp,
                  height: 1.2.h,
                ),
                overflow: TextOverflow.ellipsis,
              )),
              6.horizontalSpace,
              GestureDetector(
                  onTap: () => _copyInviteLink(context),
                  child: Icon(
                    Icons.copy,
                    size: 14.sp,
                    color: AppColors.textSecondary(context),
                  )),
            ],
          ),
          16.verticalSpace,
          Row(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Text(
                S.of(context).inviteBonus,
                style: TextStyle(
                  fontSize: 14.sp,
                  height: 1.2.h,
                  color: AppColors.textSecondary(context),
                ),
              ),
              12.horizontalSpace,
              Text(
                inviteBonus,
                style: TextStyle(
                  fontSize: 20.sp,
                  height: 1.2.h,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
