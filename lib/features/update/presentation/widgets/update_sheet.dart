import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/service_locator.dart';
import '../../../../cubits/language/language_cubit.dart';
import '../../../../l10n/l10n.dart';
import '../../../../themes/colors.dart';
import '../../domain/entities/update_info.dart';
import '../cubit/update_cubit.dart';

class UpdateSheet extends StatefulWidget {
  final UpdateInfo info;
  final bool force;

  const UpdateSheet({
    super.key,
    required this.info,
    required this.force,
  });

  @override
  State<UpdateSheet> createState() => _UpdateSheetState();
}

class _UpdateSheetState extends State<UpdateSheet> {
  // 获取当前语言对应的 notes
  List<String> _getLocalizedNotes(String currentLanguage) {
    // 优先使用 multilingualNotes 中对应语言的内容
    if (widget.info.multilingualNotes != null &&
        widget.info.multilingualNotes!.containsKey(currentLanguage)) {
      switch (currentLanguage) {
        case 'zh':
          return widget.info.multilingualNotes?['zh'] ?? widget.info.notes;
        case 'en':
          return widget.info.multilingualNotes?['en'] ?? widget.info.notes;
        default:
          return widget.info.notes;
      }
    }

    return widget.info.notes;
  }

  @override
  Widget build(BuildContext context) {
    final currentLanguage = getIt<LanguageCubit>().getCurrentLanguageCode();
    final localizedNotes = _getLocalizedNotes(currentLanguage);
    return PopScope(
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
              S.of(context).newVersionUpgrade,
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
                children: localizedNotes.map((note) {
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
                        S.of(context).upgrade,
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
                        S.of(context).skip,
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
    );
  }
}
