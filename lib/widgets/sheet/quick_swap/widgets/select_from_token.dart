import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../cubits/quick_trade/quick_trade_state.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../l10n/l10n.dart';
import '../../../../themes/colors.dart';

class SelectFromTokenButton extends StatelessWidget {
  const SelectFromTokenButton({
    super.key,
    required this.mode,
    required this.onTap,
  });

  final QuickTradeMode mode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (QuickTradeMode.buy != mode) {
      return const SizedBox.shrink();
    } else {
      return GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Text(
              S.of(context).buyWithOtherToken,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textSecondary(context),
              ),
            ),
            4.horizontalSpace,

            SvgPicture.asset(
              Assets.images.icons.walletTradeAction,
              width: 16.w,
              height: 16.w,
              colorFilter: ColorFilter.mode(
                AppColors.textSecondary(context),
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      );
    }
  }
}
