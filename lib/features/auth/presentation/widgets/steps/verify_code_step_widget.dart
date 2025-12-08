import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../themes/themes.dart';
import '../../../../../utils/toast.dart';
import '../../../../../widgets/button/neon_button.dart';
import '../../../../../widgets/input/neon_otp_input.dart';
import '../../../domain/entities/auth_result_entity.dart';
import '../../cubits/auth/auth_cubit.dart';
import '../../cubits/auth/auth_state.dart';
import '../../cubits/email_step/email_step_cubit.dart';
import '../../cubits/verify_step/verify_step_cubit.dart';
import '../../cubits/verify_step/verify_step_state.dart';
import '../common/auth_page_layout.dart';
import '../common/countdown_button.dart';

/// Verify Code Step Widget - Second step of authentication flow
///
/// Allows user to enter 6-digit verification code sent to email.
class VerifyCodeStepWidget extends StatefulWidget {
  const VerifyCodeStepWidget({super.key});

  @override
  State<VerifyCodeStepWidget> createState() => _VerifyCodeStepWidgetState();
}

class _VerifyCodeStepWidgetState extends State<VerifyCodeStepWidget> {
  @override
  void initState() {
    super.initState();
    // Setup callbacks
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setupCallbacks();
    });
  }

  void _setupCallbacks() {
    final verifyStepCubit = BlocProvider.of<VerifyStepCubit>(context);
    final emailStepCubit = BlocProvider.of<EmailStepCubit>(context);
    final authCubit = BlocProvider.of<AuthCubit>(context);

    verifyStepCubit.onVerifySuccess = (AuthResultEntity result) {
      // 用户已存在
      result.whenOrNull(
        newUserRequired: () {
          ToastUtils.showSuccessToast(
            context,
            message: S.of(context).bizUserNotExist,
          );
        },
      );

      authCubit.onVerifySuccess(result);
    };

    verifyStepCubit.onVerifyError = (VerifyStepFailure failure, int? code) {
      authCubit.handleBusinessException(
        context: context,
        code: code ?? 0,
        message: _getLocalizedVerifyError(failure),
      );
    };

    // 保存 AuthCubit 设置的原始回调（_onCodeSent）
    final prevOnCodeSent = emailStepCubit.onCodeSent;
    // Setup resend code success callback
    emailStepCubit.onCodeSent = () {
      // 先调用原始回调，更新 AuthCubit 的状态（包括 lastCodeSentAt）
      prevOnCodeSent?.call();
      if (mounted) {
        ToastUtils.showSuccessToast(
          context,
          message: S.of(context).resendCodeSuccess,
        );
      }
    };
  }

  String _getLocalizedVerifyError(VerifyStepFailure failure) {
    final l10n = S.of(context);
    return switch (failure) {
      VerifyStepFailure.codeInvalidFormat => l10n.verifyCodeInvalidFormat,
      VerifyStepFailure.codeFail => l10n.verifyCodeFail,
      VerifyStepFailure.codeExpired => l10n.verifyCodeExpired,
      VerifyStepFailure.userNotExist => l10n.bizUserNotExist,
      VerifyStepFailure.userExist => l10n.userExist,
      VerifyStepFailure.unknown => l10n.unknownError,
    };
  }

  void _handleVerifyCode(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    BlocProvider.of<VerifyStepCubit>(context).verify(authCubit.state.email);
  }

  void _handleResendCode(BuildContext context) {
    // Success toast is shown via onCodeSent callback setup in _setupCallbacks
    BlocProvider.of<EmailStepCubit>(context).sendCode();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VerifyStepCubit, VerifyStepState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        state.status.when(
          initial: () {},
          loading: () {},
          success: () {
            // Navigation handled by callback
          },
          failure: (failure, errorCode) {
            // Error handling done in callback
          },
        );
      },
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        return AuthPageLayout(
          onBack: () =>
              BlocProvider.of<AuthCubit>(context).goToStep(AuthStep.email),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHintMessages(context, authState.email),
              _buildOTPInput(context),
              26.verticalSpace,
              _buildVerifyButton(context),
              20.verticalSpace,
              _buildErrorMessage(context),
              _buildResendButton(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHintMessages(BuildContext context, String email) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).auth_message_checkYourEmail,
            style: TextStyle(
              fontFamily: 'Zeroes1',
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
            email,
            style: TextStyle(
              color: AppColors.tertiary,
              fontSize: 18.sp,
              height: 1.5.h,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOTPInput(BuildContext context) {
    return NeonOTPInput(
      codeLength: 6,
      onChanged: (value) =>
          BlocProvider.of<VerifyStepCubit>(context).codeChanged(value),
      onCompleted: (value) => _handleVerifyCode(context),
      inputWidth: 56.w,
      inputHeight: 56.h,
      borderColor: const Color(0xFF29ABE2),
      focusedBorderColor: const Color(0xFF973DFF),
    );
  }

  Widget _buildVerifyButton(BuildContext context) {
    return BlocSelector<VerifyStepCubit, VerifyStepState, bool>(
      selector: (state) => state.isVerifying,
      builder: (context, isVerifying) {
        return NeonCutCornerButton(
          isLoading: isVerifying,
          onPressed: () => _handleVerifyCode(context),
          child: Row(
            children: [
              Text(
                S.of(context).authFlow_continueText,
                style: TextStyle(
                  fontFamily: 'Zeroes1',
                  letterSpacing: 2,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              15.horizontalSpace,
              if (!isVerifying)
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

  Widget _buildErrorMessage(BuildContext context) {
    return BlocSelector<VerifyStepCubit, VerifyStepState, VerifyStepStatus>(
      selector: (state) => state.status,
      builder: (context, status) {
        return status.maybeWhen(
          failure: (failure, errorCode) {
            if (failure == VerifyStepFailure.codeFail) {
              return Text(
                S.of(context).verifyCodeFail,
                style: TextStyle(fontSize: 18.sp, color: Colors.white),
              );
            }
            return const SizedBox.shrink();
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }

  Widget _buildResendButton(BuildContext context) {
    return CountdownButton(onPressed: () => _handleResendCode(context));
  }
}
