import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/dialogs/dialogs.dart';
import '../../../../l10n/l10n.dart';
import '../../../../themes/colors.dart';
import '../../../../widgets/button/primary.dart';

class SOLInsufficientDialog {
  static Future<void> show(
    BuildContext context, {
    required VoidCallback onDismiss,
  }) {
    return DialogUtils.builder()
        .borderRadius(5.r)
        .noTitle()
        .customContent(InsufficientContent())
        .action(
          DialogAction.custom(
            widget: Builder(
              builder: (dialogContext) => IKnowButton(
                onPressed: () {
                  Navigator.of(dialogContext, rootNavigator: true).pop();
                  onDismiss();
                },
              ),
            ),
            dismissOnTap: false,
          ),
        )
        .show(context);
  }
}

class IKnowButton extends StatelessWidget {
  const IKnowButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: onPressed,
      width: double.infinity,
      backgroundColor: AppColors.primary,
      cutSize: 20.r,
      borderRadius: BorderRadius.zero,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      label: Text(
        S.of(context).iknow,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class InsufficientContent extends StatefulWidget {
  const InsufficientContent({super.key});

  @override
  State<InsufficientContent> createState() => _InsufficientContentState();
}

class _InsufficientContentState extends State<InsufficientContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).solInsufficient,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.textSecondary(context),
          ),
        ),
        // SizedBox(height: 12.h),
        // GestureDetector(
        //   onTap: () {
        //     setState(() {
        //       _dontShowAgain = !_dontShowAgain;
        //     });
        //     widget.onCheckboxChanged(_dontShowAgain);
        //   },
        //   child: Row(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       SizedBox(
        //         width: 18.w,
        //         height: 18.w,
        //         child: Checkbox(
        //           value: _dontShowAgain,
        //           onChanged: (value) {
        //             setState(() {
        //               _dontShowAgain = value ?? false;
        //             });
        //             widget.onCheckboxChanged(_dontShowAgain);
        //           },
        //           materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        //           side: const BorderSide(color: Colors.grey),
        //           visualDensity: VisualDensity.compact,
        //           shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(3),
        //           ),
        //         ),
        //       ),
        //       SizedBox(width: 8.w),
        //       Text(
        //         S.of(context).doNotShowAgain,
        //         style: TextStyle(
        //           fontSize: 14.sp,
        //           color: AppColors.textSecondary(context),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
