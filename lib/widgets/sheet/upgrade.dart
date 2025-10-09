import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_aigun/themes/colors.dart';

class UpgradeSheet extends StatefulWidget {
  final String version;
  final List<String> features;
  final VoidCallback? onUpgrade;
  final VoidCallback? onSkip;

  const UpgradeSheet({
    super.key,
    this.version = '9.2.9',
    this.features = const [
      '⭐ 可体验最新自动化交易功能啦',
      '⭐ 支持20条公链查看数据',
      '⭐ 更安全的钱包升级',
      '⭐ 上线合约交易功能，可100x开多空',
    ],
    this.onUpgrade,
    this.onSkip,
  });

  @override
  State<UpgradeSheet> createState() => _UpgradeSheetState();
}

class _UpgradeSheetState extends State<UpgradeSheet> {
  void _onUpgrade() {
    widget.onUpgrade?.call();
    Navigator.pop(context);
  }

  void _onSkip() {
    widget.onSkip?.call();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
            widget.version,
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
              children: widget.features.map((feature) {
                return Text(
                  feature,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.textPrimary(context),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 24.h),

          // 升级按钮
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: _onUpgrade,
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

          // 跳过按钮
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: _onSkip,
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
      ),
    ));
  }
}
