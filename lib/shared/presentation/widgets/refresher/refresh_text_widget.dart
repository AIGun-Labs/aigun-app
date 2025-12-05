import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/l10n.dart';
import '../../../../themes/colors.dart';

class RefreshTextWidget extends StatelessWidget {
  const RefreshTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(S.of(context).app_title,
        style: TextStyle(
            fontSize: 12.sp, color: AppColors.textQuaternary(context)));
  }
}
