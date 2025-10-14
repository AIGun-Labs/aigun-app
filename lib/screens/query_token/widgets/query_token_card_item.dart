import 'package:flutter/material.dart';
import 'package:flutter_aigun/data/models/token/query_token/query_token.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/utils/web3/address.dart';
import 'package:flutter_aigun/widgets/avatar/widget/token.dart';
import 'package:flutter_aigun/widgets/button/primary.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class QueryTokenCardItem extends StatelessWidget {
  const QueryTokenCardItem({super.key, required this.queryToken});

  final QueryToken queryToken;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.border(context)),
            borderRadius: BorderRadius.circular(5.r)),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AvatarToken(
                  width: 50.w,
                  height: 50.h,
                  chainLogoHeight: 20.h,
                  chainLogoWidth: 20.w,
                  avatar: queryToken.logo,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Panda(China Pa..)",
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "\$2,413.32",
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Web3Address.desensitization(
                              "0x1234567890123456789012345678901234567890"),
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.textPrimary(context)),
                        ),
                        Text(
                          Web3Address.desensitization("-18%"),
                          style: TextStyle(
                              fontSize: 16.sp, color: AppColors.secondary),
                        ),
                      ],
                    ),
                  ],
                ))
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "流通市值",
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.textSecondary(context)),
                      ),
                      Text(
                        "\$2,413.32",
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: AppColors.textPrimary(context)),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "流通市值",
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.textSecondary(context)),
                      ),
                      Text(
                        "\$2,413.32",
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: AppColors.textPrimary(context)),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "流通市值",
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.textSecondary(context)),
                      ),
                      Text(
                        "\$2,413.32",
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: AppColors.textPrimary(context)),
                      )
                    ],
                  )
                ],
              ),
            ),
            const QueryTokenCardButton()
          ],
        ),
      ),
    );
  }
}

class QueryTokenCardButton extends StatelessWidget {
  const QueryTokenCardButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      // disabledBackgroundColor: AppColors.quaternary,
      onPressed: () {},
      borderRadius: BorderRadius.zero,
      // isLoading: isLoading,
      width: double.infinity,
      height: 50.h,
      cutSize: 20.0,
      backgroundColor: AppColors.primary,
      textColor: Colors.black,
      fontSize: 16.sp,
      icon: SvgPicture.asset(
        "assets/images/icons/aim-outline.svg",
        colorFilter: const ColorFilter.mode(
          Colors.black,
          BlendMode.srcIn,
        ),
      ),
      label: Text(
        "立即买入",
        style: TextStyle(fontSize: 18.sp),
      ),
    );
  }
}
