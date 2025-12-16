import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../themes/themes.dart';
import '../../../utils/image_utils.dart';
import '../../../widgets/feature_image.dart';

class NetworkLogo extends StatelessWidget {
  const NetworkLogo({super.key, required this.url, required this.name});
  final String url;
  final String name;

  Widget _buildPlaceholder() {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.tokenPlaceholderColor,
        shape: BoxShape.circle,
      ),
      width: 45.w,
      height: 45.w,
      child: Center(
        child: Text(
          name.isNotEmpty ? name.split('').first : '?',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: FeatureImage(
        url: ImageUtils.getImageProxyUrl(url),
        width: 45.w,
        height: 45.w,
        fit: BoxFit.cover,
        loadingWidget: _buildPlaceholder(),
        errorWidget: _buildPlaceholder(),
      ),
    );
  }
}
