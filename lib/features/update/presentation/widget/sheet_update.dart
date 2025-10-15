import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/service_locator.dart';
import '../../../../themes/colors.dart';
import '../../domain/entities/update_info.dart';
import '../cubit/update_cubit.dart';
import '../cubit/update_state.dart';

class UpgradeSheet extends StatefulWidget {
  final UpdateInfo info;
  final bool force;

  const UpgradeSheet({
    super.key,
    required this.info,
    required this.force,
  });

  @override
  State<UpgradeSheet> createState() => _UpgradeSheetState();
}

class _UpgradeSheetState extends State<UpgradeSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<UpdateCubit>(),
      child: BlocListener<UpdateCubit, UpdateState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            checking: () {},
            noUpdate: () {},
            available: (info, force) {},
            downloading: (info, progress) {},
            paused: (info, progress) {},
            verifying: (info) {},
            downloaded: (info, filePath) {
              // 下载并校验成功，触发安装
              // _installApk(filePath);
            },
            checksumFailed: (info) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('文件校验失败，请重新下载')),
              );
            },
            canceled: () {
              Navigator.pop(context);
            },
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );
            },
          );
        },
        child: PopScope(
          canPop: !widget.force,
          child: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.background(context),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              ),
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.info.notes.map((note) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: Text(
                            note,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.textPrimary(context),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // 下载进度或按钮
                  BlocBuilder<UpdateCubit, UpdateState>(
                    builder: (context, state) {
                      return state.when(
                        initial: () => _buildButtons(context),
                        checking: () => _buildButtons(context),
                        noUpdate: () => _buildButtons(context),
                        available: (info, force) => _buildButtons(context),
                        downloading: (info, progress) =>
                            _buildProgressBar(context, progress),
                        paused: (info, progress) =>
                            _buildPausedBar(context, progress),
                        verifying: (info) => _buildVerifyingIndicator(context),
                        downloaded: (info, path) => _buildInstalling(context),
                        checksumFailed: (info) => _buildButtons(context),
                        canceled: () => _buildButtons(context),
                        error: (message) => _buildButtons(context),
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 升级和跳过按钮
  Widget _buildButtons(BuildContext context) {
    return Column(
      children: [
        // 升级按钮
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: () {
                context.read<UpdateCubit>().startDownload();
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
        SizedBox(height: 2.h),

        // 跳过按钮（强制更新时不显示）
        if (!widget.force)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SizedBox(
              width: double.infinity,
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
    );
  }

  /// 下载进度条
  Widget _buildProgressBar(BuildContext context, double progress) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          LinearProgressIndicator(
            value: progress,
            minHeight: 8.h,
            backgroundColor: AppColors.borderSecondary(context),
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.black),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '下载中... ${(progress * 100).toStringAsFixed(0)}%',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textSecondary(context),
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () => context.read<UpdateCubit>().pause(),
                    child: Text(
                      '暂停',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.read<UpdateCubit>().cancel(),
                    child: Text(
                      '取消',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 暂停状态
  Widget _buildPausedBar(BuildContext context, double progress) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          LinearProgressIndicator(
            value: progress,
            minHeight: 8.h,
            backgroundColor: AppColors.borderSecondary(context),
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.black),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '已暂停 ${(progress * 100).toStringAsFixed(0)}%',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textSecondary(context),
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () => context.read<UpdateCubit>().resume(),
                    child: Text(
                      '继续',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.read<UpdateCubit>().cancel(),
                    child: Text(
                      '取消',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 校验中
  Widget _buildVerifyingIndicator(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          const CircularProgressIndicator(),
          SizedBox(height: 12.h),
          Text(
            '正在校验文件完整性...',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textSecondary(context),
            ),
          ),
        ],
      ),
    );
  }

  /// 安装中
  Widget _buildInstalling(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          const CircularProgressIndicator(),
          SizedBox(height: 12.h),
          Text(
            '准备安装...',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textSecondary(context),
            ),
          ),
        ],
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
