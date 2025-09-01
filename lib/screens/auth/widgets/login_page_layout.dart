import "package:flutter/material.dart";
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
    return BackgroundWithOverlay(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                  if (isLogo) LoginTitle(title: "Your Web3 Secret Weapon"),
                ],
              ),
              SizedBox(height: 20.h),
              Column(
                children: [
                  child,
                  SizedBox(height: 100.h),
                ],
              )
            ],
          )
        ],
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
      padding: EdgeInsets.symmetric(vertical: 12.w),
      child: Column(
        children: [
          DogeXLogo(
            width: 210.w,
            height: 70.h,
          ),
          SizedBox(height: 10.h),
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).textTheme.headlineSmall?.color,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
