import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/l10n.dart';
import '../../../../themes/colors.dart';

class OpenNotificationDialog extends StatelessWidget {
  const OpenNotificationDialog(
      {super.key, this.onCancel, required this.onSetting});

  final VoidCallback? onCancel;
  final VoidCallback onSetting;

  void _onCancel(BuildContext context) {
    onCancel?.call();
    Navigator.of(context).pop();
  }

  void _onSetting(BuildContext context) async {
    onSetting();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.r),
      ),
      actionsPadding: EdgeInsets.all(16.w),
      buttonPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.all(20.w),
      title: Text(S.of(context).updateNotice),
      content: Text(S.of(context).updateNoticeDesc),
      actions: [
        TextButton(
            onPressed: () => _onCancel(context),
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.r),
              ),
              textStyle: TextStyle(fontSize: 16.sp),
              foregroundColor: AppColors.textSecondary(context),
            ),
            child: Text(S.of(context).cancel)),
        TextButton(
            onPressed: () => _onSetting(context),
            style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
                textStyle: TextStyle(fontSize: 16.sp),
                foregroundColor: AppColors.textPrimary(context)),
            child: Text(S.of(context).settings)),
      ],
    );
  }
}
