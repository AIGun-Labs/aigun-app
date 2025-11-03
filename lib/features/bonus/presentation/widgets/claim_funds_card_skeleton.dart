import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import 'card_widget.dart';

class ClaimFundsCardSkeleton extends StatelessWidget {
  const ClaimFundsCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      paddingValue: 14,
      backgroundColor: Colors.white,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 10.w,
              children: [
                ClipOval(
                    child: Container(
                        width: 40.w, height: 40.w, color: Colors.white)),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: 32.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                )
              ],
            ),
            Container(
              width: 100.w,
              height: 28.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            Container(
              width: double.infinity,
              height: 18.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            Container(
              width: double.infinity,
              height: 32.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50.r),
              ),
            )
          ],
        ),
      ),
    );
  }
}
