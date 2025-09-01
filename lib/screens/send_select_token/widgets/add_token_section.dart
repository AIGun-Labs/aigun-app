import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/themes/button_theme.dart';
import 'package:flutter_aigun/widgets/button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AddTokenSection extends StatelessWidget {
  const AddTokenSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TokenCard(
        //   onTap: () {},
        // ),
        SizedBox(height: 20.h),
        Text(
          S.of(context).tokens_couldNotFindToken,
          style: TextStyle(
            fontSize: 16.sp,
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          S.of(context).tokens_tapToAddToken,
          style: TextStyle(
            fontSize: 16.sp,
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
        ),
        SizedBox(height: 10.h),
        _buildAddTokenButton(context),
      ],
    );
  }

  Widget _buildAddTokenButton(BuildContext context) {
    return CustomButton(
      onPressed: () {
        context.push(Routes.addToken);
      },
      type: ButtonType.outlined,
      width: 126.w,
      height: 40.h,
      child: Text(
        S.of(context).tokens_addToken,
        style: TextStyle(
          fontSize: 14.sp,
        ),
      ),
    );
  }
}
