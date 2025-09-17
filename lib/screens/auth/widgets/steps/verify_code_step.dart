import "package:flutter/material.dart";
import "package:flutter_aigun/config/nav.dart";
import "package:flutter_aigun/themes/themes.dart";
import "package:flutter_aigun/utils/toast.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_aigun/cubits/auth/auth_cubit.dart";
import "package:flutter_aigun/cubits/auth/auth_state.dart";
import "package:flutter_aigun/l10n/l10n.dart";
import "package:flutter_aigun/routing/routes_path.dart";
import "package:flutter_aigun/screens/auth/auth_steps.dart";
import "package:flutter_aigun/screens/auth/widgets/countdown_button.dart";
import "package:flutter_aigun/screens/auth/widgets/login_page_layout.dart";
import "package:flutter_aigun/widgets/button/neon_button.dart";
import "package:flutter_aigun/widgets/input/neon_otp_input.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:go_router/go_router.dart";

class VerifyCodeStep extends StatelessWidget {
  const VerifyCodeStep({super.key, required this.onNext});

  final Function(int) onNext;

  void _handleChangeOTP(BuildContext context, String value) {
    context.read<AuthCubit>().codeChanged(value);
  }

  void _handleVerifyCode(BuildContext context) {
    context.read<AuthCubit>().verifyCode(
        () => onNext(AuthStep.profile.stepIndex),
        () => _handleSignInSuccess(context));
  }

  void _handleSignInSuccess(BuildContext context) {
    // TODO: 处理登录成功逻辑
    // 这里需要根据实际的 LoginCubit 方法来实现

    // 检查 widget 是否仍然挂载，避免在 dispose 后访问 context
    if (context.mounted) {
      context.push(Routes.home);
    }
  }

  Future<void> _handleResendCode(BuildContext context) async {
    await context.read<AuthCubit>().sendVerificationCode(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
        listenWhen: (previous, current) =>
            previous.verifyCodeState != current.verifyCodeState,
        listener: (context, state) {
          state.verifyCodeState.whenOrNull(success: () {
            context.go(Routes.home, extra: NavIndex.wallet);
          }, failure: (failure) {
            switch (failure) {
              case VerifyCodeFailure.userNotExist:
                ToastUtils.showFailureToast(context, message: "用户不存在，请先注册");
                onNext(AuthStep.profile.stepIndex);
              case VerifyCodeFailure.userExist:
                ToastUtils.showFailureToast(context, message: "用户已存在");
                context.push(Routes.home, extra: NavIndex.wallet);
              case VerifyCodeFailure.verifyCodeExpired:
                ToastUtils.showFailureToast(context, message: "验证码过期");
              case VerifyCodeFailure.verifyCodeFail:
                ToastUtils.showFailureToast(context, message: "验证码错误");
              default:
                ToastUtils.showFailureToast(context, message: "未知错误");
            }
          });
        },
        child: _buildVerifyCodeForm(context));
  }

  Widget _buildVerifyCodeForm(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return AuthPageLayout(
          // isLogo: true,
          onBack: () => onNext(AuthStep.email.stepIndex),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // _HitMessages(email: context.read<AuthCubit>().state.email),
              _buildHitMessages(context),
              // SizedBox(height: 5.h),
              _buildOTPInput(context),
              SizedBox(height: 26.h),
              _buildButton(context),
              SizedBox(height: 20.h),
              _buildVerifyCodeFormErrorMessage(context),
              _buildResendCodeButton(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildResendCodeButton(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          previous.sendCodeState != current.sendCodeState,
      listener: (context, state) {
        state.sendCodeState.whenOrNull(failure: (failure) {
          ToastUtils.showFailureToast(context, message: "发送验证码失败");
        }, success: () {
          ToastUtils.showSuccessToast(context, message: "重发验证码成功，请检查");
        });
      },
      child: CountdownButton(onPressed: () => _handleResendCode(context)),
    );
  }

  Widget _buildButton(BuildContext context) {
    return BlocSelector<AuthCubit, AuthState, VerifyCodeStatus>(
        selector: (state) => state.verifyCodeState,
        builder: (context, state) {
          return NeonCutCornerButton(
              isLoading: state.isVerifyingCode,
              // backgroundColor: Theme.of(context).colorScheme.secondary,
              onPressed: () => _handleVerifyCode(context),
              child: Row(
                children: [
                  Text(
                    S.of(context).authFlow_continueText,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  if (!state.isVerifyingCode)
                    SvgPicture.asset(
                      "assets/images/icons/arrow-right-outline.svg",
                      width: 18.w,
                      height: 18.h,
                    )
                ],
              ));
        });
  }

  Widget _buildOTPInput(BuildContext context) {
    return NeonOTPInput(
        codeLength: 6,
        onChanged: (value) => _handleChangeOTP(context, value),
        onCompleted: (value) => _handleVerifyCode(context),
        inputWidth: 56.w,
        inputHeight: 56.h,
        borderColor: const Color(0xFF29ABE2),
        focusedBorderColor: const Color(0xFF973DFF));
  }

  Widget _buildHitMessages(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).auth_message_checkYourEmail,
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                height: 1.5.h,
              ),
            ),
            Text(
              S.of(context).auth_message_weveSendA6DigitCodeTo,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 18.sp,
                height: 1.5.h,
              ),
            ),
            Text(
              context.read<AuthCubit>().state.email,
              style: TextStyle(
                color: AppColors.tertiary,
                fontSize: 18.sp,
                height: 1.5.h,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ));
  }

  _buildVerifyCodeFormErrorMessage(BuildContext context) {
    return BlocSelector<AuthCubit, AuthState, bool>(
      selector: (state) => state.isCodeValid,
      builder: (context, isCodeValid) {
        if (!isCodeValid) {
          return Text(
            S.of(context).validation_verificationCodeInvalid,
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.white,
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
