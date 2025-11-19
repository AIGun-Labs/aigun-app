import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/l10n.dart';
import '../../../../shared/presentation/extensions/number_extension.dart';
import '../../../../themes/colors.dart';
import 'card_widget.dart';

class InviteeTradeCard extends StatelessWidget {
  final double inviteTotalTradingVolumeValue;
  const InviteeTradeCard(
      {super.key, required this.inviteTotalTradingVolumeValue});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
        paddingValue: 14,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).inviteeTrade,
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.textSecondary(context),
              ),
            ),
            Text(
              '\$${inviteTotalTradingVolumeValue.comma(context, fractionDigits: 1)}',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
            ),
          ],
        ));
  }
}
