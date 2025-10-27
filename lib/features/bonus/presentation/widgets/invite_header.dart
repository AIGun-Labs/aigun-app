import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/l10n.dart';

class InviteHeader extends StatelessWidget {
  const InviteHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12.w,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/invite.png",
          fit: BoxFit.fitWidth,
          width: 47.w,
        ),
        Expanded(
          child: FittedBox(
            alignment: Alignment.centerLeft,
            fit: BoxFit.scaleDown,
            child: Text(S.of(context).inviteDesc,
                style: TextStyle(
                    fontSize: 22.sp,
                    height: 1.2.h,
                    fontWeight: FontWeight.w700)),
          ),
        )
      ],
    );
  }
}
