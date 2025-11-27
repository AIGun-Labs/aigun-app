import 'package:flutter/material.dart';
import '../gen/assets.gen.dart';
import '../themes/colors.dart';
import 'image.dart';

/// 默认头像组件
/// 支持网络头像、本地头像、占位符文字等多种显示方式
class DefaultAvatar extends StatelessWidget {
  /// 头像URL (网络图片或本地资源路径)
  final String? avatarUrl;

  /// 头像尺寸
  final double size;

  /// 占位符文字（当没有头像时显示的文字，如用户名的首字母）
  final String? placeholderText;

  /// 占位符文字大小
  final double? placeholderTextSize;

  /// 头像形状，默认为圆形
  final BoxShape shape;

  /// 自定义占位符组件
  final Widget? customPlaceholder;

  /// 加载失败时的占位符组件
  final Widget? errorWidget;

  /// 是否显示边框
  final bool showBorder;

  /// 边框颜色
  final Color? borderColor;

  /// 边框宽度
  final double borderWidth;

  const DefaultAvatar({
    super.key,
    this.avatarUrl,
    this.size = 48.0,
    this.placeholderText,
    this.placeholderTextSize,
    this.shape = BoxShape.circle,
    this.customPlaceholder,
    this.errorWidget,
    this.showBorder = false,
    this.borderColor,
    this.borderWidth = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final Widget avatar = _buildAvatarContent();

    if (showBorder) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: shape,
          border: Border.all(
            color:
                borderColor ?? AppColors.backgroundWhite.withValues(alpha: 0.2),
            width: borderWidth,
          ),
        ),
        child: ClipPath(
          clipper: shape == BoxShape.circle ? _CircleClipper() : null,
          child: avatar,
        ),
      );
    }

    return SizedBox(
      width: size,
      height: size,
      child: ClipPath(
        clipper: shape == BoxShape.circle ? _CircleClipper() : null,
        child: avatar,
      ),
    );
  }

  Widget _buildAvatarContent() {
    // 如果有头像URL，显示头像
    if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      return CachedImage(
        imageUrl: avatarUrl!,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorWidget: _buildPlaceholder(),
      );
    }

    // 如果没有头像URL，显示占位符
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    // 如果有自定义占位符，使用自定义占位符
    if (customPlaceholder != null) {
      return customPlaceholder!;
    }

    // 如果有占位符文字，显示文字占位符
    if (placeholderText != null && placeholderText!.isNotEmpty) {
      return Container(
        width: size,
        height: size,
        color: AppColors.tokenPlaceholderColor,
        child: Center(
          child: Text(
            placeholderText!.length > 2
                ? placeholderText!.substring(0, 2).toUpperCase()
                : placeholderText!.toUpperCase(),
            style: TextStyle(
              fontSize: placeholderTextSize ?? (size * 0.4),
              fontWeight: FontWeight.w600,
              color: AppColors.backgroundWhite,
            ),
          ),
        ),
      );
    }

    // 默认显示默认头像图片
    return Assets.images.defaultAvatar.image(
      width: size,
      height: size,
      fit: BoxFit.cover,
    );
  }
}

/// 圆形裁剪器
class _CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..addOval(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2,
      ));
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
