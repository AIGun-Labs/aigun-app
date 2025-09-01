import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/config/nav.dart';
import 'package:flutter_aigun/core/service_locator.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/enums/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/screens/check_your_email/cubit/verification_cubit.dart';
import 'package:flutter_aigun/screens/check_your_email/cubit/verification_state.dart';
import 'package:flutter_aigun/screens/check_your_email/widgets/check_your_email_content.dart';
import 'package:flutter_aigun/widgets/appbar.dart';
import 'package:flutter_aigun/widgets/background_with_overlay.dart';
import 'package:flutter_aigun/widgets/bottom_logo.dart';
import 'package:flutter_aigun/widgets/toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CheckYourEmailScreen extends StatelessWidget {
  const CheckYourEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final type = GoRouterState.of(context).extra as String?;
    final email = type == VerificationType.register.type
        ? context.watch<SignUpCubit>().state.email
        : context.watch<ForgotPasswordCubit>().state.email;

    return BlocProvider(
      create: (context) => getIt<VerificationCubit>(
        param1: email,
        param2: type ?? '',
      ),
      child: MultiBlocListener(
        listeners: [
          BlocListener<VerificationCubit, VerificationState>(
            listener: (context, state) {
              if (state.errorCode != null) {
                showSimpleToast(
                  S.of(context).authMessages_verificationFailed,
                );
              }
            },
          ),
          BlocListener<SignUpCubit, SignUpState>(
            listenWhen: (previous, current) =>
                previous.isSuccess != current.isSuccess ||
                previous.errorCode != current.errorCode ||
                previous.message != current.message,
            listener: (context, state) {
              // TODO: 需要删除掉这里的逻辑，只是为了兼容首个版本
              if (state.errorCode == 500) {
                showSimpleToast(S.of(context).authMessages_registrationSuccess);
                context.go(Routes.login);
                return;
              }

              if (state.isSuccess) {
                showSimpleToast(S.of(context).authMessages_registrationSuccess);
                context.go(Routes.home, extra: NavIndex.wallet);
                context.read<SignUpCubit>().reset();
              }

              if (state.errorCode != null) {
                switch (state.errorCode) {
                  case 400:
                    showSimpleToast(state.message as String);
                  // showSimpleToast(S.of(context).emailAlreadyRegistered);
                  case 401:
                    showSimpleToast(
                        S.of(context).validation_verificationCodeInvalid);
                  default:
                    showSimpleToast(state.message as String);
                }
                context.read<SignUpCubit>().resetError();
              }
            },
          ),
        ],
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          appBar: const CustomAppBar(
            backgroundColor: Colors.transparent,
            leadingIconColor: Colors.white,
          ),
          body: BackgroundWithOverlay(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16.0.w),
                    child: const CheckYourEmailContent(),
                  ),
                ),
                const BottomLogo(),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
