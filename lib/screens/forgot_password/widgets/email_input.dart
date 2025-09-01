import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/forget_password/forgot_password_cubit.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/widgets/input.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomInput(
      hintText: S.of(context).auth_form_input_email,
      onChanged: (value) {
        context.read<ForgotPasswordCubit>().updateEmail(value);
      },
    );
  }
}
