import "package:flutter/material.dart";
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
import "package:fluttertoast/fluttertoast.dart";

class ProfileStep extends StatelessWidget {
  const ProfileStep({super.key, required this.onNext});

  final Function(int) onNext;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        state.event?.whenOrNull(
          userExists: () {
            onNext(AuthStep.verifyCode.stepIndex);
            context.read<AuthCubit>().clearEvent();
          },
          showDialog: (titleKey, messageKey) => Fluttertoast.showToast(
            msg: messageKey,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
          ),
        );

        return AuthPageLayout(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NeonInputField(
                hintText: S.of(context).form_inputNickname,
                onChanged: (value) {
                  context.read<AuthCubit>().nicknameChanged(value);
                },
                maxLength: 20,
              ),
              SizedBox(height: 10.h),
              NeonInputField(
                hintText: S.of(context).form_inputInviteCode,
                onChanged: (value) {
                  context.read<AuthCubit>().inviteCodeChanged(value);
                },
                maxLength: 6,
              ),
              SizedBox(height: 10.h),
              // Wallet Password InputField
              NeonInputField(
                hintText: S.of(context).from_walletPassword,
                onChanged: (value) {
                  context.read<AuthCubit>().updatePaymentPin(value);
                },
                maxLength: 6,
                obscureText: true,
              ),
              SizedBox(height: 10.h),
              NeonCutCornerButton(
                  isLoading: state.isLoading,
                  // backgroundColor: Theme.of(context).colorScheme.secondary,
                  onPressed: () => context.read<AuthCubit>().register(
                      () => onNext(AuthStep.success.stepIndex),
                      () => onNext(AuthStep.email.stepIndex)),
                  child: Text(
                    S.of(context).authFlow_continueText,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              SizedBox(height: 20.h),
              // invite code instruction
              AuthHintText(text: S.of(context).form_enterNicknameInstruction),
              SizedBox(height: 10.h),
              _ProfileFormErrorMessage(),
            ],
          ),
        );
      },
    );
  }
}

class _ProfileFormErrorMessage extends StatelessWidget {
  const _ProfileFormErrorMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final isNicknameValid = state.isNicknameValid;
        final isInviteCodeValid = state.isInviteCodeValid;
        final isPaymentPinValid = state.isPaymentPinValid;

        if (!isNicknameValid) {
          return AuthHintText(text: S.of(context).validation_nicknameEmpty);
        }
        if (!isInviteCodeValid) {
          return AuthHintText(text: S.of(context).validation_inviteCodeInvalid);
        }

        if (!isPaymentPinValid) {
          return AuthHintText(text: S.of(context).validation_paymentPinInvalid);
        }

        return const SizedBox.shrink();
      },
    );
  }
}
