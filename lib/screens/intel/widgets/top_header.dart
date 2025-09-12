import 'package:flutter/material.dart';
import 'package:flutter_aigun/config/nav.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/cubits/trending/trending_state.dart';
import 'package:flutter_aigun/data/models/trending/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/utils/format/string.dart';
import 'package:flutter_aigun/utils/resource.dart';
import 'package:flutter_aigun/widgets/smart_network_image.dart';
import 'package:flutter_aigun/widgets/token_skeleton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                // spacing: 10.w,
                children: [
                  // Expanded(
                  //     child: SingleChildScrollView(
                  //         scrollDirection: Axis.horizontal,
                  //         child: _buildItems(context))),
                  Expanded(
                      child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: _buildItems(context),
                  )),
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
        // Divider(
        //   color: AppColors.card(context),
        //   thickness: 10,
        //   height: 10,
        // )
      ],
    );
  }

  Widget _buildItems(BuildContext context) {
    return BlocBuilder<TrendingCubit, TrendingState>(builder: (context, state) {
      final items = Row(
        spacing: 8.w,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...state.lastestTokens.map((token) => _buildItem(context, token)),
        ],
      );

      return state.status.maybeWhen(
        orElse: () {
          return const HeaderTokenSkeleton(itemCount: 6);
        },
        loading: () {
          // 成功状态，显示真实数据
          if (state.lastestTokens.isEmpty) {
            return const HeaderTokenSkeleton(itemCount: 6);
          }
          return items;
        },
        success: (tokens) {
          // 成功状态，显示真实数据
          if (state.lastestTokens.isEmpty) {
            return const HeaderTokenSkeleton(itemCount: 6);
          }
          return items;
        },
      );
    });
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

  Widget _buildItem(BuildContext context, LastestToken token) {
    final tokenName = token.name?.split('').first.toUpperCase();
    if (tokenName?.isEmpty ?? true) return const SizedBox.shrink();
    return Column(
      children: [
        SizedBox(
          width: 40.w,
          height: 40.h,
          child: ClipOval(
            child: SmartNetworkImage(
              url: getImageUrl(token.logo) ?? "",
              width: 40.w,
              height: 40.h,
              // loadingWidget: Container(
              //   width: 40.w,
              //   height: 40.h,
              //   color: AppColors.tokenPlaceholderColor,
              //   child: Center(
              //     // child: CircularProgressIndicator(),
              //     child: Text(
              //       token.symbol?.split('').first ?? "",
              //       style: TextStyle(
              //           fontSize: 20.sp, color: AppColors.background(context)),
              //     ),
              //   ),
              // ),
              errorWidget: Container(
                width: 40.w,
                height: 40.h,
                color: AppColors.tokenPlaceholderColor,
                child: Center(
                  // child: CircularProgressIndicator(),
                  child: Text(
                    tokenName ?? "",
                    style: TextStyle(
                        fontSize: 20.sp, color: AppColors.background(context)),
                  ),
                ),
              ),
            ),
          ),
        ),
        Text(
          StringFormatter.truncateWithEllipsis(token.name ?? ""),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 11.sp, color: AppColors.textTertiary(context)),
        )
      ],
    );
  }
}
