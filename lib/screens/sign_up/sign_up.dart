import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/index.dart';
import 'package:flutter_aigun/widgets/appbar.dart';
import 'package:flutter_aigun/widgets/background_with_overlay.dart';
import 'package:flutter_aigun/widgets/bottom_logo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(
        backgroundColor: Colors.transparent,
        leadingIconColor: Colors.white,
      ),
      body: BackgroundWithOverlay(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).branding_createYourAccount,
                      style: TextStyle(
                        fontSize: 24.sp,
                        color: AppColors.textPrimary(context),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 25.h),
                    SignUpForm(),
                  ],
                ),
              ),
            ),
            const BottomLogo(),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
