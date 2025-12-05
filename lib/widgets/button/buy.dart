import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

class BuyButton extends StatelessWidget {
  const BuyButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor = Colors.yellow,
    this.cutSize = 20.0,
    this.foregroundColor = Colors.black,
    this.isLoading = false,
    this.padding,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final Color backgroundColor;
  final double cutSize;
  final Color foregroundColor;
  final bool isLoading;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CutCornerButtonClipper(cutSize: cutSize),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          textStyle: Theme.of(context).textTheme.titleMedium,

          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),

          padding: padding ?? EdgeInsets.symmetric(horizontal: 20.w),
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
                  child: const CircularProgressIndicator(strokeWidth: 2),
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

    path.lineTo(size.width - cutSize, 0);

    path.lineTo(size.width, cutSize);

    path.lineTo(size.width, size.height);

    path.lineTo(0, size.height);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
