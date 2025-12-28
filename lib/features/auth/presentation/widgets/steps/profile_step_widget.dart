import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../config/url.dart';
import '../../../../../core/router/constants.dart';
import '../../../../../core/utils/business_code_handler.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../themes/themes.dart';
import '../../../../../utils/format/input_formatters.dart';
import '../../../../../utils/toast.dart';
import '../../../../../widgets/button/neon_button.dart';
import '../../../../../widgets/input/neon_input.dart';
import '../../cubits/auth/auth_cubit.dart';
import '../../cubits/auth/auth_state.dart';
import '../../cubits/profile_step/profile_step_cubit.dart';
import '../../cubits/profile_step/profile_step_state.dart';
import '../common/auth_hint_text.dart';
import '../common/auth_page_layout.dart';

/// Profile Step Widget - Third step of authentication flow
///
/// Allows new users to set up their profile with nickname and optional invite code.
class ProfileStepWidget extends StatelessWidget {
  const ProfileStepWidget({super.key});

  void _handleRegister(BuildContext context) {
    final authState = BlocProvider.of<AuthCubit>(context).state;
    BlocProvider.of<ProfileStepCubit>(
      context,
    ).register(email: authState.email, code: authState.verificationCode);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileStepCubit, ProfileStepState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final authCubit = BlocProvider.of<AuthCubit>(context);

        state.status.whenOrNull(
          success: () {
            final authResult = state.authResult;
            if (authResult != null) {
              ToastUtils.showSuccessToast(
                context,
                message: S.of(context).registerSuccess,
              );
              authCubit.onRegisterSuccess(authResult);
            }
          },
          failure: (failure, errorCode) => switch (failure) {
            ProfileStepFailure.termsNotAgreed => null,
            ProfileStepFailure.inviteCodeInvalid => null,
            ProfileStepFailure.codeExpired => {
              ToastUtils.showFailureToast(
                context,
                message: BusinessCodeHandler.getErrorMessageFromBusinessCode(
                  context,
                  errorCode ?? 0,
                ),
              ),
              Future.delayed(
                const Duration(seconds: 2),
                () => authCubit.goToStep(AuthStep.email),
              ),
            },
            _ => ToastUtils.showFailureToast(
              context,
              message: BusinessCodeHandler.getErrorMessageFromBusinessCode(
                context,
                errorCode ?? 0,
              ),
            ),
          },
        );
      },
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return BlocBuilder<ProfileStepCubit, ProfileStepState>(
      builder: (context, state) {
        return AuthPageLayout(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNicknameInput(context),
              10.verticalSpace,
              _buildInviteCodeInput(context),
              10.verticalSpace,
              _buildAgreementCheckbox(context, state),
              10.verticalSpace,
              _buildRegisterButton(context, state),
              10.verticalSpace,
              _buildErrorMessage(context),
              20.verticalSpace,
              AuthHintText(text: S.of(context).form_enterNicknameInstruction),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNicknameInput(BuildContext context) {
    return NeonInputField(
      hintText: S.of(context).form_inputNickname,
      inputFormatters: InputFormatters.nicknameInputFormatters(),
      onChanged: (value) {
        context.read<ProfileStepCubit>().nicknameChanged(value);
      },
    );
  }

  Widget _buildInviteCodeInput(BuildContext context) {
    return NeonInputField(
      hintText: S.of(context).form_inputInviteCode,
      inputFormatters: InputFormatters.inviteCodeInputFormatters(),
      onChanged: (value) {
        BlocProvider.of<AuthCubit>(context).inviteCodeChanged(value);
      },
    );
  }

  Widget _buildAgreementCheckbox(BuildContext context, ProfileStepState state) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          value: state.hasAgreedToTerms,
          fillColor: WidgetStateProperty.all(AppColors.primary),
          visualDensity: VisualDensity.compact,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onChanged: (value) => BlocProvider.of<ProfileStepCubit>(
            context,
          ).termsAgreementChanged(value ?? false),
        ),
        4.horizontalSpace,
        Expanded(
          child: GestureDetector(
            onTap: () => BlocProvider.of<ProfileStepCubit>(
              context,
            ).termsAgreementChanged(!state.hasAgreedToTerms),
            child: RichText(
              maxLines: 2,
              text: TextSpan(
                children: [
                  TextSpan(
                    text:
                        '${S.of(context).validation_accepted_checkbox.split('').join('\u200b')} ',
                    style: TextStyle(fontSize: 16.sp, color: Colors.white),
                  ),
                  TextSpan(
                    text: S.of(context).userAgreement.split('').join('\u200b'),
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.pushNamed(
                          RouteNames.webviewPreview,
                          queryParameters: {
                            'url': UrlConfig.userAgreement,
                            'title': S.of(context).userAgreement,
                          },
                        );
                      },
                  ),
                  TextSpan(
                    text: ' ${S.of(context).and.split('').join('\u200b')} ',
                    style: TextStyle(fontSize: 16.sp, color: Colors.white),
                  ),
                  TextSpan(
                    text: S.of(context).privacyPolicy,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.pushNamed(
                          RouteNames.webviewPreview,
                          queryParameters: {
                            'url': UrlConfig.privacyPolicy,
                            'title': S.of(context).privacyPolicyTitle,
                          },
                        );
                      },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterButton(BuildContext context, ProfileStepState state) {
    return NeonCutCornerButton(
      isLoading: state.isRegistering,
      onPressed: () => _handleRegister(context),
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
          if (!state.isRegistering)
            SvgPicture.asset(
              // 'assets/images/icons/arrow-right-outline.svg',
              Assets.images.icons.arrowRightOutline,
              width: 18.w,
              height: 18.h,
            ),
        ],
      ),
    );
  }

  Widget _buildErrorMessage(BuildContext context) {
    return BlocSelector<ProfileStepCubit, ProfileStepState, ProfileStepStatus>(
      selector: (state) => state.status,
      builder: (context, status) {
        return status.maybeWhen(
          failure: (failure, _) => switch (failure) {
            ProfileStepFailure.termsNotAgreed => AuthHintText(
              text: S.of(context).pleaseConfirmAgreementAndPrivacyPolicy,
            ),
            ProfileStepFailure.inviteCodeInvalid => AuthHintText(
              text: S.of(context).validation_inviteCodeInvalid,
            ),
            _ => const SizedBox.shrink(),
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
