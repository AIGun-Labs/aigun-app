import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/l10n.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../themes/colors.dart';
import '../widgets/claim_funds_card.dart';

class ClaimFundsScreen extends StatelessWidget {
  const ClaimFundsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface(context),
      appBar: SimpleAppBar(title: S.of(context).claimFunds),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).claimFundsDesc,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textPrimary(context),
              ),
            ),
            20.verticalSpace,
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20.h,
                crossAxisSpacing: 14.w,
                childAspectRatio: 0.96,
              ),
              itemCount: 10,
              itemBuilder: (context, index) => const ClaimFundsCard(),
            ),
          ],
        ),
      ),
    );
  }
}
