import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../themes/colors.dart';
import '../../../utils/image_utils.dart';
import '../../smart_network_image.dart';

class AvatarRoundToken extends StatelessWidget {
  const AvatarRoundToken({
    super.key,
    this.avatar,
    this.size = 48,
    this.tokenName,
  });
  final String? avatar;
  final double? size;
  final String? tokenName;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: SmartNetworkImage(
        url: ImageUtils.getImageUrl(avatar),
        width: size,
        height: size,
        fit: BoxFit.cover,
        loadingWidget: _buildAvatarPlaceholder(context),
        errorWidget: _buildAvatarPlaceholder(context),
      ),
    );
  }

  Widget _buildAvatarPlaceholder(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        width: size,
        height: size,
        color: AppColors.tokenPlaceholderColor,
        child: Center(
          child: Text(
            tokenName?.isNotEmpty == true
                ? tokenName?.split('').first.toUpperCase() ?? "?"
                : "?",
            style: TextStyle(
              fontSize: 20.sp,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
