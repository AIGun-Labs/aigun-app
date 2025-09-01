import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 新消息提示组件
class NewMessageIndicator extends StatelessWidget {
  /// 新消息数量
  final int messageCount;

  /// 点击回调函数
  final VoidCallback onTap;

  const NewMessageIndicator({
    super.key,
    required this.messageCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 12,
      left: 0,
      right: 0,
      child: Center(
        child: Material(
          // 添加水波纹效果
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(24.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.quinary,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.quinary.withValues(alpha: .3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.arrow_upward,
                    color: AppColors.textPrimary(context),
                    size: 16.sp,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    S.of(context).ui_newMessage(messageCount),
                    style: TextStyle(
                      color: AppColors.textPrimary(context),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
