import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/screens/check_your_email/cubit/verification_cubit.dart';
import 'package:flutter_aigun/screens/check_your_email/cubit/verification_state.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/cubits/sign_up_back/sign_up_cubit.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ResendCodeButton extends StatelessWidget {
  const ResendCodeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpCubit = context.read<SignUpCubit>();
    final email = signUpCubit.state.email;
    final type = GoRouterState.of(context).extra as String? ?? '';

    return BlocBuilder<VerificationCubit, VerificationState>(
      buildWhen: (previous, current) =>
          previous.countdown != current.countdown ||
          previous.isResendLoading != current.isResendLoading,
      builder: (context, state) {
        final canResend = !state.isResendLoading && state.countdown == 0;
        final countdownText = state.countdown > 0
            ? '${S.of(context).authFlow_resendCode} (${state.countdown})'
            : S.of(context).authFlow_resendCode;

        return TextButton(
          onPressed: canResend
              ? () => context.read<VerificationCubit>().sendCode(email, type)
              : null,
          child: Text(
            countdownText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 19.sp,
              color: canResend ? Colors.white : Colors.grey,
            ),
          ),
        );
      },
    );
  }
}
