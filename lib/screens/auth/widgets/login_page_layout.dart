import "package:flutter/material.dart";
import "package:flutter_aigun/l10n/l10n.dart";
import "package:flutter_aigun/widgets/background_with_overlay.dart";
import "package:flutter_aigun/widgets/logo.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

class AuthPageLayout extends StatelessWidget {
  const AuthPageLayout(
      {super.key,
      required this.child,
      this.isLogo = false,
      this.isMask = false,
      this.onBack});

  final Widget child;
  final bool isLogo;
  final bool isMask;
  final Function()? onBack;

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;
    final keyboardHeight = viewInsets.bottom;
    final isKeyboardVisible = keyboardHeight > 0;

    return BackgroundWithOverlay(
        child: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            // 头部区域：返回按钮和Logo
            Column(
              children: [
                if (onBack != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: onBack,
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30.sp,
                      ),
                    ),
                  ),
                if (isLogo) LoginTitle(title: S.of(context).app_title),
              ],
            ),

            // 中间弹性区域：占满剩余空间
            // const Expanded(
            //   child: SizedBox.shrink(),
            // ),
            const Spacer(),

            // 底部区域：表单内容固定在底部
            SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    child,
                    SizedBox(height: isKeyboardVisible ? 20.h : 60.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class LoginTitle extends StatelessWidget {
  const LoginTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.w),
      child: Column(
        children: [
          AIGunLogo(
            width: 200.w,
            height: 50.h,
          ),
          SizedBox(height: 10.h),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
