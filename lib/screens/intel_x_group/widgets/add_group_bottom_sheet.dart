import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/index.dart';
import 'package:flutter_aigun/widgets/button.dart';
import 'package:flutter_aigun/widgets/input.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddGroupBottomSheet extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onConfirm;
  final String title;

  const AddGroupBottomSheet({
    super.key,
    required this.controller,
    required this.onConfirm,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 16.w,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16.w,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                color: Theme.of(context).textTheme.bodyMedium?.color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          CustomInput(
            controller: controller,
            hintText: S.of(context).form_intelXGroupNameHint,
            fontSize: 16.sp,
            height: 55.h,
            borderRadius: BorderRadius.circular(10.r),
            isOutline: true,
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: onConfirm,
                  height: 50.h,
                  backgroundColor: AppColors.background(context),
                  borderSide: BorderSide.none,
                  textColor: AppColors.textPrimary(context),
                  child: Text(S.of(context).common_confirm),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: CustomButton(
                  onPressed: () => Navigator.pop(context),
                  height: 50.h,
                  backgroundColor: AppColors.background(context),
                  textColor: Colors.black,
                  borderSide: BorderSide(
                    color: AppColors.textQuinary(context),
                  ),
                  child: Text(S.of(context).common_cancel),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
