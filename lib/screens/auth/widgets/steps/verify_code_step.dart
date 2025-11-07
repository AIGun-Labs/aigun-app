import "package:flutter/material.dart";
import "package:flutter_aigun/cubits/auth/auth_cubit.dart";
import "package:flutter_aigun/cubits/auth/auth_state.dart";
import "package:flutter_aigun/l10n/l10n.dart";
import "package:flutter_aigun/screens/auth/auth_steps.dart";
import "package:flutter_aigun/screens/auth/widgets/countdown_button.dart";
import "package:flutter_aigun/screens/auth/widgets/login_page_layout.dart";
import "package:flutter_aigun/themes/themes.dart";
import "package:flutter_aigun/utils/toast.dart";
import "package:flutter_aigun/widgets/button/neon_button.dart";
import "package:flutter_aigun/widgets/input/neon_otp_input.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:go_router/go_router.dart";

import "../../../../core/router/constants.dart";

class VerifyCodeStep extends StatefulWidget {
  const VerifyCodeStep({super.key, required this.onNext});

  final Function(int) onNext;

  @override
  State<VerifyCodeStep> createState() => _VerifyCodeStepState();
}

class _VerifyCodeStepState extends State<VerifyCodeStep> {
  @override
  void initState() {
    super.initState();
    // 如果是首次进入且还没有倒计时开始时间，则设置一个
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthCubit>().initializeCountdown();
    });
  }

  void _handleChangeOTP(BuildContext context, String value) {
    context.read<AuthCubit>().codeChanged(value);
  }

  void _handleVerifyCode(BuildContext context) {
    context.read<AuthCubit>().verifyCode();
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
            context.goNamed(RouteNames.wallet);
          }, failure: (failure) {
            switch (failure) {
              case VerifyCodeFailure.userNotExist:
                ToastUtils.showFailureToast(context,
                    message: S.of(context).userNotExist);
                widget.onNext(AuthStep.profile.stepIndex);
              case VerifyCodeFailure.userExist:
                ToastUtils.showFailureToast(context,
                    message: S.of(context).userExist);
                context.goNamed(RouteNames.wallet);
              case VerifyCodeFailure.verifyCodeExpired:
                ToastUtils.showFailureToast(context,
                    message: S.of(context).verifyCodeExpired);
              // case VerifyCodeFailure.verifyCodeInvalidFormat:
              //   ToastUtils.showFailureToast(context,
              //       message: S.of(context).verifyCodeInvalidFormat);
              // case VerifyCodeFailure.verifyCodeFail:
              //   ToastUtils.showFailureToast(context,
              //       message: S.of(context).verifyCodeFail);
              default:
              // ToastUtils.showFailureToast(context,
              //     message: S.of(context).unknownError);
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
          onBack: () => widget.onNext(AuthStep.email.stepIndex),
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
          ToastUtils.showFailureToast(context,
              message: S.of(context).sendCodeFail);
        }, success: () {
          ToastUtils.showSuccessToast(context,
              message: S.of(context).resendCodeSuccess);
        });
      },
      child: CountdownButton(onPressed: () => _handleResendCode(context)),
    );
  }

  Widget _buildButton(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      final isVerifyingCode = state.verifyCodeState.maybeMap(
        orElse: () => false,
        loading: (_) => true,
      );

      return NeonCutCornerButton(
          isLoading: isVerifyingCode,
          // backgroundColor: Theme.of(context).colorScheme.secondary,
          onPressed: () => _handleVerifyCode(context),
          child: Row(
            children: [
              Text(
                S.of(context).authFlow_continueText,
                style: TextStyle(
                  fontFamily: "Zeroes1",
                  letterSpacing: 2,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              15.horizontalSpace,
              if (!isVerifyingCode)
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
                fontFamily: "Zeroes1",
                letterSpacing: 1.2,
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
    return BlocSelector<AuthCubit, AuthState, VerifyCodeStatus>(
      selector: (state) => state.verifyCodeState,
      builder: (context, verifyCodeState) {
        return verifyCodeState.maybeMap(
            failure: (value) {
              if (value.failure == VerifyCodeFailure.verifyCodeFail) {
                return Text(
                  S.of(context).verifyCodeFail,
                  style: TextStyle(fontSize: 18.sp, color: Colors.white),
                );
              } else if (value.failure ==
                  VerifyCodeFailure.verifyCodeInvalidFormat) {
                return Text(
                  S.of(context).verifyCodeInvalidFormat,
                  style: TextStyle(fontSize: 18.sp, color: Colors.white),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
            orElse: () => const SizedBox.shrink());
      },
    );
  }
}
