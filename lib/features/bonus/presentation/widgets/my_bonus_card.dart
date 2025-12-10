import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../l10n/l10n.dart';
import '../../../../shared/presentation/extensions/number_extension.dart';
import '../../../../themes/colors.dart';
import '../../../../widgets/image.dart';
import 'card_widget.dart';

class MyBonusCard extends StatelessWidget {
  final int claimedGold;
  final double claimedDollarValue;

  const MyBonusCard({
    super.key,
    required this.claimedGold,
    required this.claimedDollarValue,
  });

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      paddingValue: 14,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).myBonus,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.textSecondary(context),
            ),
          ),
          4.verticalSpace,
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                CachedImage(
                  // const $AssetsImagesGen().gold.path,
                  imageUrl: Assets.images.gold.path,
                  width: 30.w,
                ),
                2.horizontalSpace,
                Text(
                  claimedGold.comma(context),
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                6.horizontalSpace,
                Text(
                  'GOLD',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textSecondary(context),
                  ),
                ),
                20.horizontalSpace,
                Text(
                  '\$${claimedDollarValue.comma(context, fractionDigits: 1)}',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
