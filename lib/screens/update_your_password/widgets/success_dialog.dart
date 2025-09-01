import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/widgets/button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      contentPadding:
          EdgeInsets.only(top: 36.h, bottom: 24.h, left: 16.w, right: 16.w),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/happy.png',
              width: 173.w,
              height: 173.h,
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                S.of(context).authFlow_congratulations,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            CustomButton(
              text: S.of(context).authFlow_goToLogin,
              onPressed: () {
                context.push(Routes.login);
              },
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 20.sp,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
