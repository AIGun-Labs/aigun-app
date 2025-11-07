import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_aigun/cubits/auth/auth_cubit.dart";
import "package:flutter_aigun/cubits/auth/auth_state.dart";
import "package:flutter_aigun/l10n/l10n.dart";
import "package:flutter_aigun/screens/auth/auth_steps.dart";
import "package:flutter_aigun/screens/auth/widgets/hint_text.dart";
import "package:flutter_aigun/screens/auth/widgets/login_page_layout.dart";
import "package:flutter_aigun/utils/toast.dart";
import "package:flutter_aigun/widgets/button/neon_button.dart";
import "package:flutter_aigun/widgets/input/neon_input.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:go_router/go_router.dart";

class EmailStep extends StatelessWidget {
  const EmailStep({super.key, required this.onNext});

  final Function(int) onNext;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          // previous.event != current.event && current.event != null,
          previous.sendCodeState != current.sendCodeState,
      listener: (context, state) {
        state.sendCodeState.whenOrNull(
          success: () {
            // 关闭输入法
            ToastUtils.showSuccessToast(context,
                message: S.of(context).sendCodeSuccess);
            onNext(AuthStep.verifyCode.stepIndex);
          },
          failure: (failure) {
            // 关闭输入法
            switch (failure) {
              // case SendCodeFailure.emailInvalid:
              //   ToastUtils.showFailureToast(context,
              //       message: S.of(context).emailFormatError);
              case SendCodeFailure.sendCodeFail:
                ToastUtils.showFailureToast(context,
                    message: S.of(context).sendCodeFail);
              case SendCodeFailure.sendCodeMany:
                ToastUtils.showFailureToast(context,
                    message: S.of(context).sendCodeMany);
              default:
              // ToastUtils.showFailureToast(context,
              //     message: S.of(context).unknownErrorSendCode);
            }
          },
        );
      },
      child: AuthPageLayout(
        overlayOpacity: 0.1,
        isLogo: true,
        onBack: () {
          context.pop();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _InputEmail(),
            10.verticalSpace,
            _SendCodeButton(onNext: onNext),
            5.verticalSpace,
            const _EmailFormErrorMessage(),
            10.verticalSpace,
          ],
        ),
      ),
    );
  }
}

class _SendCodeButton extends StatelessWidget {
  const _SendCodeButton({required this.onNext});

  final Function(int) onNext;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AuthCubit, AuthState, SendCodeStatus>(
      selector: (state) => state.sendCodeState,
      builder: (context, status) {
        return NeonCutCornerButton(
          isLoading: status.isSendingCode,
          // backgroundColor: Theme.of(context).colorScheme.secondary,
          onPressed: () {
            FocusScope.of(context).unfocus();
            context.read<AuthCubit>().sendVerificationCode(context);
          },
          child: Row(
            children: [
              Text(
                S.of(context).auth_form_signInSignUp,
                style: TextStyle(
                  fontFamily: "Zeroes1",
                  letterSpacing: 2,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              15.horizontalSpace,
              if (!status.isSendingCode)
                SvgPicture.asset(
                  "assets/images/icons/arrow-right-outline.svg",
                  width: 18.w,
                  height: 18.h,
                )
            ],
          ),
        );
      },
    );
  }
}

class _InputEmail extends StatelessWidget {
  const _InputEmail();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NeonInputField(
              hintText: S.of(context).auth_form_input_email,
              onChanged: (value) {
                context.read<AuthCubit>().emailChanged(value);
              },
              // 你可以自定义一个函数来返回你需要的inputFormatters列表，例如只允许输入邮箱相关字符
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._\-]')),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _EmailFormErrorMessage extends StatelessWidget {
  const _EmailFormErrorMessage();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AuthCubit, AuthState, SendCodeStatus>(
      selector: (state) => state.sendCodeState,
      builder: (context, state) {
        return state.maybeWhen(
          failure: (failure) {
            if (failure == SendCodeFailure.emailInvalid) {
              return AuthHintText(text: S.of(context).pleaseEnterCorrectEmail);
            } else {
              return const SizedBox.shrink();
            }
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
