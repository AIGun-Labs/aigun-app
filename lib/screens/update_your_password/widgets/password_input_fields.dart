import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/forget_password/forgot_password_cubit.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/widgets/input.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordInputFields extends StatelessWidget {
  const PasswordInputFields({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomInput(
          hintText: S.of(context).form_newPassword,
          isPassword: true,
          onChanged: (value) {
            context.read<ForgotPasswordCubit>().updateNewPassword(value);
          },
        ),
        SizedBox(height: 15.h),
        CustomInput(
          hintText: S.of(context).form_confirmPassword,
          isPassword: true,
          onChanged: (value) {
            context.read<ForgotPasswordCubit>().updateConfirmPassword(value);
          },
        ),
      ],
    );
  }
}
