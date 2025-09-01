import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class UnregisteredBottomSheet extends StatelessWidget {
  const UnregisteredBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20.h),
          CircleAvatar(
            radius: 47.r,
            backgroundColor: Colors.white,
            child: Image.asset(
              'assets/images/app-logo-trans.png',
              width: 150.w,
              height: 150.h,
            ),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Text(
              S.of(context).validation_emailNotRegistered,
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          _buildRegisterButton(context),
          SizedBox(height: 10.h),
          _buildCancelButton(context),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.of(context).pop();
        // 注册逻辑
        context.read<ForgotPasswordCubit>().reset();
        context.replace(Routes.login);
      },
      icon: SvgPicture.asset(
        'assets/images/icons/icons8-flash.svg',
        colorFilter: const ColorFilter.mode(
          Colors.white,
          BlendMode.srcIn,
        ),
        height: 26.h,
        width: 26.w,
      ),
      label: Text(
        S.of(context).common_register,
        style: TextStyle(fontSize: 20.sp),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 60.h),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () => Navigator.of(context).pop(),
      style: OutlinedButton.styleFrom(
        minimumSize: Size(double.infinity, 60.h),
        side: const BorderSide(color: Colors.grey),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      child: Text(
        S.of(context).common_cancel,
        style: TextStyle(fontSize: 20.sp),
      ),
    );
  }
}
