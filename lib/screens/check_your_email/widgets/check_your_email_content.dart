import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/enums/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/screens/check_your_email/widgets/continue_button.dart';
import 'package:flutter_aigun/widgets/loading_indicator/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'pin_code_input.dart';
import 'resend_code_button.dart';

class CheckYourEmailContent extends StatelessWidget {
  const CheckYourEmailContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final type = GoRouterState.of(context).extra as String?;
    final email = type == VerificationType.register.type
        ? context.watch<SignUpCubit>().state.email
        : context.watch<ForgotPasswordCubit>().state.email;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).auth_form_input_email,
          style: TextStyle(
            fontSize: 24.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          S.of(context).auth_success_sendCode,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          email,
          style: TextStyle(
            fontSize: 18.sp,
            color: const Color(0xFFFEFA83),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          S.of(context).form_enter6DigitCode,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 15.h),
        const PinCodeInput(),
        SizedBox(height: 5.h),
        Center(
          child: BlocBuilder<SignUpCubit, SignUpState>(
            builder: (context, state) {
              return state.isLoading
                  ? const LoadingIndicator()
                  : const SizedBox.shrink();
            },
          ),
        ),

        const ContinueButton(),

        // SizedBox(height: 15.h),
        const Center(child: ResendCodeButton()),
      ],
    );
  }
}
