import 'package:flutter/material.dart';
import 'package:flutter_aigun/widgets/image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_aigun/l10n/l10n.dart';

class IntelFollowSection extends StatelessWidget {
  const IntelFollowSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      margin: EdgeInsets.only(top: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(S.of(context).intel_followMoreIntel),
          Row(
            children: [
              _buildFollowAvatar(),
              SizedBox(width: 5.w),
              _buildFollowAvatar(),
              SizedBox(width: 5.w),
              _buildFollowAvatar(),
              SizedBox(width: 5.w),
              Icon(
                Icons.arrow_forward_ios,
                size: 20.w,
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFollowAvatar() {
    return CachedImage(
      borderRadius: BorderRadius.circular(33.w),
      imageUrl: 'assets/images/token.webp',
      width: 30.w,
      height: 30.w,
    );
  }
}
