import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/forget_password/forgot_password_cubit.dart';
import 'package:flutter_aigun/cubits/forget_password/forgot_password_state.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/widgets/appbar.dart';
import 'package:flutter_aigun/widgets/background_with_overlay.dart';
import 'package:flutter_aigun/widgets/bottom_logo.dart';
import 'package:flutter_aigun/widgets/button.dart';
import 'package:flutter_aigun/widgets/form_error_message.dart';
import 'package:flutter_aigun/widgets/toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/password_input_fields.dart';
import 'widgets/success_dialog.dart';

class UpdateYourPasswordScreen extends StatefulWidget {
  const UpdateYourPasswordScreen({super.key});

  @override
  UpdateYourPasswordScreenState createState() =>
      UpdateYourPasswordScreenState();
}

class UpdateYourPasswordScreenState extends State<UpdateYourPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(
        backgroundColor: Colors.transparent,
        leadingIconColor: Colors.white,
      ),
      body: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state.isError && state.errorMessage != null) {
            showSimpleToast(state.errorMessage!);
          }

          if (state.isSuccess) {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return const SuccessDialog();
              },
            );
            context.read<ForgotPasswordCubit>().reset();
          }
        },
        child: BackgroundWithOverlay(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16.0.w),
                  child: _buildContent(context),
                ),
              ),
              const BottomLogo(),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          S.of(context).authFlow_updateYourPassword,
          style: TextStyle(
            fontSize: 24.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20.h),
        const PasswordInputFields(),
        SizedBox(height: 38.h),
        BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
          builder: (context, state) {
            return CustomButton(
              onPressed: state.newPassword.isNotEmpty &&
                      state.confirmPassword.isNotEmpty &&
                      state.newPasswordError == null &&
                      state.confirmPasswordError == null
                  ? () {
                      context.read<ForgotPasswordCubit>().sendResetPassword();
                    }
                  : null,
              text: S.of(context).authFlow_saveChanges,
              fontSize: 20.sp,
            );
          },
        ),
        SizedBox(height: 30.h),
        BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
          builder: (context, state) {
            if (state.newPasswordError != null) {
              return FormErrorMessage(
                error: state.newPasswordError,
              );
            }

            if (state.confirmPasswordError != null) {
              return FormErrorMessage(
                error: state.confirmPasswordError,
              );
            }

            if (state.isError && state.errorMessage != null) {
              return FormErrorMessage(
                text: state.errorMessage!,
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
