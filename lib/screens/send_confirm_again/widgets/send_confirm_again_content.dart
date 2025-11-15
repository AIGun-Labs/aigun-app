import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'amount_display.dart';
import 'network_fees.dart';
import 'receiving_address.dart';

class SendConfirmAgainContent extends StatelessWidget {
  const SendConfirmAgainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Center(
              child: Image.asset(
                'assets/images/rethink.png',
                width: 150.w,
                height: 150.w,
              ),
            ),
            SizedBox(height: 20.h),
            // const AmountDisplay(),
            const AmountDisplay(),
            SizedBox(height: 40.h),
            const ReceivingAddress(),
            SizedBox(height: 15.h),
            const NetworkFees(),
            SizedBox(height: 25.h),
          ],
        ),
      ),
    );
  }
}
