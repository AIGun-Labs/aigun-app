import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/screens/sign_in/cubit/sign_in_cubit.dart';
import 'package:flutter_aigun/screens/sign_in/cubit/sign_in_state.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/widgets/input.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginFormFields extends StatelessWidget {
  const LoginFormFields({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      buildWhen: (previous, current) =>
          previous.email != current.email ||
          previous.password != current.password,
      builder: (context, state) {
        return Column(
          children: [
            _buildEmailTextField(context, state.email),
            _buildDivider(context),
            _buildPasswordTextField(context, state.password),
          ],
        );
      },
    );
  }

  Widget _buildEmailTextField(BuildContext context, String email) {
    return CustomInput(
      hintText: S.of(context).form_email,
      isPassword: false,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15.r),
        topRight: Radius.circular(15.r),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.r),
          topRight: Radius.circular(15.r),
        ),
      ),
      onChanged: (value) => context.read<SignInCubit>().updateEmail(value),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Container(
      height: 1.h,
      color: AppColors.textTertiary(context),
    );
  }

  Widget _buildPasswordTextField(BuildContext context, String password) {
    return CustomInput(
      hintText: S.of(context).form_password,
      isPassword: true,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(15.r),
        bottomRight: Radius.circular(15.r),
      ),
      onChanged: (value) => context.read<SignInCubit>().updatePassword(value),
    );
  }
}
