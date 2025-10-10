import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/utils/extensions/string.dart';
import 'package:flutter_aigun/utils/resource.dart';
import 'package:flutter_aigun/widgets/smart_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatarToken extends StatelessWidget {
  const AvatarToken(
      {super.key,
      this.avatar,
      this.chainLogo,
      this.width = 48,
      this.height = 48,
      this.chainLogoWidth = 24,
      this.chainLogoHeight = 24,
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
    return SizedBox(
        width: width ?? 48.w,
        height: height ?? 48.h,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            ClipOval(
              child: tokenAvatarWidget ??
                  SmartNetworkImage(
                    url: getImageUrl(avatar) ?? "",
                    width: width ?? 48.w,
                    height: height ?? 48.h,
                    fit: BoxFit.cover,
                    loadingWidget: _buildAvatarPlaceholder(context),
                    errorWidget: _buildAvatarPlaceholder(context),
                  ),
            ),
            if (chainLogo != null && chainLogo!.isNotEmpty)
              Positioned(
                bottom: bottom ?? 0,
                right: right ?? -(chainLogoWidth ?? 24.w) / 2,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1.w),
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: chainLogoWidget != null
                        ? SizedBox(
                            width: chainLogoWidth ?? 24.w,
                            height: chainLogoHeight ?? 24.h,
                            child: chainLogoWidget,
                          )
                        : SmartNetworkImage(
                            url: getImageUrl(chainLogo) ?? "",
                            width: chainLogoWidth ?? 24.w,
                            height: chainLogoHeight ?? 24.h,
                            fit: BoxFit.cover,
                            loadingWidget: _buildChainLogoPlaceholder(context),
                            errorWidget: _buildChainLogoPlaceholder(context),
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
      height: height ?? 48.h,
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
  Widget _buildChainLogoPlaceholder(BuildContext context) {
    return ClipOval(
        child: Container(
      width: chainLogoWidth ?? 24.w,
      height: chainLogoHeight ?? 24.h,
      color: AppColors.tokenPlaceholderColor,
      child: Center(
        child: Text(
          (chainName ?? '').splitValueByCount(),
          style: TextStyle(
              fontSize: 12.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      ),
    ));
  }
}
