import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/config/nav.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/screens/sign_in/cubit/sign_in_state.dart';
import 'package:flutter_aigun/screens/sign_in/widgets/create_new_account.dart';
import 'package:flutter_aigun/widgets/background_with_overlay.dart';
import 'package:flutter_aigun/widgets/form_error_message.dart';
import 'package:flutter_aigun/widgets/toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'cubit/sign_in_cubit.dart';
import 'widgets/forgot_password_button.dart';
import 'widgets/login_form.dart';
import 'widgets/logo_section.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(),
      child: BlocListener<SignInCubit, SignInState>(
        listener: (context, state) {
          if (state.isSuccess) {
            showSimpleToast(
              S.of(context).authMessages_loginSuccess,
              alignment: Alignment.topCenter,
            );
            context.replace(
              Routes.home,
              extra: NavIndex.wallet,
            );
          }
        },
        child: const SignInView(),
      ),
    );
  }
}

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          BackgroundWithOverlay(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0.w),
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                    const LogoSection(),
                    SizedBox(height: 70.h),
                    const LoginForm(),
                    SizedBox(height: 10.h),
                    const ForgotPasswordButton(),
                    BlocBuilder<SignInCubit, SignInState>(
                      builder: (context, state) {
                        if (state.emailError != null) {
                          return FormErrorMessage(error: state.emailError);
                        }

                        if (state.passwordError != null) {
                          return FormErrorMessage(error: state.passwordError);
                        }

                        if (state.message != null) {
                          return FormErrorMessage(text: state.message!);
                        }

                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).viewPadding.bottom + 10.w,
            left: 0,
            right: 0,
            child: const CreateNewAccount(),
          ),
        ],
      ),
    );
  }
}
