import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/l10n.dart';
import '../../../../shared/presentation/extensions/number_extension.dart';
import '../../../../themes/colors.dart';
import 'card_widget.dart';

class InviteeCard extends StatelessWidget {
  final int inviteeCount;
  const InviteeCard({super.key, required this.inviteeCount});

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
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.textSecondary(context),
              ),
            ),
            Text(
              inviteeCount.comma(context),
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
            ),
          ],
        ));
  }
}
