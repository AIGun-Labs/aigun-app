import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

import "../../themes/themes.dart";

class NeonCutCornerButton extends StatelessWidget {
  const NeonCutCornerButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.cutSize = 20.0,
    this.foregroundColor,
    this.isLoading = false,
    this.suffix,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final Color? backgroundColor;
  final double cutSize;
  final Color? foregroundColor;
  final bool isLoading;
  final Widget? suffix;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CutCornerButtonClipper(cutSize: cutSize),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary,
          foregroundColor: foregroundColor ?? AppColors.foreground(context),
          textStyle: Theme.of(context).textTheme.titleMedium,

          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),

          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 18.h),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            child,
            if (isLoading)
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.black,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class CutCornerButtonClipper extends CustomClipper<Path> {
  final double cutSize;

  CutCornerButtonClipper({this.cutSize = 20.0});

  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(0, 0);

    path.lineTo(size.width, 0);

    path.lineTo(size.width, size.height);

    path.lineTo(cutSize, size.height);

    path.lineTo(0, size.height - cutSize);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
