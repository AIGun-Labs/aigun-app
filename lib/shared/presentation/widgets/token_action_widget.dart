import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../themes/colors.dart';

class TokenActionWidget extends StatelessWidget {
  const TokenActionWidget({
    super.key,
    this.onTransfer,
    this.onCollect,
    this.isCollected = false,
  });
  final VoidCallback? onTransfer;
  final VoidCallback? onCollect;
  final bool isCollected;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(3.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 15.w,
          children: [
            if (onCollect != null)
              InkResponse(
                onTap: onCollect,
                child: Icon(
                  color: isCollected ? AppColors.tertiary : Colors.white,
                  isCollected ? Icons.star_rounded : Icons.star_border_rounded,
                  size: 28.sp,
                ),
              ),
            if (onTransfer != null)
              InkResponse(
                onTap: onTransfer,
                child: Icon(
                  color: Colors.white,
                  Icons.vertical_align_top_rounded,
                  size: 26.sp,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
