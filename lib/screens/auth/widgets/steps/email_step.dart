import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_aigun/cubits/auth/auth_cubit.dart";
import "package:flutter_aigun/cubits/auth/auth_state.dart";
import "package:flutter_aigun/cubits/network/network_state.dart";
import "package:flutter_aigun/l10n/l10n.dart";
import "package:flutter_aigun/screens/auth/auth_steps.dart";
import "package:flutter_aigun/screens/auth/widgets/hint_text.dart";
import "package:flutter_aigun/screens/auth/widgets/login_page_layout.dart";
import "package:flutter_aigun/widgets/button/neon_button.dart";
import "package:flutter_aigun/widgets/input/neon_Input.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:fluttertoast/fluttertoast.dart";
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
          previous.event != current.event && current.event != null,
      listener: (context, state) {
        // listen state
        state.event?.whenOrNull(
          // show dialog
          showDialog: (titleKey, messageKey) => Fluttertoast.showToast(
            msg: messageKey,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
          ),
        );

        state.sendCodeStatus.whenOrNull(
          error: (error) => Fluttertoast.showToast(
            msg: error.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
          ),
        );

// prevent repeated trigger
        context.read<AuthCubit>().clearEvent();
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
    return BlocSelector<AuthCubit, AuthState, NetworkState<void>>(
      selector: (state) => state.sendCodeStatus,
      builder: (context, status) {
        final isLoading = status.maybeWhen(
          orElse: () => false,
          loading: () => true,
        );

        return NeonCutCornerButton(
          isLoading: isLoading,
          // backgroundColor: Theme.of(context).colorScheme.secondary,
          onPressed: () => {
            context.read<AuthCubit>().sendVerificationCode(
                  context,
                  () => onNext(AuthStep.verifyCode.stepIndex),
                )
          },
          child: Text(
            S.of(context).auth_form_signInSignUp,
            style: TextStyle(
              fontSize: EmailStep._fontSize.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}

class _InputEmail extends StatelessWidget {
  const _InputEmail({super.key});

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
            ),
          ],
        );
      },
    );
  }
}

class _EmailFormErrorMessage extends StatelessWidget {
  const _EmailFormErrorMessage({super.key});

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
