import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/service_locator.dart';
import '../../../../themes/colors.dart';
import '../../domain/entities/update_info.dart';
import '../cubit/update_cubit.dart';
import '../cubit/update_state.dart';

class Update extends StatefulWidget {
  final UpdateInfo info;
  final bool force;

  const Update({
    super.key,
    required this.info,
    required this.force,
  });

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<UpdateCubit>(),
      child: BlocListener<UpdateCubit, UpdateState>(
        listener: (context, state) {
          state.whenOrNull(
            downloaded: (info, filePath) {
              // 下载并校验成功，触发安装
              // _installApk(filePath);
            },
          );
        },
        child: PopScope(
          canPop: !widget.force,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.background(context),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            child: SafeArea(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 顶部图片和标题
                Stack(
                  alignment: Alignment.bottomCenter,
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(height: 108.h),
                    Positioned(
                      top: -60.h,
                      child: Image.asset(
                        "assets/images/upgrade.png",
                        width: 171.w,
                        height: 168.h,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),

                // 标题
                Text(
                  "新版本升级",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary(context),
                  ),
                ),
                SizedBox(height: 4.h),

                // 版本号
                Text(
                  widget.info.latest,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textSecondary(context),
                  ),
                ),
                SizedBox(height: 24.h),
                // 功能列表
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 60.w),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.info.notes.map((note) {
                      return Text(
                        "⭐ $note",
                        style: TextStyle(
                          fontSize: 16.sp,
                          height: 1.4.h,
                          color: AppColors.textPrimary(context),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                SizedBox(height: 24.h),

                // 按钮
                Column(
                  children: [
                    // 升级按钮
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50.h,
                        child: ElevatedButton(
                          onPressed: () {
                            getIt<UpdateCubit>().startDownload();
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.black,
                            foregroundColor: AppColors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            "升级",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50.h,
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            "跳过",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.textTertiary(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )),
          ),
        ),
      ),
    );
  }

  /// 安装 APK
  // Future<void> _installApk(String filePath) async {
  //   try {
  //     await InstallPlugin.install(filePath);
  //   } catch (e) {
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('安装失败：$e')),
  //       );
  //     }
  //   }
  // }
}
