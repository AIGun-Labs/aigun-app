import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../themes/colors.dart';
import '../../../utils/extensions/string.dart';
import '../../../utils/image_utils.dart';
import '../../feature_image.dart';

class AvatarToken extends StatelessWidget {
  const AvatarToken(
      {super.key,
      this.avatar,
      this.chainLogo,
      this.width = 48,
      this.height = 48,
      this.chainLogoWidth,
      this.chainLogoHeight,
      this.tokenName,
      this.chainName,
      this.right,
      this.bottom,
      this.chainLogoWidget,
      this.tokenAvatarWidget});
  final String? avatar;
  final String? chainLogo;
  final double? width;
  final double? height;
  final double? chainLogoWidth;
  final double? chainLogoHeight;
  final String? tokenName;
  final String? chainName;

  final double? right;
  final double? bottom;
  final Widget? tokenAvatarWidget;
  final Widget? chainLogoWidget;

  @override
  Widget build(BuildContext context) {
    final double avatarWidth = width ?? 48.w;
    final double avatarHeight = height ?? 48.w;
    final double chainLogoSize =
        chainLogoWidth ?? chainLogoHeight ?? 24.w;

    return SizedBox(
        width: width ?? 48.w,
        height: height ?? 48.w,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            ClipOval(
              child: tokenAvatarWidget ??
                  FeatureImage(
                    url: ImageUtils.getImageProxyUrl(avatar),
                    width: avatarWidth,
                    height: avatarHeight,
                    fit: BoxFit.cover,
                    loadingWidget: _buildAvatarPlaceholder(context),
                    errorWidget: _buildAvatarPlaceholder(context),
                  ),
            ),
            if (chainLogo != null && chainLogo!.isNotEmpty)
              Positioned(
                bottom: bottom ?? 0,
                right: right ?? -chainLogoSize / 2,
                child: SizedBox(
                  width: chainLogoSize,
                  height: chainLogoSize,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1.w),
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: chainLogoWidget != null
                          ? SizedBox(
                              width: chainLogoSize,
                              height: chainLogoSize,
                              child: chainLogoWidget,
                            )
                          : FeatureImage(
                              url: ImageUtils.getImageUrl(chainLogo),
                              width: chainLogoSize,
                              height: chainLogoSize,
                              fit: BoxFit.cover,
                              errorWidget:
                                  _buildChainLogoPlaceholder(context, chainLogoSize),
                            ),
                    ),
                  ),
                ),
              )
          ],
        ));
  }

// 构建头像占位符
  Widget _buildAvatarPlaceholder(BuildContext context) {
    return ClipOval(
        child: Container(
      width: width ?? 48.w,
      height: height ?? 48.w,
      color: AppColors.tokenPlaceholderColor,
      child: Center(
        child: Text(
          tokenName?.isNotEmpty == true
              ? tokenName?.split('').first.toUpperCase() ?? "?"
              : "?",
          style: TextStyle(
              fontSize: 20.sp,
              color: Colors.white,
              fontWeight: FontWeight.w700),
        ),
      ),
    ));
  }

  // 构建头像占位符
  Widget _buildChainLogoPlaceholder(BuildContext context, double chainLogoSize) {
    return ClipOval(
        child: Container(
      width: chainLogoSize,
      height: chainLogoSize,
      color: AppColors.tokenPlaceholderColor,
      child: Center(
        child: Text(
          (chainName ?? '').splitValueByCount(count: 1),
          style: TextStyle(
              fontSize: 12.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      ),
    ));
  }
}
