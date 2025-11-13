import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_aigun/config/url.dart";
import "package:flutter_aigun/cubits/auth/auth_cubit.dart";
import "package:flutter_aigun/cubits/auth/auth_state.dart";
import "package:flutter_aigun/l10n/l10n.dart";
import "package:flutter_aigun/screens/auth/auth_steps.dart";
import "package:flutter_aigun/screens/auth/widgets/hint_text.dart";
import "package:flutter_aigun/screens/auth/widgets/login_page_layout.dart";
import "package:flutter_aigun/themes/themes.dart";
import "package:flutter_aigun/utils/format/input_formatters.dart";
import "package:flutter_aigun/utils/toast.dart";
import "package:flutter_aigun/widgets/button/neon_button.dart";
import "package:flutter_aigun/widgets/input/neon_input.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:go_router/go_router.dart";

import "../../../../core/router/constants.dart";

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
              context.goNamed(RouteNames.wallet);
            }
            ToastUtils.showSuccessToast(context,
                message: S.of(context).registerSuccess);
          }, failure: (failure) {
            switch (failure) {
              case RegisterFailure.verifyCodeExpired:
                // 验证码过期，跳转到邮箱输入步骤
                ToastUtils.showFailureToast(context,
                    message: S.of(context).verifyCodeExpired);
                Future.delayed(const Duration(seconds: 2), () {
                  onNext(AuthStep.email.stepIndex);
                });
              case RegisterFailure.userExist:
                ToastUtils.showFailureToast(context,
                    message: S.of(context).userExist);
              case RegisterFailure.nicknameInvalid:
                ToastUtils.showFailureToast(context,
                    message: S.of(context).nicknameInvalid);
              case RegisterFailure.inviteCodeInvalid:
                ToastUtils.showFailureToast(context,
                    message: S.of(context).inviteCodeInvalid);
              case RegisterFailure.paymentPinInvalid:
                ToastUtils.showFailureToast(context,
                    message: S.of(context).paymentPinInvalid);
              case RegisterFailure.createWalletFail:
                ToastUtils.showFailureToast(context,
                    message: S.of(context).createWalletFail);
              case RegisterFailure.walletUserExist:
                ToastUtils.showFailureToast(context,
                    message: S.of(context).walletUserExist);
              case RegisterFailure.walletPinInvalid:
                ToastUtils.showFailureToast(context,
                    message: S.of(context).walletPinInvalid);
              case RegisterFailure.agreementNotConfirmed:
                ToastUtils.showFailureToast(context,
                    message:
                        S.of(context).pleaseConfirmAgreementAndPrivacyPolicy);
              default:
                ToastUtils.showFailureToast(context,
                    message: S.of(context).unknownError);
            }
          });
        },
        child: _buildProfileStep(context));
  }

  Widget _buildProfileStep(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final isRegistering = state.registerState
            .maybeWhen(loading: () => true, orElse: () => false);
        return AuthPageLayout(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NeonInputField(
                hintText: S.of(context).form_inputNickname,
                inputFormatters: InputFormatters.nicknameInputFormatters(),
                onChanged: (value) {
                  context.read<AuthCubit>().nicknameChanged(value);
                },
                maxLength: 20,
              ),
              // SizedBox(height: 10.h),
              10.verticalSpace,
              NeonInputField(
                hintText: S.of(context).form_inputInviteCode,
                onChanged: (value) {
                  context.read<AuthCubit>().inviteCodeChanged(value);
                },
                maxLength: 6,
              ),
              10.verticalSpace,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: state.isAgreementNotConfirmed,
                    fillColor: WidgetStateProperty.all(AppColors.primary),
                    visualDensity: VisualDensity.compact,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onChanged: (value) {
                      context
                          .read<AuthCubit>()
                          .changeAgreementNotConfirmed(value);
                    },
                  ),
                  4.horizontalSpace,
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        context.read<AuthCubit>().changeAgreementNotConfirmed(
                            !state.isAgreementNotConfirmed);
                      },
                      child: RichText(
                          maxLines: 2,
                          text: TextSpan(children: [
                            TextSpan(
                                text:
                                    "${S.of(context).validation_accepted_checkbox.split('').join('\u200b')} ",
                                style: TextStyle(
                                    fontSize: 16.sp, color: Colors.white)),
                            TextSpan(
                                text: S
                                    .of(context)
                                    .userAgreement
                                    .split('')
                                    .join('\u200b'),
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.white),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.pushNamed(RouteNames.webviewPreview,
                                        queryParameters: {
                                          "url": UrlConfig.userAgreement,
                                          "title": S.of(context).userAgreement,
                                        });
                                  }),
                            TextSpan(
                                text:
                                    " ${S.of(context).and.split('').join('\u200b')} ",
                                style: TextStyle(
                                    fontSize: 16.sp, color: Colors.white)),
                            TextSpan(
                                text: S.of(context).privacyPolicy,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.white),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.pushNamed(RouteNames.webviewPreview,
                                        queryParameters: {
                                          "url": UrlConfig.privacyPolicy,
                                          "title":
                                              S.of(context).privacyPolicyTitle,
                                        });
                                  }),
                          ])),
                    ),
                  ),
                ],
              ),
              10.verticalSpace,
              NeonCutCornerButton(
                  isLoading: isRegistering,
                  onPressed: () => context.read<AuthCubit>().register(),
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
                      if (!isRegistering)
                        SvgPicture.asset(
                          "assets/images/icons/arrow-right-outline.svg",
                          width: 18.w,
                          height: 18.h,
                        )
                    ],
                  )),
              20.verticalSpace,
              AuthHintText(text: S.of(context).form_enterNicknameInstruction),
              10.verticalSpace,

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
        return state.registerState.whenOrNull(failure: (failure) {
              switch (failure) {
                case RegisterFailure.agreementNotConfirmed:
                  return AuthHintText(
                      text:
                          S.of(context).pleaseConfirmAgreementAndPrivacyPolicy);
                case RegisterFailure.nicknameInvalid:
                  return AuthHintText(
                      text: S.of(context).validation_nicknameEmpty);
                case RegisterFailure.inviteCodeInvalid:
                  return AuthHintText(
                      text: S.of(context).validation_inviteCodeInvalid);
                case RegisterFailure.paymentPinInvalid:
                  return AuthHintText(
                      text: S.of(context).validation_paymentPinInvalid);
                case RegisterFailure.createWalletFail:
                  return AuthHintText(text: S.of(context).createWalletFail);
                case RegisterFailure.walletUserExist:
                  return AuthHintText(text: S.of(context).walletUserExist);
                case RegisterFailure.walletPinInvalid:
                  return AuthHintText(text: S.of(context).walletPinInvalid);
                default:
                  return const SizedBox.shrink();
              }
            }) ??
            const SizedBox.shrink();
      },
    );
  }
}
