import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../themes/themes.dart';
import '../../../widgets/button/primary.dart';
import '../../../widgets/image.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget(
      {super.key,
      this.onRetry,
      this.errorTextDesc,
      this.fontSize,
      this.paddingHorizontal,
      this.paddingVertical,
      this.width,
      this.buttonText,
      this.height});

  final VoidCallback? onRetry;
  final String? errorTextDesc;
  final int? fontSize;
  final int? paddingHorizontal;
  final int? paddingVertical;
  final int? width;
  final int? height;
  final String? buttonText;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CachedImage(
          imageUrl: const $AssetsImagesGen().notMoreSearch.path,
          width: 189.w,
          height: 197.h,
        ),
        16.verticalSpace,
        Text(
          errorTextDesc ?? S.of(context).noReceivedFromServer,
          style: TextStyle(
              fontSize: 16.sp, color: AppColors.textSecondary(context)),
          textAlign: TextAlign.center,
        ),
        8.verticalSpace,
        onRetry != null
            ? PrimaryButton(
                cutSize: 20.0,
                onPressed: onRetry ?? () {},
                label: Text(buttonText ?? S.of(context).retry),
                textColor: Colors.black,
                backgroundColor: AppColors.primary,
                fontSize: 16.sp,
                width: width?.w,
                height: height?.h,
                borderRadius: BorderRadius.zero,

                // height: 40.h,
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 6.h),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
