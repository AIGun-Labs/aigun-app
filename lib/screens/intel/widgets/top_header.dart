import 'package:flutter/material.dart';
import 'package:flutter_aigun/config/nav.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/utils/format/string.dart';
import 'package:flutter_aigun/widgets/image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LatestDiscoveriesSection extends StatelessWidget {
  const LatestDiscoveriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 13.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(context),
              SizedBox(height: 10.h),
              Row(
                spacing: 10.w,
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            spacing: 7.w,
                            children: [
                              _builditem(context),
                              _builditem(context),
                              _builditem(context),
                              _builditem(context),
                              _builditem(context),
                              _builditem(context),
                              _builditem(context),
                            ],
                          ))),
                  // IconButton(
                  //     padding: EdgeInsets.zero,
                  //     onPressed: () {
                  //       context.push(Routes.home, extra: NavIndex.trending);
                  //     },
                  //     icon: )

                  GestureDetector(
                    onTap: () {
                      context.push(Routes.home, extra: NavIndex.trending);
                    },
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      size: 24.sp,
                      color: AppColors.textQuaternary(context),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Divider(
          color: AppColors.card(context),
          thickness: 10,
          height: 10,
          // indent: 16, //
          // endIndent: 16,
        )
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    // return Row(
    //   crossAxisAlignment: CrossAxisAlignment.end,
    //   children: [
    //     Baseline(
    //       baseline: 20.sp,
    //       baselineType: TextBaseline.alphabetic,
    //       child: Text(
    //         "最新发现",
    //         style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
    //       ),
    //     ),
    //     SizedBox(width: 6.w),
    //     Baseline(
    //       baseline: 20.sp,
    //       baselineType: TextBaseline.alphabetic,
    //       child: Text(
    //         "没有噪音，只有先机",
    //         style: TextStyle(
    //             fontSize: 12.sp, color: AppColors.textQuaternary(context)),
    //       ),
    //     ),
    //   ],
    // );
    // 方法一：使用Text.rich + WidgetSpan插入SizedBox设置间距
    return Text.rich(
      TextSpan(children: [
        TextSpan(
          text: S.of(context).latestDiscoveries,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
        ),
        WidgetSpan(
          child: SizedBox(width: 6.w),
        ),
        TextSpan(
          text: S.of(context).app_title,
          style: TextStyle(
              fontSize: 12.sp, color: AppColors.textQuaternary(context)),
        ),
      ]),
    );
  }

  Widget _builditem(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 40.w,
          height: 40.h,
          child: CircleAvatar(
            child: CachedImage(
              imageUrl: "assets/images/icons/ai-agent.png",
              width: 40.w,
              height: 40.h,
            ),
          ),
        ),
        Text(
          StringFormatter.truncateWithEllipsis("DOGE"),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 12.sp, color: AppColors.textTertiary(context)),
        )
      ],
    );
  }
}
