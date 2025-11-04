import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClaimFundsHeader extends StatelessWidget {
  const ClaimFundsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
      sliver: SliverToBoxAdapter(
        child: Text(
          S.of(context).claimFundsDesc,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.textPrimary(context),
          ),
        ),
      ),
    );
  }
}
