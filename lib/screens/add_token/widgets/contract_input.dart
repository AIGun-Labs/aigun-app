import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../l10n/l10n.dart';
import '../../../themes/themes.dart';
import '../../../widgets/input.dart';
import '../cubit/add_token_cubit.dart';

class ContractInput extends StatelessWidget {
  const ContractInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).form_enterTokenContract,
          style: TextStyle(fontSize: 16.sp),
        ),
        SizedBox(height: 10.h),
        CustomInput(
          fillColor: AppColors.background(context),
          hintText: 'contract address',
          fontSize: 16.sp,
          isPassword: false,
          height: 118.h,
          isOutline: true,
          borderRadius: BorderRadius.circular(5.r),
          contentPadding: EdgeInsets.all(13.w),
          onChanged: (value) {
            context.read<AddTokenCubit>().updateTokenAddress(value);
          },
          maxLines: 5,
        ),
      ],
    );
  }
}
