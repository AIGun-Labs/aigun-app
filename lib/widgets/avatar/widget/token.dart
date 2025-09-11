import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/utils/resource.dart';
import 'package:flutter_aigun/widgets/image.dart';
import 'package:flutter_aigun/widgets/smart_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatarToken extends StatelessWidget {
  const AvatarToken({
    super.key,
    this.avatar,
    this.chainLogo,
    this.width = 48,
    this.height = 48,
    this.chainLogoWidth = 24,
    this.chainLogoHeight = 24,
    this.tokenName,
    this.chainName,
  });
  final String? avatar;
  final String? chainLogo;
  final double? width;
  final double? height;
  final double? chainLogoWidth;
  final double? chainLogoHeight;
  final String? tokenName;
  final String? chainName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        key: key,
        width: width ?? 48.w,
        height: height ?? 48.h,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            ClipOval(
              child: SmartNetworkImage(
                url: getImageUrl(avatar) ?? "",
                key: key,
                width: width ?? 48.w,
                height: height ?? 48.h,
                fit: BoxFit.cover,
                loadingWidget: _buildAvatarPlaceholder(context),
                errorWidget: _buildAvatarPlaceholder(context),
              ),
            ),
            Positioned(
              bottom: 0,
              right: -4,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.white, width: 1),
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: SmartNetworkImage(
                    url: getImageUrl(chainLogo) ?? "",
                    key: key,
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
      key: key,
      width: width ?? 48.w,
      height: height ?? 48.h,
      color: AppColors.tokenPlaceholderColor,
      child: Center(
        child: Text(
          tokenName?.split('').first.toUpperCase() ?? "?",
          style: TextStyle(fontSize: 20.sp, color: AppColors.white),
        ),
      ),
    ));
  }

  // 构建头像占位符
  Widget _buildChainLogoPlaceholder(BuildContext context) {
    return ClipOval(
        child: Container(
      key: key,
      width: chainLogoWidth ?? 24.w,
      height: chainLogoHeight ?? 24.h,
      color: AppColors.tokenPlaceholderColor,
      child: Center(
        child: Text(
          chainName?.split('').first.toUpperCase() ?? "?",
          style: TextStyle(fontSize: 12.sp, color: AppColors.white),
        ),
      ),
    ));
  }
}
