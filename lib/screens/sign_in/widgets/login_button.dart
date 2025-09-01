import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/screens/sign_in/cubit/sign_in_cubit.dart';
import 'package:flutter_aigun/screens/sign_in/cubit/sign_in_state.dart';
import 'package:flutter_aigun/widgets/button.dart';
import 'package:flutter_aigun/widgets/loading_indicator/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      buildWhen: (previous, current) => previous.isLoading != current.isLoading,
      builder: (context, state) {
        return CustomButton(
          onPressed: state.isLoading
              ? null
              : () {
                  context.read<SignInCubit>().signIn();
                  FocusScope.of(context).unfocus();
                },
          text: S.of(context).common_login,
          fontSize: 20.sp,
          textColor: Colors.black,
          child: state.isLoading ? const LoadingIndicator() : null,
        );
      },
    );
  }
}
