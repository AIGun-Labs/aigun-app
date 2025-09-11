import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

/// 一个具有左下角切角效果的自定义按钮
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
      // 使用我们自定义的 Clipper
      clipper: CutCornerButtonClipper(cutSize: cutSize),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          // 设置按钮的背景色和前景色（文字颜色）
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          textStyle: Theme.of(context).textTheme.titleMedium,
          // 关键：将按钮自身的形状设置为矩形（无圆角），
          // 这样裁剪才能得到干净利落的直角。
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          // 为了让按钮足够大，可以设置一个最小尺寸或内边距
          padding: padding ??
              EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
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
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// 一个自定义的 Clipper，用于在右上角创建一个切角效果。
class CutCornerButtonClipper extends CustomClipper<Path> {
  /// 切角的大小
  final double cutSize;

  CutCornerButtonClipper({this.cutSize = 20.0});

  @override
  Path getClip(Size size) {
    final path = Path();

    // 1. 从左上角开始 (0, 0)
    path.moveTo(0, 0);

    // 2. 画到右上角切角的起始点 (width - cutSize, 0)
    path.lineTo(size.width - cutSize, 0);

    // 3. 画到右上角切角的结束点 (width, cutSize)
    path.lineTo(size.width, cutSize);

    // 4. 画到右下角 (width, height)
    path.lineTo(size.width, size.height);

    // 5. 画到左下角 (0, height)
    path.lineTo(0, size.height);

    // 6. 闭合路径，自动连接到起点 (0, 0)
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // 如果切角大小是动态变化的，这里应该返回 true
    return false;
  }
}
