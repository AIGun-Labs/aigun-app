import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/forget_password/forgot_password_cubit.dart';
import 'package:flutter_aigun/cubits/sign_up_back/sign_up_cubit.dart';
import 'package:flutter_aigun/enums/index.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeInput extends StatelessWidget {
  const PinCodeInput({super.key});

  @override
  Widget build(BuildContext context) {
    final String? type = GoRouterState.of(context).extra as String?;
    final bool isRegister = type == VerificationType.register.type;

    final SignUpCubit signUpCubit = context.watch<SignUpCubit>();
    final ForgotPasswordCubit forgotPasswordCubit =
        context.watch<ForgotPasswordCubit>();

    final bool isEnabled = isRegister
        ? !signUpCubit.state.isLoading
        : !forgotPasswordCubit.state.isLoading;

    return PinCodeTextField(
      appContext: context,
      length: 6,
      onChanged: (String value) {
        if (isRegister) {
          signUpCubit.updateCode(value);
        } else {
          forgotPasswordCubit.updateCode(value);
        }

        if (value.length == 6) {
          if (isRegister) {
            context.read<SignUpCubit>().signUp();
          } else {
            context.push(Routes.updateYourPassword);
          }
        }
      },
      textStyle: const TextStyle(color: Colors.black),
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(10.r),
        fieldHeight: 50.h,
        fieldWidth: 50.w,
        activeFillColor: Colors.white,
        inactiveFillColor: Colors.white,
        selectedFillColor: Colors.white,
        activeColor: Colors.white,
        inactiveColor: Colors.white,
        selectedColor: const Color(0xFFFEFA83),
        errorBorderColor: Colors.red,
      ),
      enabled: isEnabled,
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
    );
  }
}
