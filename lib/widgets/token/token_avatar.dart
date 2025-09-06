import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/utils/resource.dart';
import 'package:flutter_aigun/widgets/image.dart';
import 'package:flutter_aigun/widgets/smart_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TokenAvatar extends StatelessWidget {
  const TokenAvatar({
    super.key,
    required this.avatar,
    required this.chainLogo,
    this.width = 48,
    this.height = 48,
    this.chainLogoWidth = 24,
    this.chainLogoHeight = 24,
    this.placeholderText,
  });
  final String avatar;
  final String chainLogo;
  final double? width;
  final double? height;
  final double? chainLogoWidth;
  final double? chainLogoHeight;
  final String? placeholderText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width ?? 48.w,
        height: height ?? 48.h,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            ClipOval(
              child: SmartNetworkImage(
                url: getImageUrl(avatar) ?? "",
                width: width ?? 48.w,
                height: height ?? 48.h,
                fit: BoxFit.cover,
                // loadingWidget: const Center(
                //   child: CircularProgressIndicator(color: AppColors.quinary),
                // ),
                errorWidget: CachedImage(
                    imageUrl: "assets/images/icons/ai-agent.png",
                    height: height ?? 48.h,
                    width: width ?? 48.w),
              ),
            ),
            Positioned(
              bottom: -4,
              right: -4,
              child: ClipOval(
                child: SmartNetworkImage(
                  url: getImageUrl(chainLogo) ?? "",
                  width: chainLogoWidth ?? 24.w,
                  height: chainLogoHeight ?? 24.h,
                  fit: BoxFit.cover,
                  loadingWidget: CachedImage(
                      imageUrl: "assets/images/icons/ai-agent.png",
                      height: chainLogoHeight ?? 24.h,
                      width: chainLogoWidth ?? 24.w),
                  errorWidget: CachedImage(
                      imageUrl: "assets/images/icons/ai-agent.png",
                      height: chainLogoHeight ?? 24.h,
                      width: chainLogoWidth ?? 24.w),
                ),
              ),
            )
          ],
        ));
  }

  Widget _buildAvatarPlaceholder(BuildContext context) {
    // return ClipOval(
    //   child: SmartNetworkImage(
    //     url: getImageUrl(avatar) ?? "",
    //     width: width ?? 48.w,
    //     height: height ?? 48.h,
    //     fit: BoxFit.cover,
    //     loadingWidget: const Center(
    //       child: CircularProgressIndicator(),
    //     ),
    //     errorWidget: CachedImage(
    //         imageUrl: "assets/images/icons/ai-agent.png",
    //         height: height ?? 48.h,
    //         width: width ?? 48.w),
    //   ),
    // );

    return ClipOval(
        child: Container(
      width: width ?? 48.w,
      height: height ?? 48.h,
      color: AppColors.background(context),
      child: Center(
        child: Text(placeholderText ?? ""),
      ),
    ));
  }
}
