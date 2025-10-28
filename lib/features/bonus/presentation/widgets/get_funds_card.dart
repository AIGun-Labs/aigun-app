import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../l10n/l10n.dart';
import '../../../../themes/colors.dart';
import 'card_widget.dart';

class GetFundsCard extends StatelessWidget {
  const GetFundsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
        paddingValue: 14,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).unclaimedFunds,
              style: TextStyle(fontSize: 12.sp),
            ),
            Row(
              children: [
                Text(
                  '\$',
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
                ),
                Expanded(
                    child: Text(
                  NumberFormat('#,###').format(13231),
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
                )),
                Icon(Icons.arrow_forward,
                    size: 24.w, color: AppColors.quaternary)
              ],
            )
          ],
        ));
  }
}
