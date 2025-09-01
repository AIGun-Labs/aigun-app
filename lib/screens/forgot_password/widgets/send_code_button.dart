import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/enums/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/screens/forgot_password/widgets/unregistered_bottom_sheet.dart';
import 'package:flutter_aigun/widgets/button.dart';
import 'package:flutter_aigun/widgets/loading_indicator/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SendCodeButton extends StatelessWidget {
  const SendCodeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
        builder: (context, state) {
      return CustomButton(
        onPressed: state.isEmailCheckLoading
            ? null
            : () async {
                final cubit = context.read<ForgotPasswordCubit>();
                final navigatorContext = context;
                final isEmailValid = cubit.validateEmail();

                if (!isEmailValid) return;

                final isEmailExists = await cubit.checkEmailExists();

                if (!navigatorContext.mounted) return;

                if (isEmailExists) {
                  navigatorContext.push(
                    Routes.checkYourEmail,
                    extra: VerificationType.resetPassword.type,
                  );
                } else {
                  showModalBottomSheet(
                    context: navigatorContext,
                    builder: (context) => const UnregisteredBottomSheet(),
                  );
                }
              },
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 20.sp,
        width: double.infinity,
        child: state.isEmailCheckLoading
            ? LoadingIndicator(size: 20.w)
            : Text(S.of(context).authFlow_sendCode),
      );
    });
  }
}
