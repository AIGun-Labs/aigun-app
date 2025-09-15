import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/widgets/appbar.dart';
import 'package:flutter_aigun/widgets/background_with_overlay.dart';
import 'package:flutter_aigun/widgets/bottom_logo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class UploadPictureScreen extends StatelessWidget {
  const UploadPictureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(),
      body: BackgroundWithOverlay(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.0.w),
                child: _buildContent(context),
              ),
            ),
            const BottomLogo(),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 80.h),
        _buildTitle(context),
        SizedBox(height: 40.h),
        _buildAvatar(),
        SizedBox(height: 35.h),
        _buildButtonRow(context),
        SizedBox(height: 60.h),
        _buildFinishButton(context),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      S.of(context).authFlow_uploadProfilePicture,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 24.sp,
        color: AppColors.textPrimary(context),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildAvatar() {
    return Center(
      child: CircleAvatar(
        radius: 80.r,
        backgroundColor: Colors.grey.shade300,
        child: Icon(
          Icons.person,
          size: 100.sp,
          color: Colors.grey.shade700,
        ),
      ),
    );
  }

  Widget _buildButtonRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildUploadButton(context),
        SizedBox(width: 15.w),
        _buildRandomButton(context),
      ],
    );
  }

  Widget _buildUploadButton(BuildContext context) {
    return Flexible(
      child: ElevatedButton.icon(
        onPressed: () {
          // 上传逻辑
        },
        icon: SvgPicture.asset('assets/images/icons/icons8-upload.svg'),
        label: Text(
          S.of(context).common_upload,
          style: TextStyle(fontSize: 20.sp),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.textPrimary(context),
          foregroundColor: Colors.black,
          padding: EdgeInsets.symmetric(
            vertical: 20.h,
          ),
        ),
      ),
    );
  }

  Widget _buildRandomButton(BuildContext context) {
    return Flexible(
      child: ElevatedButton.icon(
        onPressed: () {
          // 随机头像逻辑
        },
        icon: SvgPicture.asset('assets/images/icons/icons8-random.svg'),
        label: Text(
          S.of(context).common_random,
          style: TextStyle(fontSize: 20.sp),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.textPrimary(context),
          foregroundColor: Colors.black,
          padding: EdgeInsets.symmetric(
            vertical: 20.h,
          ),
        ),
      ),
    );
  }

  Widget _buildFinishButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // 完成逻辑
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(200.w, 48.h),
              backgroundColor: AppColors.textPrimary(context),
              foregroundColor: Colors.black,
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
                vertical: 18.h,
              ),
            ),
            child: Text(
              S.of(context).common_finish,
              style: TextStyle(fontSize: 20.sp),
            ),
          ),
        )
      ],
    );
  }
}
