import "package:flutter/material.dart";
import "package:flutter_aigun/config/nav.dart";
import "package:flutter_aigun/routing/routes_path.dart";
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
import "package:go_router/go_router.dart";

class ProfileStep extends StatelessWidget {
  const ProfileStep({super.key, required this.onNext});

  final Function(int) onNext;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
        listenWhen: (previous, current) =>
            previous.registerState != current.registerState,
        listener: (context, state) {
          state.registerState.whenOrNull(success: () {
            // 如果邀请码不为空，则跳转到成功页面
            if (state.inviteCode.isNotEmpty) {
              onNext(AuthStep.success.stepIndex);
            } else {
              // 如果邀请码为空，则跳转到钱包页面
              context.go(Routes.home, extra: NavIndex.wallet);
            }
            ToastUtils.showSuccessToast(context, message: "注册成功");
          }, failure: (failure) {
            switch (failure) {
              case RegisterFailure.userExist:
                ToastUtils.showFailureToast(context, message: "用户已存在");
              case RegisterFailure.nicknameInvalid:
                ToastUtils.showFailureToast(context, message: "昵称格式错误");
              case RegisterFailure.inviteCodeInvalid:
                ToastUtils.showFailureToast(context, message: "邀请码格式错误");
              case RegisterFailure.paymentPinInvalid:
                ToastUtils.showFailureToast(context, message: "支付密码格式错误");
              case RegisterFailure.createWalletFail:
                ToastUtils.showFailureToast(context, message: "创建钱包失败");
              case RegisterFailure.walletUserExist:
                ToastUtils.showFailureToast(context, message: "钱包用户已存在");
              case RegisterFailure.walletPinInvalid:
                ToastUtils.showFailureToast(context, message: "钱包密码格式错误");
              default:
                ToastUtils.showFailureToast(context, message: "未知错误");
            }
          });
        },
        child: _buildProfileStep(context));
  }

  Widget _buildProfileStep(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return AuthPageLayout(
          onBack: () => onNext(AuthStep.verifyCode.stepIndex),
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

              SizedBox(height: 10.h),
              NeonCutCornerButton(
                  isLoading: state.registerState.isRegistering,
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
              const _ProfileFormErrorMessage(),
            ],
          ),
        );
      },
    );
  }
}

class _ProfileFormErrorMessage extends StatelessWidget {
  const _ProfileFormErrorMessage();

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
