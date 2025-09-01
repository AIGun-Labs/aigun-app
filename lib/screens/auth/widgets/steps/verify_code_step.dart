import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_aigun/cubits/auth/auth_cubit.dart";
import "package:flutter_aigun/cubits/auth/auth_state.dart";
import "package:flutter_aigun/cubits/network/network_state.dart";
import "package:flutter_aigun/l10n/l10n.dart";
import "package:flutter_aigun/routing/routes_path.dart";
import "package:flutter_aigun/screens/auth/auth_steps.dart";
import "package:flutter_aigun/screens/auth/widgets/countdown_button.dart";
import "package:flutter_aigun/screens/auth/widgets/login_page_layout.dart";
import "package:flutter_aigun/widgets/button/neon_button.dart";
import "package:flutter_aigun/widgets/input/neon_otp_input.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:fluttertoast/fluttertoast.dart";
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
      context.go(Routes.home);
    }
  }

  Future<void> _handleResendCode(BuildContext context) async {
    await context.read<AuthCubit>().sendVerificationCode(context, () {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          previous.event != current.event && current.event != null,
      listener: (context, state) {
        state.event?.whenOrNull(
          showDialog: (titleKey, messageKey) => Fluttertoast.showToast(
            msg: messageKey,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
          ),
        );

        context.read<AuthCubit>().clearEvent(); // prevent repeated trigger
      },
      child: AuthPageLayout(
        // isLogo: true,
        onBack: () => onNext(AuthStep.email.stepIndex),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HitMessages(email: context.read<AuthCubit>().state.email),
            // SizedBox(height: 5.h),
            _OTPInput(
                onChanged: (value) => _handleChangeOTP(context, value),
                onCompleted: (value) => _handleVerifyCode(context)),
            SizedBox(height: 26.h),
            _VerifyCodeButton(onPressed: () => _handleVerifyCode(context)),
            SizedBox(height: 20.h),
            _VerifyCodeFormErrorMessage(),
            CountdownButton(onPressed: () => _handleResendCode(context)),
          ],
        ),
      ),
    );
  }
}

class _VerifyCodeButton extends StatelessWidget {
  const _VerifyCodeButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AuthCubit, AuthState, NetworkState<void>>(
        selector: (state) => state.verifyCodeStatus,
        builder: (context, status) {
          final isLoading = status.maybeWhen(
            orElse: () => false,
            loading: () => true,
          );

          return NeonCutCornerButton(
              isLoading: isLoading,
              // backgroundColor: Theme.of(context).colorScheme.secondary,
              onPressed: onPressed,
              child: Text(
                S.of(context).authFlow_continueText,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ));
        });
  }
}

class _OTPInput extends StatelessWidget {
  const _OTPInput(
      {super.key, required this.onChanged, required this.onCompleted});

  final Function(String) onChanged;
  final Function(String) onCompleted;

  @override
  Widget build(BuildContext context) {
    return NeonOTPInput(
        codeLength: 6,
        onCompleted: onCompleted, // 验证码输入完成 调用验证码验证
        onChanged: onChanged, // 验证码输入改变 更新验证码值
        inputWidth: 56.w,
        inputHeight: 56.h,
        borderColor: const Color(0xFF29ABE2),
        focusedBorderColor: const Color(0xFF973DFF));
  }
}

class _HitMessages extends StatelessWidget {
  const _HitMessages({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).auth_message_checkYourEmail,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                height: 1.5.h,
              ),
            ),
            Text(
              S.of(context).auth_message_weveSendA6DigitCodeTo,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                height: 1.5.h,
              ),
            ),
            Text(
              email,
              style: TextStyle(
                color: const Color(0xFFF8EF00),
                fontSize: 18.sp,
                height: 1.5.h,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ));
  }
}

class _VerifyCodeFormErrorMessage extends StatelessWidget {
  const _VerifyCodeFormErrorMessage({super.key});

  @override
  Widget build(BuildContext context) {
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
