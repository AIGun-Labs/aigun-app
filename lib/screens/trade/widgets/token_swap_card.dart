import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/index.dart';
import 'package:flutter_aigun/widgets/image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TokenSwapCard extends StatelessWidget {
  const TokenSwapCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.background(context),
      // shadowColor: Colors.grey[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(
          color: AppColors.border(context), // 边框颜色
          width: 1.r, // 边框宽度
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                _buildTokenIcon(),
                SizedBox(width: 8.w),
                Text(
                  "SOL",
                  style: TextStyle(fontSize: 18.w),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 18.w,
                )
              ],
            ),
            // Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "2",
                  style: TextStyle(
                      fontSize: 35.sp, color: AppColors.textPrimary(context)),
                ),
                Text(
                  "\$420.98",
                  style: TextStyle(
                      fontSize: 16.sp, color: AppColors.textSecondary(context)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTokenIcon() {
    return Stack(
      children: [
        ClipOval(
          // child: SmartNetworkImage(
          //   // url: getImageUrl(token?.logo) ?? "",
          //   url: ,
          //   width: 48.w,
          //   height: 48.h,
          //   fit: BoxFit.cover,
          // ),
          child: CachedImage(
            imageUrl: "",
            height: 48.h,
            width: 48.w,
            borderRadius: BorderRadius.circular(24.r),
          ),
        ),
        Positioned(
          bottom: -4,
          right: -4,
          child: ClipOval(
            // child: SmartNetworkImage(
            //   // url: getImageUrl(token?.chain?.logo) ?? "",
            //   url: "",
            //   width: 24.w,
            //   height: 24.h,
            //   fit: BoxFit.cover,
            // ),
            child: CachedImage(
              imageUrl: "",
              height: 24.h,
              width: 24.w,
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        )
      ],
    );
  }
}
