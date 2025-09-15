import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_aigun/utils/toast.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_aigun/cubits/auth/auth_cubit.dart";
import "package:flutter_aigun/cubits/auth/auth_state.dart";
import "package:flutter_aigun/l10n/l10n.dart";
import "package:flutter_aigun/screens/auth/auth_steps.dart";
import "package:flutter_aigun/screens/auth/widgets/hint_text.dart";
import "package:flutter_aigun/screens/auth/widgets/login_page_layout.dart";
import "package:flutter_aigun/widgets/button/neon_button.dart";
import "package:flutter_aigun/widgets/input/neon_Input.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:go_router/go_router.dart";

class EmailStep extends StatelessWidget {
  const EmailStep({super.key, required this.onNext});

  final Function(int) onNext;

  static const double _spacingSmall = 10.0;
  static const double _spacingMedium = 20.0;
  static const double _fontSize = 18.0;

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
            ToastUtils.showSuccessToast(context, message: "发送验证码成功");
            onNext(AuthStep.verifyCode.stepIndex);
          },
          failure: (failure) {
            // 关闭输入法
            switch (failure) {
              case SendCodeFailure.emailInvalid:
                ToastUtils.showFailureToast(context, message: "邮箱格式错误，发送验证码失败");
              case SendCodeFailure.sendCodeFail:
                ToastUtils.showFailureToast(context, message: "发送验证码失败");
              case SendCodeFailure.sendCodeMany:
                ToastUtils.showFailureToast(context, message: "发送验证码过于频繁");
              default:
                ToastUtils.showFailureToast(context, message: "未知错误，发送验证码失败");
            }
          },
        );
      },
      child: AuthPageLayout(
        isLogo: true,
        onBack: () {
          context.pop();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _InputEmail(),
            SizedBox(height: _spacingSmall.h),
            _SendCodeButton(onNext: onNext),
            SizedBox(height: _spacingMedium.h),
            const _EmailFormErrorMessage(),
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
                  fontSize: EmailStep._fontSize.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10.w),
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
    return BlocSelector<AuthCubit, AuthState, bool>(
      selector: (state) => state.isEmailValid,
      builder: (context, isEmailValid) {
        if (!isEmailValid) {
          return AuthHintText(text: S.of(context).validation_emailInvalid);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
