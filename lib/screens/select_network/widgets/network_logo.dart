import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/widgets/smart_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NetworkLogo extends StatelessWidget {
  final String url;
  final String name;

  const NetworkLogo({super.key, required this.url, required this.name});

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
          name.isNotEmpty ? name.split('').first : "?",
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
      child: SmartNetworkImage(
        url: url,
        width: 45.w,
        height: 45.w,
        fit: BoxFit.cover,
        loadingWidget: _buildPlaceholder(),
        errorWidget: _buildPlaceholder(),
      ),
    );
  }
}
