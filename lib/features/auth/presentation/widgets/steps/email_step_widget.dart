import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/business_code_handler.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../utils/format/input_formatters.dart';
import '../../../../../utils/toast.dart';
import '../../../../../widgets/button/neon_button.dart';
import '../../../../../widgets/input/neon_input.dart';
import '../../cubits/auth/auth_cubit.dart';
import '../../cubits/email_step/email_step_cubit.dart';
import '../../cubits/email_step/email_step_state.dart';
import '../common/auth_hint_text.dart';
import '../common/auth_page_layout.dart';

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
        state.status.whenOrNull(
          sent: () {
            FocusScope.of(context).unfocus();
            ToastUtils.showSuccessToast(
              context,
              message: S.of(context).sendCodeSuccess,
            );
            // Move to verify step
            BlocProvider.of<AuthCubit>(context).onEmailSent(state.email);
          },
          failure: (failure, errorCode) {
            FocusScope.of(context).unfocus();
            return switch (failure) {
              EmailStepFailure.emailInvalid => null,
              _ => ToastUtils.showFailureToast(
                context,
                message: BusinessCodeHandler.getErrorMessageFromBusinessCode(
                  context,
                  errorCode ?? 0,
                ),
              ),
            };
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

class _EmailInput extends StatefulWidget {
  const _EmailInput();

  @override
  State<_EmailInput> createState() => _EmailInputState();
}

class _EmailInputState extends State<_EmailInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NeonInputField(
      controller: _controller,
      hintText: S.of(context).auth_form_input_email,
      onChanged: (value) {
        BlocProvider.of<AuthCubit>(context).emailChanged(value);
      },
      inputFormatters: InputFormatters.emailInputFormatters(),
    );
  }
}

class _SendCodeButton extends StatelessWidget {
  const _SendCodeButton();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<EmailStepCubit, EmailStepState, bool>(
      selector: (state) =>
          state.status.maybeWhen(sending: () => true, orElse: () => false),
      builder: (context, isSending) {
        return NeonCutCornerButton(
          isLoading: isSending,
          onPressed: () {
            FocusScope.of(context).unfocus();
            BlocProvider.of<EmailStepCubit>(context).sendCode();
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
                  // 'assets/images/icons/arrow-right-outline.svg',
                  Assets.images.icons.arrowRightOutline,
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
          failure: (failure, errorCode) {
            // Show validation error hint for email invalid
            if (failure == EmailStepFailure.emailInvalid) {
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
