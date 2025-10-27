import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/l10n.dart';
import 'card_widget.dart';

class InviteeCard extends StatelessWidget {
  const InviteeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
        paddingValue: 14,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).invitee,
              style: TextStyle(fontSize: 12.sp, height: 1.2.h),
            ),
            Text(
              '10',
              style: TextStyle(
                  fontSize: 18.sp, height: 1.2.h, fontWeight: FontWeight.w700),
            ),
          ],
        ));
  }
}
