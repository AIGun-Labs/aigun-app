import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/forget_password/forgot_password_cubit.dart';
import 'package:flutter_aigun/enums/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/widgets/button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    final String? type = GoRouterState.of(context).extra as String?;

    if (type == VerificationType.register.type) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 16.w),
      child: CustomButton(
        onPressed: _handleContinueButtonPressed(context),
        text: S.of(context).authFlow_continueText,
        fontSize: 20.sp,
      ),
    );
  }

  VoidCallback? _handleContinueButtonPressed(BuildContext context) {
    final bool isCodeComplete =
        context.watch<ForgotPasswordCubit>().state.code.length == 6;
    return isCodeComplete
        ? () => context.push(Routes.updateYourPassword)
        : null;
  }
}
