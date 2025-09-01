import 'package:flutter/material.dart';

/// 按钮装饰类型枚举
enum ButtonDecoration {
  /// 无装饰
  none,

  /// 右上角切口
  topRight,

  /// 右下角切口
  bottomRight,

  /// 左上角切口
  topLeft,

  /// 左下角切口
  bottomLeft,

  /// 所有角都有切口
  all,

  /// 只有顶部两个角有切口
  top,

  /// 只有底部两个角有切口
  bottom,

  /// 只有左侧两个角有切口
  left,

  /// 只有右侧两个角有切口
  right,
}

/// 一个带有可定制切口效果的自定义按钮。
///
/// 这个按钮是高度可定制的，允许自定义子组件、颜色、切口深度和点击事件。
/// 支持多种装饰类型，可以在不同位置创建切口效果。
class CutCornerButton extends StatelessWidget {
  final Widget child;

  /// 点击按钮时触发的回调函数。如果为 null，按钮将处于禁用状态。
  final VoidCallback? onPressed;

  /// 按钮的背景颜色。
  final Color? backgroundColor;

  /// 按钮前景（子组件）的颜色。
  final Color? foregroundColor;

  /// 切口的深度。值越大，切口越大。
  final double cutDepth;

  /// 按钮的内边距。
  final EdgeInsetsGeometry? padding;

  /// 按钮的装饰类型，决定切口的位置。
  final ButtonDecoration decoration;

  const CutCornerButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.backgroundColor = Colors.yellow,
    this.foregroundColor = Colors.black,
    this.cutDepth = 15.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    this.decoration = ButtonDecoration.topRight,
  });

  /// 根据装饰类型创建对应的 BorderRadius
  BorderRadius _createBorderRadius() {
    switch (decoration) {
      case ButtonDecoration.none:
        return BorderRadius.zero;
      case ButtonDecoration.topRight:
        return BorderRadius.only(
          topRight: Radius.circular(cutDepth),
        );
      case ButtonDecoration.bottomRight:
        return BorderRadius.only(
          bottomRight: Radius.circular(cutDepth),
        );
      case ButtonDecoration.topLeft:
        return BorderRadius.only(
          topLeft: Radius.circular(cutDepth),
        );
      case ButtonDecoration.bottomLeft:
        return BorderRadius.only(
          bottomLeft: Radius.circular(cutDepth),
        );
      case ButtonDecoration.all:
        return BorderRadius.all(Radius.circular(cutDepth));
      case ButtonDecoration.top:
        return BorderRadius.only(
          topLeft: Radius.circular(cutDepth),
          topRight: Radius.circular(cutDepth),
        );
      case ButtonDecoration.bottom:
        return BorderRadius.only(
          bottomLeft: Radius.circular(cutDepth),
          bottomRight: Radius.circular(cutDepth),
        );
      case ButtonDecoration.left:
        return BorderRadius.only(
          topLeft: Radius.circular(cutDepth),
          bottomLeft: Radius.circular(cutDepth),
        );
      case ButtonDecoration.right:
        return BorderRadius.only(
          topRight: Radius.circular(cutDepth),
          bottomRight: Radius.circular(cutDepth),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        // 设置前景和背景颜色
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,

        // 禁用阴影，使其看起来更扁平
        elevation: 0,

        // 设置内边距
        padding: padding,

        // 设置文本样式
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),

        shape: BeveledRectangleBorder(
          borderRadius: _createBorderRadius(),
        ),
      ),
      child: child,
    );
  }
}
