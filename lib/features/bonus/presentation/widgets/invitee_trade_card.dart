import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/l10n.dart';
import 'card_widget.dart';

class InviteeTradeCard extends StatelessWidget {
  const InviteeTradeCard({super.key});

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
              style: TextStyle(fontSize: 12.sp),
            ),
            Text(
              '\$10,000.00',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
            ),
          ],
        ));
  }
}
