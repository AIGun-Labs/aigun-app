import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/constants.dart';
import '../../../../l10n/l10n.dart';
import '../../../../shared/presentation/extensions/number_extension.dart';
import '../../../../themes/colors.dart';
import 'card_widget.dart';

class GetFundsCard extends StatelessWidget {
  const GetFundsCard({super.key, required this.unclaimedDollarValue});
  final double unclaimedDollarValue;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(RouteNames.claimFunds);
      },
      child: CardWidget(
        paddingValue: 14,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).unclaimedFunds,
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.textSecondary(context),
              ),
            ),
            Row(
              children: [
                Text(
                  '\$',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Expanded(
                  child: Text(
                    unclaimedDollarValue.comma(context, fractionDigits: 1),
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                  size: 24.w,
                  color: AppColors.quaternary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
