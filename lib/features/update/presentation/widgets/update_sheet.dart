import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/service_locator.dart';
import '../../../../l10n/l10n.dart';
import '../../../../themes/colors.dart';
import '../../domain/entities/config_entity.dart';
import '../../utils/notification_permission.dart';
import '../cubits/update_cubit.dart';

class UpdateSheet extends StatelessWidget {
  const UpdateSheet({super.key, required this.info, required this.force});
  final ConfigEntity info;
  final bool force;
  List<String> _getLocalizedNotes(BuildContext ctx) {
    final currentlocale = Localizations.localeOf(ctx);

    final code = currentlocale.languageCode;

    if (info.multilingualNotes.containsKey(code)) {
      return info.multilingualNotes[code] ?? [];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final localizedNotes = _getLocalizedNotes(context);
    return PopScope(
      canPop: !force,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.background(context),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                clipBehavior: Clip.none,
                children: [
                  SizedBox(height: 108.h),
                  Positioned(
                    top: -60.h,
                    child: Image.asset(
                      'assets/images/upgrade.png',
                      width: 171.w,
                      height: 168.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
              Text(
                S.of(context).newVersionUpgrade,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary(context),
                ),
              ),
              4.verticalSpace,
              Text(
                info.latest,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textSecondary(context),
                ),
              ),
              24.verticalSpace,
              Container(
                width: double.infinity,
                constraints: BoxConstraints(maxHeight: 260.h),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4.h,
                    children: localizedNotes.map((note) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 4.w,
                        children: [
                          Icon(
                            Icons.star,
                            size: 24.sp,
                            color: AppColors.tertiary,
                          ),
                          Flexible(
                            child: Text(
                              note,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColors.textPrimary(context),
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),

              24.verticalSpace,
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: () async {
                          await NotificationPermission.request();

                          getIt<UpdateCubit>().startDownload();
                          if (!context.mounted) return;
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
                  8.verticalSpace,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
