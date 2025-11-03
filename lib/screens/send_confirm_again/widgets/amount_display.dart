import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/utils/format/currency.dart';
import 'package:flutter_aigun/utils/format/number.dart';
import 'package:flutter_aigun/utils/image_utils.dart';
import 'package:flutter_aigun/widgets/feature_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AmountDisplay extends StatelessWidget {
  const AmountDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransferCubit, TransferState>(
      builder: (context, state) {
        final amount = double.tryParse(state.amount) ?? 0.0;

        return Column(
          children: [
            Center(
              child: Text(
                S.of(context).common_send,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary(context),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '-',
                      style: TextStyle(
                        fontSize: 30.sp,
                        color: AppColors.textPrimary(context),
                      ),
                    ),
                    TextSpan(
                      text: CurrencyFormatter.abbreviateTokenPrice(amount),
                      style: TextStyle(
                        fontSize: 28.sp,
                        color: AppColors.textPrimary(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: FeatureImage(
                        url: ImageUtils.getImageUrl(
                            state.selectedToken?.tokenAvatar),
                        width: 33.w,
                        height: 33.h,
                        fit: BoxFit.cover),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    state.selectedToken?.symbol ?? '',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
