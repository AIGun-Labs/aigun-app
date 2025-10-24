import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/widgets/loading_gun.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QueryTokenLoading extends StatelessWidget {
  const QueryTokenLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 120.h),
          SizedBox(
            child: Column(
              children: [
                LoadingGun(width: 150.w, height: 150.h),
                Transform.translate(
                  offset: Offset(0, -15.h),
                  child: Text(S.of(context).searching,
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textPrimary(context))),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
