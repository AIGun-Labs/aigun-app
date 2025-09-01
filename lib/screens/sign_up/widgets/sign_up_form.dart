import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/enums/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/widgets/button.dart';
import 'package:flutter_aigun/widgets/form_error_message.dart';
import 'package:flutter_aigun/widgets/input.dart';
import 'package:flutter_aigun/widgets/loading_indicator/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  SignUpFormState createState() => SignUpFormState();
}

class SignUpFormState extends State<SignUpForm> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<SignUpCubit, SignUpState>(
          builder: (context, state) {
            final signUpCubit = context.read<SignUpCubit>();
            return Column(
              children: [
                CustomInput(
                  hintText: S.of(context).form_email,
                  onChanged: (value) {
                    signUpCubit.updateEmail(value);
                  },
                ),
                SizedBox(height: 12.h),
                CustomInput(
                  hintText: S.of(context).form_nickname,
                  onChanged: (value) {
                    signUpCubit.updateNickname(value);
                  },
                ),
                SizedBox(height: 12.h),
                CustomInput(
                  hintText: S.of(context).form_password,
                  isPassword: true,
                  onChanged: (value) {
                    signUpCubit.updatePassword(value);
                  },
                ),
                SizedBox(height: 12.h),
                CustomInput(
                  hintText: S.of(context).form_confirmPassword,
                  isPassword: true,
                  onChanged: (value) {
                    signUpCubit.updateConfirmPassword(value);
                  },
                ),
              ],
            );
          },
        ),
        SizedBox(height: 20.h),
        BlocBuilder<SignUpCubit, SignUpState>(
          builder: (context, state) {
            return CustomButton(
              fontSize: 20.sp,
              onPressed: state.isEmailCheckLoading
                  ? null
                  : () async {
                      if (!context.read<SignUpCubit>().validateForm(() {})) {
                        return;
                      }

                      final isEmailExists =
                          await context.read<SignUpCubit>().checkEmailExists();

                      if (!context.mounted) return;

                      if (!isEmailExists) {
                        context.push(
                          Routes.checkYourEmail,
                          extra: VerificationType.register.type,
                        );
                      }
                    },
              child: state.isEmailCheckLoading
                  ? LoadingIndicator(size: 20.w)
                  : Text(S.of(context).common_next),
            );
          },
        ),
        SizedBox(height: 20.h),
        FormErrorMessage(text: S.of(context).validation_passwordTooSimple),
        BlocBuilder<SignUpCubit, SignUpState>(
          builder: (context, state) {
            if (state.emailError != null) {
              return FormErrorMessage(error: state.emailError);
            }

            if (state.nicknameError != null) {
              return FormErrorMessage(error: state.nicknameError);
            }

            // if (state.passwordError != null) {
            //   return FormErrorMessage(error: state.passwordError);
            // }

            if (state.confirmPasswordError != null) {
              return FormErrorMessage(error: state.confirmPasswordError);
            }

            if (state.message != null) {
              return FormErrorMessage(text: state.message!);
            }

            if (state.isEmailExists) {
              return FormErrorMessage(
                  text: S.of(context).validation_emailExists);
            }

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
