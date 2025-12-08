import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../widgets/background_with_overlay.dart';
import '../../../../../widgets/logo.dart';

/// Auth Page Layout - Common layout wrapper for authentication screens
///
/// Provides consistent styling with background, safe area, and optional logo.
class AuthPageLayout extends StatelessWidget {
  const AuthPageLayout({
    super.key,
    required this.child,
    this.isLogo = false,
    this.isMask = false,
    this.overlayOpacity = 0.5,
    this.onBack,
  });

  final Widget child;
  final bool isLogo;
  final bool isMask;
  final Function()? onBack;
  final double overlayOpacity;

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;
    final keyboardHeight = viewInsets.bottom;
    final isKeyboardVisible = keyboardHeight > 0;

    return BackgroundWithOverlay(
      overlayOpacity: overlayOpacity,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              // Header area: back button and logo
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
                  if (Platform.isAndroid) 10.verticalSpace,
                  if (isLogo) LoginTitle(title: S.of(context).app_title),
                ],
              ),

              // Middle flexible area: fills remaining space
              const Spacer(),

              // Bottom area: form content fixed at bottom
              SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      child,
                      SizedBox(
                        height: isKeyboardVisible
                            ? 20.h
                            : Platform.isAndroid
                                ? 58.h
                                : 50.h,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Login Title with Logo
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
          SizedBox(height: 3.h),
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
