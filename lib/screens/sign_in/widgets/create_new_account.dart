import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/widgets/button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class CreateNewAccount extends StatelessWidget {
  const CreateNewAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20.h),
          CustomButton(
            onPressed: () {
              // 跳转到注册页面
              context.push(Routes.login);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/icons/icons8-flash.svg',
                  height: 30.h,
                ),
                SizedBox(width: 5.w),
                Text(
                  S.of(context).branding_createNewAccount,
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.white,
              ),
              children: [
                TextSpan(text: S.of(context).terms_acceptTerms),
                TextSpan(
                  text: S.of(context).terms_termsOfService,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.white,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // 跳转到服务条款页面
                      context.go('/terms');
                    },
                ),
                TextSpan(text: S.of(context).ui_and),
              ],
            ),
          ),
          SizedBox(height: 5.h),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.white,
              ),
              children: [
                TextSpan(text: S.of(context).terms_acknowledgePrivacy),
                TextSpan(
                  text: S.of(context).terms_privacy,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.white,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // 跳转到隐私政策页面
                      context.go('/privacy');
                    },
                ),
                TextSpan(text: S.of(context).ui_and),
              ],
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            S.of(context).terms_cookieNotice,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
