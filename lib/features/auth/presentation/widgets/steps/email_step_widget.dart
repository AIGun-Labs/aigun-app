import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../utils/toast.dart';
import '../../../../../widgets/button/neon_button.dart';
import '../../../../../widgets/input/neon_input.dart';
import '../../cubits/auth/auth_cubit.dart';
import '../../cubits/email_step/email_step_cubit.dart';
import '../../cubits/email_step/email_step_state.dart';
import '../common/auth_page_layout.dart';
import '../common/auth_hint_text.dart';

/// Email Step Widget - First step of authentication flow
///
/// Allows user to enter email and send verification code.
class EmailStepWidget extends StatelessWidget {
  const EmailStepWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmailStepCubit, EmailStepState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        state.status.when(
          initial: () {},
          sending: () {},
          sent: () {
            FocusScope.of(context).unfocus();
            ToastUtils.showSuccessToast(
              context,
              message: S.of(context).sendCodeSuccess,
            );
            // Move to verify step
            context.read<AuthCubit>().onEmailSent(state.email);
          },
          error: (message, errorCode) {
            FocusScope.of(context).unfocus();
            ToastUtils.showFailureToast(context, message: message);
          },
        );
      },
      child: AuthPageLayout(
        overlayOpacity: 0.1,
        isLogo: true,
        onBack: () => context.pop(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _EmailInput(),
            10.verticalSpace,
            const _SendCodeButton(),
            5.verticalSpace,
            const _EmailErrorMessage(),
            10.verticalSpace,
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    return NeonInputField(
      hintText: S.of(context).auth_form_input_email,
      onChanged: (value) {
        context.read<EmailStepCubit>().emailChanged(value);
      },
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._\-]')),
      ],
    );
  }
}

class _SendCodeButton extends StatelessWidget {
  const _SendCodeButton();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<EmailStepCubit, EmailStepState, bool>(
      selector: (state) => state.isSending,
      builder: (context, isSending) {
        return NeonCutCornerButton(
          isLoading: isSending,
          onPressed: () {
            FocusScope.of(context).unfocus();
            context.read<EmailStepCubit>().sendCode();
          },
          child: Row(
            children: [
              Text(
                S.of(context).auth_form_signInSignUp,
                style: TextStyle(
                  fontFamily: 'Zeroes1',
                  letterSpacing: 2,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              15.horizontalSpace,
              if (!isSending)
                SvgPicture.asset(
                  'assets/images/icons/arrow-right-outline.svg',
                  width: 18.w,
                  height: 18.h,
                ),
            ],
          ),
        );
      },
    );
  }
}

class _EmailErrorMessage extends StatelessWidget {
  const _EmailErrorMessage();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<EmailStepCubit, EmailStepState, EmailStepStatus>(
      selector: (state) => state.status,
      builder: (context, status) {
        return status.maybeWhen(
          error: (message, errorCode) {
            // Show validation error hint
            if (message.contains('email') || message.contains('Email')) {
              return AuthHintText(text: S.of(context).pleaseEnterCorrectEmail);
            }
            return const SizedBox.shrink();
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
