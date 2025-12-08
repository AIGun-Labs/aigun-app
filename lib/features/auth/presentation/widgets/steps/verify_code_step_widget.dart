import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../themes/themes.dart';
import '../../../../../utils/toast.dart';
import '../../../../../widgets/button/neon_button.dart';
import '../../../../../widgets/input/neon_otp_input.dart';
import '../../../domain/constants/auth_error_codes.dart';
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
    final verifyStepCubit = context.read<VerifyStepCubit>();
    final emailStepCubit = context.read<EmailStepCubit>();

    verifyStepCubit.onVerifySuccess = (AuthResultEntity result) {
      context.read<AuthCubit>().onVerifySuccess(result);
    };

    verifyStepCubit.onVerifyError = (String message, int? code) {
      _handleVerifyError(message, code);
    };

    // Setup resend code success callback
    emailStepCubit.onCodeSent = () {
      if (mounted) {
        ToastUtils.showSuccessToast(
          context,
          message: S.of(context).resendCodeSuccess,
        );
      }
    };
  }

  void _handleVerifyError(String message, int? code) {
    if (code == AuthErrorCodes.codeExpired) {
      ToastUtils.showFailureToast(
        context,
        message: S.of(context).verifyCodeExpired,
      );
    } else if (code == AuthErrorCodes.codeInvalid) {
      ToastUtils.showFailureToast(
        context,
        message: S.of(context).verifyCodeFail,
      );
    } else {
      ToastUtils.showFailureToast(context, message: message);
    }
  }

  void _handleVerifyCode(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    context.read<VerifyStepCubit>().verify(authCubit.state.email);
  }

  void _handleResendCode(BuildContext context) {
    // Success toast is shown via onCodeSent callback setup in _setupCallbacks
    context.read<EmailStepCubit>().sendCode();
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
          error: (message, errorCode) {
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
          onBack: () => context.read<AuthCubit>().goToStep(AuthStep.email),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHintMessages(context, authState.email),
              _buildOTPInput(context),
              SizedBox(height: 26.h),
              _buildVerifyButton(context),
              SizedBox(height: 20.h),
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
      onChanged: (value) => context.read<VerifyStepCubit>().codeChanged(value),
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

  Widget _buildErrorMessage(BuildContext context) {
    return BlocSelector<VerifyStepCubit, VerifyStepState, VerifyStepStatus>(
      selector: (state) => state.status,
      builder: (context, status) {
        return status.maybeWhen(
          error: (message, errorCode) {
            if (errorCode == AuthErrorCodes.codeInvalid) {
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
    return CountdownButton(
      onPressed: () => _handleResendCode(context),
    );
  }
}
